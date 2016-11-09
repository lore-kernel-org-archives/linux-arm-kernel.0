From: minyard@acm.org (Corey Minyard)
Date: Wed, 9 Nov 2016 09:52:03 -0600
Subject: [PATCH 2/3] ipmi/bt-bmc: maintain a request expiry list
In-Reply-To: <6117c1fd-b969-9394-0be5-d46f64269cac@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-3-git-send-email-clg@kaod.org>
 <a7aea2a7-6cb4-655e-3c69-1a156945e27b@acm.org>
 <6117c1fd-b969-9394-0be5-d46f64269cac@kaod.org>
Message-ID: <1e0187c4-d503-ce4a-3d4c-cf21f0bffb96@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2016 08:30 AM, C?dric Le Goater wrote:
> On 11/07/2016 08:04 PM, Corey Minyard wrote:
>> On 11/02/2016 02:57 AM, C?dric Le Goater wrote:
>>> Regarding the response expiration handling, the IPMI spec says :
>>>
>>>      The BMC must not return a given response once the corresponding
>>>      Request-to-Response interval has passed. The BMC can ensure this
>>>      by maintaining its own internal list of outstanding requests through
>>>      the interface. The BMC could age and expire the entries in the list
>>>      by expiring the entries at an interval that is somewhat shorter than
>>>      the specified Request-to-Response interval....
>>>
>>> To handle such case, we maintain list of received requests using the
>>> seq number of the BT message to identify them. The list is updated
>>> each time a request is received and a response is sent. The expiration
>>> of the reponses is handled at each updates but also with a timer.
>> This looks correct, but it seems awfully complicated.
>>
>> Why can't you get the current time before the wait_event_interruptible()
>> and then compare the time before you do the write?  That would seem to
>> accomplish the same thing without any lists or extra locks.
> Well, the expiry list needs a request identifier and it is currently using
> the Seq byte for this purpose. So the BT message needs to be read to grab
> that byte. The request is added to a list and that involves some locking.
>
> When the response is written, the first matching request is removed from
> the list and a garbage collector loop is also run. Then, as we might not
> get any responses to run that loop, we use a timer to empty the list from
> any expired requests.
>
> The read/write ops of the driver are protected with a mutex, the list and
> the timer add their share of locking. That could have been done with RCU
> surely but we don't really need performance in this driver.
>
> Caveats :
>
> bt_bmc_remove_request() should not be done in the writing loop though.
> It needs a fix.
>
> The request identifier is currently Seq but the spec say we should use
> Seq, NetFn, and Command or an internal Seq value as a request identifier.
> Google is also working on an OEM/Group extension (Brendan in CC: )
> which has a different message format. I need to look closer at what
> should be done in this case.

I'm still not sure why the list is necessary.  You have a separate
thread of execution for each writer, why not just time it in that
thread?

What about the following, not even compile-tested, patch?  I'm
sure my mailer will munge this up, I can send you a clean version
if you like.

 From 1a73585a9c1c74ac1d59d82f22e05b30447619a6 Mon Sep 17 00:00:00 2001
From: Corey Minyard <cminyard@mvista.com>
Date: Wed, 9 Nov 2016 09:07:48 -0600
Subject: [PATCH] ipmi:bt-bmc: Fix a multi-user race, time out responses

The IPMI spec says to time out responses after a given amount of
time, so don't let a writer send something after an amount of time
has elapsed.

Also, fix a race condition in the same area where if you have two
writers at the same time, one can get a EIO return when it should
still be waiting its turn to send.  A mutex_lock_interruptible_timeout()
would be handy here, but it doesn't exist.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
  drivers/char/ipmi/bt-bmc.c | 39 ++++++++++++++++++++++++---------------
  1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index b49e613..5be94cf 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -57,6 +57,8 @@

  #define BT_BMC_BUFFER_SIZE 256

