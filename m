From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Fri, 21 Jan 2011 19:55:21 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <201101211911.35162.marek.vasut@gmail.com>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<20110120193013.GL6335@n2100.arm.linux.org.uk>
	<AANLkTi=cwRNCxS6qbR3Kp2Sf-ckx+wcUAgTc8LOYES9F@mail.gmail.com>
	<201101211911.35162.marek.vasut@gmail.com>
Message-ID: <AANLkTikU6=Cps-tPLLK=OUoE6i+rpS21OF2-VLoWUDvF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/21 Marek Vasut <marek.vasut@gmail.com>:

[snip]

> Hi,
> how did you change the speed in the bootloader? Didn't you just adjust the
> apropriate registers? Don't forget, you need to issue CP15 (maybe CP14)
> coprocessor call.

Here's my quick & dirty OBM2 work-in-progress patch:

diff --git a/OBM2/plat/colibri_pxa310.c b/OBM2/plat/colibri_pxa310.c
index 9c7ccfc..557aca7 100644
--- a/OBM2/plat/colibri_pxa310.c
+++ b/OBM2/plat/colibri_pxa310.c
@@ -87,13 +87,26 @@ inline void plat_init(void)
        writel(GPIO_BASE, 0x274, 0xb881);       /* IO15 */

        /* CPU speed settings */
-       accr = 0x028fd200;
+       /* SMC_S: 208 MHz
+        * VAUF_S: 104 MHz
+        * SFL_S: 312 MHz
+        * XSPCLK_S: no clocks being used during frequency changes
+        * 0xd/orig: HSS_S: 312 MHz system bus freq
+        * 0xb/new: HSS_S: 208 MHz system bus freq
+        * 0xd/orig: DMC_S: 0x01 (reserved)
+        * 0xb/new: DMC_S: 0x11 (130 MHz SDRAM clock)
+        * XN_S: 0x2 (turbo-mode-to-run-mode ratio status)
+        * XL_S: 0x18 (run-mode-to-processor (13 MHz) oscillator ratio status)
+        */
+       //accr = 0x028fb300;
        if (cpu_type(PXA300))
                accr |= 0x08;
        else
                accr |= 0x18;
+       //accr = 0x30033108; // this works!!! 104 MHz Linux
+       accr = 0x32EFB218; // 624 MHz in Linux
        writel(0x41340000, 0x00, accr);
-       asm volatile("mcr p14, 0, %0, c6, c0, 0"::"r"(2));
+       asm volatile("mcr p14, 0, %0, c6, c0, 0"::"r"(3));
        while (((readl(0x41340000, 0x04) >> 28) & 0x3) != 0x3);
 }


The comments in the patch may be wrong, I may have mixed up ACCR and
ACSR registers when decoding them :-)

> Well, just my quick thought.
>
> btw. Bjorn, I just dug out the pxa320 board, maybe I can also find the pxa310/300
> cards, mind IRC-ing ? ;-)

Maybe pxa320 behaves like pxa310? Try changing core clock in OBM2 and
see if it changes Linux jpj/BogoMIPS. It seems to me that lpj is the
same no matter what the bootloader sets the core clock to. Weird.

IRC? Yes, #openpxa here I come. But I'm about to go home for the
weekend now and won't have access to the target board until monday.

Best regards,
Bj?rn Forsman
