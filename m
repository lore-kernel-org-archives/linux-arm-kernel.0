From: noralf@tronnes.org (=?windows-1252?Q?Noralf_Tr=F8nnes?=)
Date: Tue, 12 May 2015 17:28:47 +0200
Subject: [PATCH 2/3 v8] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1430857666-18877-2-git-send-email-eric@anholt.net>
References: <1430857666-18877-1-git-send-email-eric@anholt.net>
 <1430857666-18877-2-git-send-email-eric@anholt.net>
Message-ID: <55521C2F.5030809@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 05.05.2015 22:27, skrev Eric Anholt:
> From: Lubomir Rintel <lkundrak@v3.sk>
>
> This mailbox driver provides a single mailbox channel to write 32-bit
> values to the VPU and get a 32-bit response.  The Raspberry Pi
> firmware uses this mailbox channel to implement firmware calls, while
> Roku 2 (despite being derived from the same firmware tree) doesn't.
>
> The driver was originally submitted by Lubomir, based on the
> out-of-tree 2708 mailbox driver.  Eric Anholt fixed it up for
> upstreaming, with the major functional change being that it now has no
> notion of multiple channels (since that is a firmware-dependent
> concept) and instead the raspberrypi-firmware driver will do that
> bit-twiddling in its own messages.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
[...]
> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
[...]
> +static bool bcm2835_last_tx_done(struct mbox_chan *link)
> +{
> +	struct bcm2835_mbox *mbox = bcm2835_link_mbox(link);
> +	bool ret;
> +
> +	spin_lock(&mbox->lock);
> +	ret = !(readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL);

I don't know how the mailbox framework uses this function,
but MAIL0_STA might be wrong here.

Phil Elwell detected a bug in the downstream mailbox driver in
the mbox_write function where it waits for space to be available
in the FIFO. His observation:
With the VC reader blocked and the ARM writing, MAIL0_STA reads
empty permanently while MAIL1_STA goes from empty (0x40000000)
to non-empty (0x00000001-0x00000007) to full (0x80000008).

See:
https://github.com/raspberrypi/linux/commit/3018d8a0996ad2340ba1b3f473f705ef285b01b5