+#define BT_BMC_RESPONSE_JIFFIES    (5 * HZ)
+
  struct bt_bmc {
      struct device        dev;
      struct miscdevice    miscdev;
@@ -190,14 +192,12 @@ static ssize_t bt_bmc_read(struct file *file, char 
__user *buf,

      WARN_ON(*ppos);

-    if (wait_event_interruptible(bt_bmc->queue,
-                     bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN))
+    if (mutex_lock_interruptible(&bt_bmc->mutex))
          return -ERESTARTSYS;

-    mutex_lock(&bt_bmc->mutex);
-
-    if (unlikely(!(bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN))) {
-        ret = -EIO;
+    if (wait_event_interruptible(bt_bmc->queue,
+                bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN)) {
+        ret = -ERESTARTSYS;
          goto out_unlock;
      }

@@ -251,6 +251,7 @@ static ssize_t bt_bmc_write(struct file *file, const 
char __user *buf,
      u8 kbuffer[BT_BMC_BUFFER_SIZE];
      ssize_t ret = 0;
      ssize_t nwritten;
+    unsigned long start_jiffies = jiffies, wait_time;

      /*
       * send a minimum response size
@@ -263,23 +264,31 @@ static ssize_t bt_bmc_write(struct file *file, 
const char __user *buf,

      WARN_ON(*ppos);

+    if (mutex_lock_interruptible(&bt_bmc->mutex))
+        return -ERESTARTSYS;
+
+    wait_time = jiffies - start_jiffies;
+    if (wait_time >= BT_BMC_RESPONSE_TIME_JIFFIES) {
+        ret = -ETIMEDOUT;
+        goto out_unlock;
+    }
+    wait_time = BT_BMC_RESPONSE_TIME_JIFFIES - wait_time;
+
      /*
       * There's no interrupt for clearing bmc busy so we have to
       * poll
       */
-    if (wait_event_interruptible(bt_bmc->queue,
+    ret = wait_event_interruptible_timeout(bt_bmc->queue,
                       !(bt_inb(bt_bmc, BT_CTRL) &
-                       (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN))))
-        return -ERESTARTSYS;
-
-    mutex_lock(&bt_bmc->mutex);
-
-    if (unlikely(bt_inb(bt_bmc, BT_CTRL) &
-             (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN))) {
-        ret = -EIO;
+                       (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN)),
+                     wait_time);
+    if (ret <= 0) {
+        if (ret == 0)
+            ret = -ETIMEDOUT;
          goto out_unlock;
      }

+    ret = 0;
      clr_wr_ptr(bt_bmc);

      while (count) {
-- 
2.7.4



>> Also, if you are going to have multiple writers on this interface, I don't
>> think the interface will work correctly.  I think you need to claim the
>> mutex first.  Otherwise you might get into a situation where two writers
>> will wake up at the same time, the first writes and releases the mutex,
>> then the second will find that the interface is busy and fail.
> yes. that is a current problem in the driver and it is not really an
> elegant way to handle concurrency. We are fine for the moment as we
> only have one single threaded process using the device.
>
>> If I am correct, the mutex will need to become interruptible and come
>> first, I think.  (And the timing would have to start before the mutex,
>> of course.)  This applies to both the read and write interface.
> OK. I will look into fixing this problem first.
>
>> Another thing is that this is request-to-release time.  If a request takes
>> a long time to process (say, a write to a flash device) the timeout would
>> need to be decreased by the processing time.
> Hmm, how would that fit with the "BT Interface Capabilities" which
> defines :
>
>    BMC Request-to-Response time, in seconds, 1 based. 30 seconds, maximum.
>
> This is a fixed value. And the spec only say :
>
>    The BMC could age and expire the entries in the list by expiring
>    the entries at an interval that is somewhat shorter than the
>    specified Request-to-Response interval.
>
> May be I am misunderstanding.

Yeah, as usual, the IPMI spec is kind of vague about this.  You have
to think about the problem from the host driver's point of view to
know what this means.

 From a host driver point of view, it's going to send a request and wait
for a response with the same sequence number.  It should time out the
request in "BMC Request-to-Response time" seconds.  After that point,
it's free to re-use the sequence number.  So what a BMC cannot do is
send that response after the timeout.

If the timeout is 5 seconds, and the BMC gets a flash write request that
takes 3 seconds then sits waiting for 2 seconds, it should not send the
response because the host driver may mistake it for a request it just
sent.  So the timeout should be based on when the BMC got the request,
not when the response was queued for write, and that's the reason that
the BMC timer should be somewhat shorter than the host timer, as it
says.

I don't see an easy way to do this.  Some possibilities I can think of are:

  * Switch to using an ioctl to do the read/write operation. That's
    kind of ugly.  It's what the IPMI driver interface does, and it
    has been somewhat of a pain.
  * You could define a "header" that is put into the read message
    and write message.  You could add an ioctl to query the header
    size; if the ioctl fails then the driver doesn't have a header.
    Add a jiffie to the header of the read message that the
    BMC userland must put into the header of the write message.
    You could even have the ioctl enable the header, to preserve
    backwards compatibility.
  * Define some sort of structure that you read/write.  This has all
    sorts of issues.

I think my preference is the second, it allows for backwards
compatibility and lets the kernel do basically whatever it wants with
the data.


>> It's probably ok to not do that for the moment, but you may want to add
>> a note.  Fixing that would require adding a timeout for each message.
> Thanks,
>
> C.
>
>> -corey
>>
>>
>>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>>> ---
>>>    drivers/char/ipmi/bt-bmc.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 132 insertions(+)
>>>
>>> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
>>> index fc9e8891eae3..e751e4a754b7 100644
>>> --- a/drivers/char/ipmi/bt-bmc.c
>>> +++ b/drivers/char/ipmi/bt-bmc.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/platform_device.h>
>>>    #include <linux/poll.h>
>>>    #include <linux/sched.h>
>>> +#include <linux/slab.h>
>>>    #include <linux/timer.h>
>>>      /*
>>> @@ -57,6 +58,15 @@
>>>      #define BT_BMC_BUFFER_SIZE 256
>>>    +#define BT_BMC_RESPONSE_TIME    5 /* seconds */
>>> +
>>> +struct ipmi_request {
>>> +    struct list_head list;
>>> +
>>> +    u8 seq;
>>> +    unsigned long expires;
>>> +};
>>> +
>>>    struct bt_bmc {
>>>        struct device        dev;
>>>        struct miscdevice    miscdev;
>>> @@ -65,6 +75,11 @@ struct bt_bmc {
>>>        wait_queue_head_t    queue;
>>>        struct timer_list    poll_timer;
>>>        struct mutex        mutex;
>>> +
>>> +    unsigned int        response_time;
>>> +    struct timer_list    requests_timer;
>>> +    spinlock_t              requests_lock;
>>> +    struct list_head        requests;
>>>    };
>>>      static atomic_t open_count = ATOMIC_INIT(0);
>>> @@ -163,6 +178,94 @@ static int bt_bmc_open(struct inode *inode, struct file *file)
>>>    }
>>>      /*
>>> + * lock should be held
>>> + */
>>> +static void drop_expired_requests(struct bt_bmc *bt_bmc)
>>> +{
>>> +    unsigned long flags = 0;
>>> +    struct ipmi_request *req, *next;
>>> +    unsigned long next_expires = 0;
>>> +    int start_timer = 0;
>>> +
>>> +    spin_lock_irqsave(&bt_bmc->requests_lock, flags);
>>> +    list_for_each_entry_safe(req, next, &bt_bmc->requests, list) {
>>> +        if (time_after_eq(jiffies, req->expires)) {
>>> +            pr_warn("BT: request seq:%d has expired. dropping\n",
>>> +                req->seq);
>>> +            list_del(&req->list);
>>> +            kfree(req);
>>> +            continue;
>>> +        }
>>> +        if (!start_timer) {
>>> +            start_timer = 1;
>>> +            next_expires = req->expires;
>>> +        } else {
>>> +            next_expires = min(next_expires, req->expires);
>>> +        }
>>> +    }
>>> +    spin_unlock_irqrestore(&bt_bmc->requests_lock, flags);
>>> +
>>> +    /* and possibly restart */
>>> +    if (start_timer)
>>> +        mod_timer(&bt_bmc->requests_timer, next_expires);
>>> +}
>>> +
>>> +static void requests_timer(unsigned long data)
>>> +{
>>> +    struct bt_bmc *bt_bmc = (void *)data;
>>> +
>>> +    drop_expired_requests(bt_bmc);
>>> +}
>>> +
>>> +static int bt_bmc_add_request(struct bt_bmc *bt_bmc, u8 seq)
>>> +{
>>> +    struct ipmi_request *req;
>>> +
>>> +    req = kmalloc(sizeof(*req), GFP_KERNEL);
>>> +    if (!req)
>>> +        return -ENOMEM;
>>> +
>>> +    req->seq = seq;
>>> +    req->expires = jiffies +
>>> +        msecs_to_jiffies(bt_bmc->response_time * 1000);
>>> +
>>> +    spin_lock(&bt_bmc->requests_lock);
>>> +    list_add(&req->list, &bt_bmc->requests);
>>> +    spin_unlock(&bt_bmc->requests_lock);
>>> +
>>> +    drop_expired_requests(bt_bmc);
>>> +    return 0;
>>> +}
>>> +
>>> +static int bt_bmc_remove_request(struct bt_bmc *bt_bmc, u8 seq)
>>> +{
>>> +    struct ipmi_request *req, *next;
>>> +    int ret = -EBADRQC; /* Invalid request code */
>>> +
>>> +    spin_lock(&bt_bmc->requests_lock);
>>> +    list_for_each_entry_safe(req, next, &bt_bmc->requests, list) {
>>> +        /*
>>> +         * The sequence number should be unique, so remove the
>>> +         * first matching request found. If there are others,
>>> +         * they should expire
>>> +         */
>>> +        if (req->seq == seq) {
>>> +            list_del(&req->list);
>>> +            kfree(req);
>>> +            ret = 0;
>>> +            break;
>>> +        }
>>> +    }
>>> +    spin_unlock(&bt_bmc->requests_lock);
>>> +
>>> +    if (ret)
>>> +        pr_warn("BT: request seq:%d is invalid\n", seq);
>>> +
>>> +    drop_expired_requests(bt_bmc);
>>> +    return ret;
>>> +}
>>> +
>>> +/*
>>>     * The BT (Block Transfer) interface means that entire messages are
>>>     * buffered by the host before a notification is sent to the BMC that
>>>     * there is data to be read. The first byte is the length and the
>>> @@ -231,6 +334,13 @@ static ssize_t bt_bmc_read(struct file *file, char __user *buf,
>>>            len_byte = 0;
>>>        }
>>>    +    if (ret > 0) {
>>> +        int ret2 = bt_bmc_add_request(bt_bmc, kbuffer[2]);
>>> +
>>> +        if (ret2)
>>> +            ret = ret2;
>>> +    }
>>> +
>>>        clr_b_busy(bt_bmc);
>>>      out_unlock:
>>> @@ -283,12 +393,20 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
>>>        clr_wr_ptr(bt_bmc);
>>>          while (count) {
>>> +        int ret2;
>>> +
>>>            nwritten = min_t(ssize_t, count, sizeof(kbuffer));
>>>            if (copy_from_user(&kbuffer, buf, nwritten)) {
>>>                ret = -EFAULT;
>>>                break;
>>>            }
>>>    +        ret2 = bt_bmc_remove_request(bt_bmc, kbuffer[2]);
>>> +        if (ret2) {
>>> +            ret = ret2;
>>> +            break;
>>> +        }
>>> +
>>>            bt_writen(bt_bmc, kbuffer, nwritten);
>>>              count -= nwritten;
>>> @@ -438,6 +556,8 @@ static int bt_bmc_probe(struct platform_device *pdev)
>>>          mutex_init(&bt_bmc->mutex);
>>>        init_waitqueue_head(&bt_bmc->queue);
>>> +    INIT_LIST_HEAD(&bt_bmc->requests);
>>> +    spin_lock_init(&bt_bmc->requests_lock);
>>>          bt_bmc->miscdev.minor    = MISC_DYNAMIC_MINOR,
>>>            bt_bmc->miscdev.name    = DEVICE_NAME,
>>> @@ -451,6 +571,8 @@ static int bt_bmc_probe(struct platform_device *pdev)
>>>          bt_bmc_config_irq(bt_bmc, pdev);
>>>    +    bt_bmc->response_time = BT_BMC_RESPONSE_TIME;
>>> +
>>>        if (bt_bmc->irq) {
>>>            dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>>>        } else {
>>> @@ -468,6 +590,9 @@ static int bt_bmc_probe(struct platform_device *pdev)
>>>              BT_CR0_ENABLE_IBT,
>>>              bt_bmc->base + BT_CR0);
>>>    +    setup_timer(&bt_bmc->requests_timer, requests_timer,
>>> +            (unsigned long)bt_bmc);
>>> +
>>>        clr_b_busy(bt_bmc);
>>>          return 0;
>>> @@ -476,10 +601,17 @@ static int bt_bmc_probe(struct platform_device *pdev)
>>>    static int bt_bmc_remove(struct platform_device *pdev)
>>>    {
>>>        struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
>>> +    struct ipmi_request *req, *next;
>>>          misc_deregister(&bt_bmc->miscdev);
>>>        if (!bt_bmc->irq)
>>>            del_timer_sync(&bt_bmc->poll_timer);
>>> +
>>> +    del_timer_sync(&bt_bmc->requests_timer);
>>> +    list_for_each_entry_safe(req, next, &bt_bmc->requests, list) {
>>> +        list_del(&req->list);
>>> +        kfree(req);
>>> +    }
>>>        return 0;
>>>    }
>>>    
>>
