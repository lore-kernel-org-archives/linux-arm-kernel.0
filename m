From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 31 Dec 2013 10:35:03 +0100
Subject: Can't boot newer kernel on Armada 370 dev board
In-Reply-To: <20131230185240.GA32537@lunn.ch>
References: <20131230174738.GA4172@enneenne.com>
 <20131230181205.GA32362@lunn.ch>
 <20131230183908.GB4172@enneenne.com>
 <20131230185240.GA32537@lunn.ch>
Message-ID: <20131231103503.3bba7c08@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, Rodolfo,

On Mon, 30 Dec 2013 19:52:40 +0100, Andrew Lunn wrote:

> > U-Boot 2011.12 (Dec 24 2013 - 16:16:38) Marvell version: v2011.12 2013_Q3.0
> > 
> > > There has been a change in u-boot
> > > so that the registers are mapped to a different address. Old u-boot
> > > with new kernel causes instant lockup on boot as soon as it tries to
> > > access the wrong address space.
> > 
> > I see. Where can I get newer u-boot releases in order to avoid this
> > problem? :-)
> 
> From Marvell.
> 
> It is also possible to modify the DT to use the old address. I think
> there is a thread somewhere with Thomas Petazzoni telling somebody
> what changes need to be made for Armada XP. 370 should be very
> similar.
> 
> Basically you need to change 0xF1000000 to 0xD0000000.

No, that's the opposite.

The mainline kernel uses 0xD0000000 for this board, because originally
the Marvell Armada 370 DB was shipped with an old U-Boot, which was
mapping registers at 0xD0000000.

Apparently, they are now shipping these boards with a more recent
version of U-Boot that uses 0xF1000000. Therefore, Rodolfo should
change the kernel from 0xD0000000 to 0xF1000000.

The change to be applied is:

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 08a56bc..9aa76b4 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -30,7 +30,7 @@
        };
 
        soc {
-               ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+               ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
                          MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
                internal-regs {

Also, if you have earlyprintk enabled, make sure you have
CONFIG_DEBUG_MVEBU_UART_ALTERNATE enabled and CONFIG_DEBUG_MVEBU_UART
disabled.

Let me know if that works for you.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
