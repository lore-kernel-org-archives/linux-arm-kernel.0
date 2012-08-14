From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 16:16:19 +0200
Subject: [PATCH 00/23] work in progress: SPI controller w/DMA SAM9X5
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <CACQ1gAhPySejdoFfSW0chSF_5fHv9D5DYHb0D65xbExdb0n-7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/14 Richard Genoud <richard.genoud@gmail.com>:
> Nicolas,
> I said that I had some work done on sam9g35-ek, here is the spi part, based
> on your and Jean-Christophe work.
> You have to enable CONFIG_ARCH_AT91SAM9X5 to get it work.
I forgot something:
As I didn't get pinctrl to work, on top of this patchset, I did a
revert of "ARM: at91: add pinctrl support"
and I made this change :
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index e213e2d..bc3fdbf 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -313,6 +313,13 @@ static void __init at91sam9x5_map_io(void)
 	at91_init_sram(0, AT91SAM9X5_SRAM_BASE, AT91SAM9X5_SRAM_SIZE);
 }

+
+void __init at91sam9x5_initialize(void)
+{
+	/* Register GPIO subsystem (using DT) */
+	at91_gpio_init(NULL, 0);
+}
+
 /* --------------------------------------------------------------------
  *  Interrupt initialization
  * -------------------------------------------------------------------- */
@@ -320,4 +327,5 @@ static void __init at91sam9x5_map_io(void)
 struct at91_init_soc __initdata at91sam9x5_soc = {
 	.map_io = at91sam9x5_map_io,
 	.register_clocks = at91sam9x5_register_clocks,
+	.init = at91sam9x5_initialize,
 };

I also enabled the spi controller in the DTS:
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi
b/arch/arm/boot/dts/at91sam9x5.dtsi
index ef09816..cc1c830 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -363,7 +363,7 @@
 				atc_fifocfg_halffifo;
 				atc_src_h2sel_hw;
 				atc_dst_h2sel_hw;
-				status = "disabled";
+				status = "okay";
 			};

 			spi1: spi at f0004000 {

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
