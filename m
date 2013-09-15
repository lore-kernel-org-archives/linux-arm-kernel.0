From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sun, 15 Sep 2013 09:52:33 +0530
Subject: [RFC PATCH 1/3] Enable BCM2835 mailbox support
In-Reply-To: <52352957.1070904@yahoo.com.au>
References: <5232F7B7.4070206@yahoo.com.au>
	<52352957.1070904@yahoo.com.au>
Message-ID: <CAJe_ZhdnA0bx=gorj+RUTo4brHYtuGTKw8ygAvskN+mGHoAKfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 September 2013 08:58, Craig McGeachie <slapdau@yahoo.com.au> wrote:
> On 09/13/2013 11:32 PM, Craig McGeachie wrote:
>> Cherry-picked selection of commits by Lubomir Rintel [1], Suman Anna and
>> Jassi Brar [2] on which to base the implementation.
>>
>> Signed-off-by: Suman Ana <s-anna@ti.com>
>> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>>
>> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
>> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
>
> There are two problems with the mailbox framework that I can find.
> The first is in ipc_send_message.  On the BCM2835, the mailbox send
> result doesn't trigger an interrupt, but the pending reply does. When
> ipc_request_channel is called without blocking, the flow of events
> looks like this:
> [    0.521312] req - cf9845c0: 00000020 00000000 00030006 00000008
> [    0.527245] req - cf9845d0: 00000008 00000000 00000000 00000000
> [    0.533248] bcm2835-mbox 2000b880.mailbox: Request 0x0F9845C8
> [    0.539007] bcm2835-mbox 2000b880.mailbox: Reply 0x0F9845C8
> [    0.544582] bcm2835_thermal thermal.1: rxcb #1 @0f9845c0
> [    0.549939] bcm2835-mbox 2000b880.mailbox: Polling
> [    0.554773] bcm2835_thermal thermal.1: txcb #1 @0f9845c0
> [    0.560102] rep - cf9845c0: 00000020 80000000 00030006 00000008
> [    0.566062] rep - cf9845d0: 80000008 00000000 000078da 00000000
>
> I've never seen the transmit callback come first.
>
> When ipc_request_channel is called with blocking, then the best result
> I've had a null pointer causing a kernel panic.  Most of the time, the
> system just deadlocks.  The fix is:
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index c4ef608..08fae83 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -202,6 +202,7 @@ request_token_t ipc_send_message(void *channel, void *mssg)
>         if (!t)
>                 pr_err("Try increasing MBOX_TX_QUEUE_LEN\n");
>
> +       init_completion(&chan->tx_complete);
>         _msg_submit(chan);
>
>         if (chan->txdone_method == TXDONE_BY_POLL)
> @@ -209,7 +210,6 @@ request_token_t ipc_send_message(void *channel, void *mssg)
>
>         if (chan->tx_block && chan->active_req) {
>                 int ret;
> -               init_completion(&chan->tx_complete);
>                 ret = wait_for_completion_timeout(&chan->tx_complete,
>                         chan->tx_tout);
>                 if (ret == 0) {
>
> When the init_completion is done after the _msg_submit, it might be executed
> after the complete in tx_tick.  And for the BCM2835, it's pretty reliable that
> this will happen. When this happens, the calls are:
>  1. complete
>  2. init_completion
>  3. wait_for_completion_timeout
>
> The complete call is missed.
>
> With this fix in place, the flow of events now looks like:
> [    0.521214] req - cf9845c0: 00000020 00000000 00030006 00000008
> [    0.527149] req - cf9845d0: 00000008 00000000 00000000 00000000
> [    0.533149] bcm2835-mbox 2000b880.mailbox: Request 0x0F9845C8
> [    0.538908] bcm2835-mbox 2000b880.mailbox: Reply 0x0F9845C8
> [    0.544482] bcm2835_thermal thermal.1: rxcb #1 @0f9845c0
> [    0.549840] bcm2835-mbox 2000b880.mailbox: Polling
> [    0.554686] rep - cf9845c0: 00000020 80000000 00030006 00000008
> [    0.560648] rep - cf9845d0: 80000008 00000000 0000835c 00000000
>
LF.Tan already provided the same patch (and another) a few weeks ago.
I have it locally but it should be pushed soon.

commit 28785f7c4af687026e601e0a7328414de43c84b3
Author: LeyFoon Tan <lftan.linux@gmail.com>
Date:   Tue Aug 13 10:40:21 2013 +0530

    mailbox: Fix deleteing poll timer

    Try to delete the timer only if it was init/used.

    Signed-off-by: LeyFoon Tan <lftan.linux@gmail.com>
    Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0883496..0888be5 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -469,7 +469,8 @@ void ipc_links_unregister(struct ipc_controller *ipc)
        list_for_each_entry(chan, &con->channels, node)
                ipc_free_channel((void *)chan);

-       del_timer_sync(&con->poll);
+       if (ipc->txdone_poll)
+               del_timer_sync(&con->poll);

        kfree(con);
 }

commit 8456ca4665da4a5bac3163eb1ddd98bcccd690c2
Author: LeyFoon Tan <lftan.linux@gmail.com>
Date:   Mon Aug 12 22:02:10 2013 +0530

    mailbox: Fix TX completion init

    For fast TX the complete could be called before being initialized as follows
     ipc_send_message --> poll_txdone --> tx_tick -->
complete(&chan->tx_complete)

    Init the completion early enough to fix the race.

    Signed-off-by: LeyFoon Tan <lftan.linux@gmail.com>
    Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index c4ef608..0883496 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -198,6 +198,9 @@ request_token_t ipc_send_message(void *channel, void *mssg)
        if (!chan || !chan->assigned)
                return 0;

+       if (chan->tx_block)
+               init_completion(&chan->tx_complete);
+
        t = _add_to_rbuf(chan, mssg);
        if (!t)
                pr_err("Try increasing MBOX_TX_QUEUE_LEN\n");
@@ -209,7 +212,6 @@ request_token_t ipc_send_message(void *channel, void *mssg)

        if (chan->tx_block && chan->active_req) {
                int ret;
-               init_completion(&chan->tx_complete);
                ret = wait_for_completion_timeout(&chan->tx_complete,
                        chan->tx_tout);
                if (ret == 0) {


>
> Just a comment about this common mailbox API with respect to the BCM2835.
> It makes more sense for the BCM285 to always send messages with a blocking
> transmit. The mailbox send is a single 32 bit IO register shared for all
> channels (the channel number is encoded into the send data). BCM2835
> drivers would only want to use the mailbox API with an effective transmit
> queue depth of 1.  This is fine.  From what I can see, IPC calls via the
> mailbox should be very infrequent. Mostly only to set up some other
> inter-processor communication mechanism, or to query remote processor
> properties at system start or on behalf of a user process.
>
> The second problem is in ipc_request_channel
>
> list_for_each_entry(chan, &con->channels, node) {
>         if (!strcmp(con_name + len + 1, chan->name)
>                         && !chan->assigned) {
>                 spin_lock_irqsave(&chan->lock, flags);
> [...snip...]
>                 chan->assigned = true;
> [...snip...]
>                 spin_unlock_irqrestore(&chan->lock, flags);
>                 ret = 1;
>                 break;
>         }
> }
>
> I think this is a race condition. I can see no reason why two or more threads
> couldn't proceed through the if condition before the spin lock is acquired.
> If that happens, then after the first thread has claimed the channel by
> setting assigned true and released the spin lock, the second thread will
> proceed, and overwrite the channel state with its own values.  Then wackiness
> ensues.
>
> The fix would be to move the lock acquisition to before the if, but getting
> the unlock correct will become messy.
>
Thanks for pointing out... the following fix should work.

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0888be5..25e9924 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -261,9 +261,10 @@ void *ipc_request_channel(struct ipc_client *cl)

        ret = 0;
        list_for_each_entry(chan, &con->channels, node) {
-               if (!strcmp(con_name + len + 1, chan->name)
-                               && !chan->assigned) {
-                       spin_lock_irqsave(&chan->lock, flags);
+               if (strcmp(con_name + len + 1, chan->name))
+                       continue;
+               spin_lock_irqsave(&chan->lock, flags);
+               if (!chan->assigned) {
                        chan->msg_free = 0;
                        chan->msg_count = 0;
                        chan->active_req = NULL;
@@ -279,10 +280,11 @@ void *ipc_request_channel(struct ipc_client *cl)
                        if (chan->txdone_method == TXDONE_BY_POLL
                                        && cl->knows_txdone)
                                chan->txdone_method |= TXDONE_BY_ACK;
-                       spin_unlock_irqrestore(&chan->lock, flags);
                        ret = 1;
-                       break;
                }
+               spin_unlock_irqrestore(&chan->lock, flags);
+               if (ret)
+                       break;
        }

        if (!ret) {
