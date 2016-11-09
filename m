From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Wed, 9 Nov 2016 20:08:31 +0100
Subject: [PATCH 2/3] ipmi/bt-bmc: maintain a request expiry list
In-Reply-To: <1e0187c4-d503-ce4a-3d4c-cf21f0bffb96@acm.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-3-git-send-email-clg@kaod.org>
 <a7aea2a7-6cb4-655e-3c69-1a156945e27b@acm.org>
 <6117c1fd-b969-9394-0be5-d46f64269cac@kaod.org>
 <1e0187c4-d503-ce4a-3d4c-cf21f0bffb96@acm.org>
Message-ID: <4d3a2e7e-ac95-65ae-5427-a23ca04d3817@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2016 04:52 PM, Corey Minyard wrote:
> On 11/09/2016 08:30 AM, C?dric Le Goater wrote:
>> On 11/07/2016 08:04 PM, Corey Minyard wrote:
>>> On 11/02/2016 02:57 AM, C?dric Le Goater wrote:
>>>> Regarding the response expiration handling, the IPMI spec says :
>>>>
>>>>      The BMC must not return a given response once the corresponding
>>>>      Request-to-Response interval has passed. The BMC can ensure this
>>>>      by maintaining its own internal list of outstanding requests through
>>>>      the interface. The BMC could age and expire the entries in the list
>>>>      by expiring the entries at an interval that is somewhat shorter than
>>>>      the specified Request-to-Response interval....
>>>>
>>>> To handle such case, we maintain list of received requests using the
>>>> seq number of the BT message to identify them. The list is updated
>>>> each time a request is received and a response is sent. The expiration
>>>> of the reponses is handled at each updates but also with a timer.
>>> This looks correct, but it seems awfully complicated.
>>>
>>> Why can't you get the current time before the wait_event_interruptible()
>>> and then compare the time before you do the write?  That would seem to
>>> accomplish the same thing without any lists or extra locks.
>> Well, the expiry list needs a request identifier and it is currently using
>> the Seq byte for this purpose. So the BT message needs to be read to grab
>> that byte. The request is added to a list and that involves some locking.
>>
>> When the response is written, the first matching request is removed from
>> the list and a garbage collector loop is also run. Then, as we might not
>> get any responses to run that loop, we use a timer to empty the list from
>> any expired requests.
>>
>> The read/write ops of the driver are protected with a mutex, the list and
>> the timer add their share of locking. That could have been done with RCU
>> surely but we don't really need performance in this driver.
>>
>> Caveats :
>>
>> bt_bmc_remove_request() should not be done in the writing loop though.
>> It needs a fix.
>>
>> The request identifier is currently Seq but the spec say we should use
>> Seq, NetFn, and Command or an internal Seq value as a request identifier.
>> Google is also working on an OEM/Group extension (Brendan in CC: )
>> which has a different message format. I need to look closer at what
>> should be done in this case.
> 
> I'm still not sure why the list is necessary.  You have a separate
> thread of execution for each writer, why not just time it in that
> thread?

No, we don't in the current design. This is only a single process 
acting as a proxy and dispatching commands on dbus to other
processes doing whatever they need to do. So the request/responses 
can interlace. 

The current daemon already handles an expiry list but I thought it 
would be better to move it in the kernel to have a better response
time. The BMC can be quite slow when busy. It seems that keeping
the logic in user space is better. So let's have it that way. Not
a problem.

> What about the following, not even compile-tested, patch?  I'm
> sure my mailer will munge this up, I can send you a clean version
> if you like.

No it is ok. I will give your fix a try on our system and resend.

Thanks,

C.  

 
> From 1a73585a9c1c74ac1d59d82f22e05b30447619a6 Mon Sep 17 00:00:00 2001
> From: Corey Minyard <cminyard@mvista.com>
> Date: Wed, 9 Nov 2016 09:07:48 -0600
> Subject: [PATCH] ipmi:bt-bmc: Fix a multi-user race, time out responses
> 
> The IPMI spec says to time out responses after a given amount of
> time, so don't let a writer send something after an amount of time
> has elapsed.
> 
> Also, fix a race condition in the same area where if you have two
> writers at the same time, one can get a EIO return when it should
> still be waiting its turn to send.  A mutex_lock_interruptible_timeout()
> would be handy here, but it doesn't exist.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/char/ipmi/bt-bmc.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index b49e613..5be94cf 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -57,6 +57,8 @@
> 
>  #define BT_BMC_BUFFER_SIZE 256
> 
> +#define BT_BMC_RESPONSE_JIFFIES    (5 * HZ)
> +
>  struct bt_bmc {
>      struct device        dev;
>      struct miscdevice    miscdev;
> @@ -190,14 +192,12 @@ static ssize_t bt_bmc_read(struct file *file, char __user *buf,
> 
>      WARN_ON(*ppos);
> 
> -    if (wait_event_interruptible(bt_bmc->queue,
> -                     bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN))
> +    if (mutex_lock_interruptible(&bt_bmc->mutex))
>          return -ERESTARTSYS;
> 
> -    mutex_lock(&bt_bmc->mutex);
> -
> -    if (unlikely(!(bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN))) {
> -        ret = -EIO;
> +    if (wait_event_interruptible(bt_bmc->queue,
> +                bt_inb(bt_bmc, BT_CTRL) & BT_CTRL_H2B_ATN)) {
> +        ret = -ERESTARTSYS;
>          goto out_unlock;
>      }
> 
> @@ -251,6 +251,7 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
>      u8 kbuffer[BT_BMC_BUFFER_SIZE];
>      ssize_t ret = 0;
>      ssize_t nwritten;
> +    unsigned long start_jiffies = jiffies, wait_time;
> 
>      /*
>       * send a minimum response size
> @@ -263,23 +264,31 @@ static ssize_t bt_bmc_write(struct file *file, const char __user *buf,
> 
>      WARN_ON(*ppos);
> 
> +    if (mutex_lock_interruptible(&bt_bmc->mutex))
> +        return -ERESTARTSYS;
> +
> +    wait_time = jiffies - start_jiffies;
> +    if (wait_time >= BT_BMC_RESPONSE_TIME_JIFFIES) {
> +        ret = -ETIMEDOUT;
> +        goto out_unlock;
> +    }
> +    wait_time = BT_BMC_RESPONSE_TIME_JIFFIES - wait_time;
> +
>      /*
>       * There's no interrupt for clearing bmc busy so we have to
>       * poll
>       */
> -    if (wait_event_interruptible(bt_bmc->queue,
> +    ret = wait_event_interruptible_timeout(bt_bmc->queue,
>                       !(bt_inb(bt_bmc, BT_CTRL) &
> -                       (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN))))
> -        return -ERESTARTSYS;
> -
> -    mutex_lock(&bt_bmc->mutex);
> -
> -    if (unlikely(bt_inb(bt_bmc, BT_CTRL) &
> -             (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN))) {
> -        ret = -EIO;
> +                       (BT_CTRL_H_BUSY | BT_CTRL_B2H_ATN)),
> +                     wait_time);
> +    if (ret <= 0) {
> +        if (ret == 0)
> +            ret = -ETIMEDOUT;
>          goto out_unlock;
>      }
> 
> +    ret = 0;
>      clr_wr_ptr(bt_bmc);
> 
>      while (count) {
