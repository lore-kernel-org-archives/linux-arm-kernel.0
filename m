From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 17 Apr 2012 15:55:56 +0530
Subject: [PATCH] mmc: omap_hsmmc: Fix check for mmc dt node
In-Reply-To: <CANrkHUa9yNye7b12=VEFPsMg7JdQnE6BvE_7sW+1PfgyWFH+mw@mail.gmail.com>
References: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
 <CANrkHUa9yNye7b12=VEFPsMg7JdQnE6BvE_7sW+1PfgyWFH+mw@mail.gmail.com>
Message-ID: <CAJe_ZheUs0xJPxSZ1o4h+uHi8fyfg2cVnyYo=VXj6Dw0_OecbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 15:41, T Krishnamoorthy, Balaji <balajitk@ti.com> wrote:
>>
>> The patch is more than a nit-pick because upstream doesn't yet have dt
>> nodes for mmc on OMAP while the driver wrongly assumes it does.
>> Which isn't a problem until you use some low-end sdhc card
>> (Transcend 8GB Class-4 in my experience) which fails to re-initialize,
>> OCR[30] set, if the first attempt fails due to delay at certain times
>> during the probe (for ex, simply enable CONFIG_REGULATOR_DUMMY).
>> Apparently such cards need proper 0v->1.8v power cycle to recover
>> (another Class-10 card does recover after ~10 attempts by the host).
>>
>
> Is this issue seen while booting with device tree or non device tree ?
>
On Panda-4430/60 with some 'low-class' card , with omap4-panda.dtb and
omap2plus_defconfig + CONFIG_REGULATOR_DUMMY

After applying the following patch to enable booting with dt.

--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -574,6 +574,11 @@ static void __init omap4_panda_init(void)
 	omap4_panda_display_init();
 }

+static const char *omap4_panda_match[] __initdata = {
+	"ti,omap4-panda",
+	NULL,
+};
+
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.atag_offset	= 0x100,
@@ -585,4 +590,5 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
 	.restart	= omap_prcm_restart,
+	.dt_compat	= omap4_panda_match,
 MACHINE_END


-jassi
