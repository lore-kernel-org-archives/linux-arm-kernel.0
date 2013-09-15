From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Sun, 15 Sep 2013 15:28:23 +1200
Subject: [RFC PATCH 1/3] Enable BCM2835 mailbox support
In-Reply-To: <5232F7B7.4070206@yahoo.com.au>
References: <5232F7B7.4070206@yahoo.com.au>
Message-ID: <52352957.1070904@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 11:32 PM, Craig McGeachie wrote:
> Cherry-picked selection of commits by Lubomir Rintel [1], Suman Anna and
> Jassi Brar [2] on which to base the implementation.
> 
> Signed-off-by: Suman Ana <s-anna@ti.com>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html

There are two problems with the mailbox framework that I can find.
The first is in ipc_send_message.  On the BCM2835, the mailbox send
result doesn't trigger an interrupt, but the pending reply does. When
ipc_request_channel is called without blocking, the flow of events
looks like this:
[    0.521312] req - cf9845c0: 00000020 00000000 00030006 00000008
[    0.527245] req - cf9845d0: 00000008 00000000 00000000 00000000
[    0.533248] bcm2835-mbox 2000b880.mailbox: Request 0x0F9845C8
[    0.539007] bcm2835-mbox 2000b880.mailbox: Reply 0x0F9845C8
[    0.544582] bcm2835_thermal thermal.1: rxcb #1 @0f9845c0
[    0.549939] bcm2835-mbox 2000b880.mailbox: Polling
[    0.554773] bcm2835_thermal thermal.1: txcb #1 @0f9845c0
[    0.560102] rep - cf9845c0: 00000020 80000000 00030006 00000008
[    0.566062] rep - cf9845d0: 80000008 00000000 000078da 00000000

I've never seen the transmit callback come first.

When ipc_request_channel is called with blocking, then the best result
I've had a null pointer causing a kernel panic.  Most of the time, the
system just deadlocks.  The fix is:

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index c4ef608..08fae83 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -202,6 +202,7 @@ request_token_t ipc_send_message(void *channel, void *mssg)
        if (!t)
                pr_err("Try increasing MBOX_TX_QUEUE_LEN\n");
 
+       init_completion(&chan->tx_complete);
        _msg_submit(chan);
 
        if (chan->txdone_method == TXDONE_BY_POLL)
@@ -209,7 +210,6 @@ request_token_t ipc_send_message(void *channel, void *mssg)
 
        if (chan->tx_block && chan->active_req) {
                int ret;
-               init_completion(&chan->tx_complete);
                ret = wait_for_completion_timeout(&chan->tx_complete,
                        chan->tx_tout);
                if (ret == 0) {

When the init_completion is done after the _msg_submit, it might be executed
after the complete in tx_tick.  And for the BCM2835, it's pretty reliable that
this will happen. When this happens, the calls are:
 1. complete
 2. init_completion
 3. wait_for_completion_timeout

The complete call is missed.

With this fix in place, the flow of events now looks like:
[    0.521214] req - cf9845c0: 00000020 00000000 00030006 00000008
[    0.527149] req - cf9845d0: 00000008 00000000 00000000 00000000
[    0.533149] bcm2835-mbox 2000b880.mailbox: Request 0x0F9845C8
[    0.538908] bcm2835-mbox 2000b880.mailbox: Reply 0x0F9845C8
[    0.544482] bcm2835_thermal thermal.1: rxcb #1 @0f9845c0
[    0.549840] bcm2835-mbox 2000b880.mailbox: Polling
[    0.554686] rep - cf9845c0: 00000020 80000000 00030006 00000008
[    0.560648] rep - cf9845d0: 80000008 00000000 0000835c 00000000


Just a comment about this common mailbox API with respect to the BCM2835.
It makes more sense for the BCM285 to always send messages with a blocking
transmit. The mailbox send is a single 32 bit IO register shared for all
channels (the channel number is encoded into the send data). BCM2835
drivers would only want to use the mailbox API with an effective transmit
queue depth of 1.  This is fine.  From what I can see, IPC calls via the
mailbox should be very infrequent. Mostly only to set up some other
inter-processor communication mechanism, or to query remote processor
properties at system start or on behalf of a user process.

The second problem is in ipc_request_channel

list_for_each_entry(chan, &con->channels, node) {
	if (!strcmp(con_name + len + 1, chan->name)
			&& !chan->assigned) {
		spin_lock_irqsave(&chan->lock, flags);
[...snip...]
		chan->assigned = true;
[...snip...]
		spin_unlock_irqrestore(&chan->lock, flags);
		ret = 1;
		break;
	}
}

I think this is a race condition. I can see no reason why two or more threads
couldn't proceed through the if condition before the spin lock is acquired.
If that happens, then after the first thread has claimed the channel by
setting assigned true and released the spin lock, the second thread will
proceed, and overwrite the channel state with its own values.  Then wackiness
ensues.

The fix would be to move the lock acquisition to before the if, but getting
the unlock correct will become messy.

Cheers,
Craig.
