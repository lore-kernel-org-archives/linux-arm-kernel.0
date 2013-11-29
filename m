From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 29 Nov 2013 16:29:00 +0100
Subject: [PATCH] IMX6 flexcan: Change serial clock_feq source from IPG
 clock to PER clock
In-Reply-To: <20131129142249.GA10840@S2101-09.ap.freescale.net>
References: <E1C9442006A9AE48A7A4B85E0D01C4D4748A18@stwexdb.stww2k.local>
 <5EC8D4ACC923FE4D871AFFACC9761279739C0B@stwexdb.stww2k.local>
 <20131129142249.GA10840@S2101-09.ap.freescale.net>
Message-ID: <5298B2BC.7070002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 03:22 PM, Shawn Guo wrote:
>> think I found a bug in the flexcan driver. Currently the serial
>> clock frequency for bitrate calculation is derived from IPG clock. 
>> According to the imx6d/q reference manual, the CAN serial clock is
>> derived from can_root clock (PER clock in dtb). The patch below
>> fixes this issue.
> 
> Marc already had a patch for it.
> 
> http://www.spinics.net/lists/arm-kernel/msg288971.html

Ack, it's already in David Miller's net/master and will hit Linus tree
soon, stable in on Cc.

>> However, I'm not sure if the patch below will also work for the
>> rest of the imx family. Does anybody know if the CAN serial clock
>> is derived from IPG clock in other imx processors? Is there a case
>> distinction required to keep backward compatibility?

All other processors use the same rate, for now, for both clocks.
However this will change soon on the mx53, once my patch in mainline.

>> Be aware that getting the flexcan module running on the imx6 also
>> requires patch "[PATCH] IMX6: Add static /8 prescaler to can_root
>> clock configuration"

That problem has already been fixed with:

    9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock

and I've asked Greg to queue this patch for stable, too:

http://www.spinics.net/lists/stable/msg26282.html

>> In the same file there is another bug which only occurs in
>> combination with an imx6 processor. Within the function "static int
>> flexcan_chip_start(struct net_device *dev)" all message boxes will
>> be initialized. Think that isn't correct for the IMX6 processor. In
>> the newest kernel v3.12.r1 the problem is already fixed and I'm not
>> sure if the fix will be automatically added to the LTE kernel
>> version 3.10.20 ? If not, shall I create a patch for it ?

As there already is a patch for the problem, I think you mean:

    0d1862e can: flexcan: fix flexcan_chip_start() on imx6

There was a bit of confusion about this patch, as it creates a
regression that was fixes by the later patch:

    d5a7b40 can: flexcan: flexcan_chip_start: fix regression, mark one
MB for TX and abort pending TX

It seems that d5a7b40 got applied but 0d1862e not. I'll ask Greg to
queue the missing patch ("0d1862e") to stable.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/b6b45f8e/attachment.sig>
