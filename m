From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 6 May 2015 15:19:26 +0800
Subject: [PATCH 0/7] Add SMP bringup support for mt65xx socs
In-Reply-To: <CABuKBeJ406DUFoVs2p3-u6sW58Dm7XDd6uxCc==Mkq3dMhhd5Q@mail.gmail.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBeJ406DUFoVs2p3-u6sW58Dm7XDd6uxCc==Mkq3dMhhd5Q@mail.gmail.com>
Message-ID: <1430896766.15346.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Matthias,

On Mon, 2015-05-04 at 09:48 +0200, Matthias Brugger wrote:
> Hi Yingjoe,
> 
> 2015-05-01 9:43 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> > This series add SMP brinup support for mediatek SoCs. This is based
> > on v4.1-rc1.
> >
> > There are 2 similar but different SMP bringup up methods on Mediatek
> > mt65xx and mt81xx. On MT8135 & MT8127, system boots with a trustzone
> > firmware. Others, like MT6589, doesn't have trustzone, and run kernel
> > directly in secure world.
> >
> > Patch 1~3 fix issues in mtk_timer(GPT) and enable arch timer support.
> > Patch 4,5 add support for cpu enable-method "mediatek,mt65xx-smp" and
> > "mediatek,mt81xx-tz-smp", which support Mediatek SMP bringup for non-TZ
> > and TZ platform.
> > Patch 6,7 finally enable SMP bringup for mt8135 and mt8127.
> >
> > Matthias Brugger (1):
> >   arm: mediatek: enable gpt6 on boot up to make arch timer working
> >
> > Yingjoe Chen (6):
> >   clocksource: mediatek: Don't run event_handler if it is NULL
> >   clocksource: mediatek: Use GPT as sched clock source
> >   devicetree: bindings: add new SMP enable method Mediatek SoC
> >   ARM: mediatek: add smp bringup code
> >   ARM: dts: mt8135: enable basic SMP bringup for mt8135
> >   ARM: dts: mt8127: enable basic SMP bringup for mt8127
> >
> 
> I tried on the mt8135 eval board but it fails to bring up the CPU.
> 
> When booting:
> [    1.048588] CPU1: failed to come online
> [    2.049914] CPU2: failed to come online
> [    3.051245] CPU3: failed to come online


Thanks for testing, and the config file you provided.
It seems you are running THUMB2 kernel, unfortunately mt8135 trustzone
firmware doesn't support jump to THUMB2 code directly.

I can workaround this with the following patch. I'll include it in my
next round.

Joe.C

-----8<----------------
diff --git a/arch/arm/mach-mediatek/platsmp.c
b/arch/arm/mach-mediatek/platsmp.c
index e266b3d..5dea55a 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -57,6 +57,18 @@ static const struct of_device_id mtk_smp_boot_infos[]
__initconst = {
 static void __iomem *mtk_smp_base;
 static const struct mtk_smp_boot_info *mtk_smp_info;
 
+#ifdef CONFIG_THUMB2_KERNEL
+__asm__(
+	".arm\n"
+	"mtk_secondary_startup_fixup:\n"
+	"	b secondary_startup\n"
+	".thumb\n"
+);
+
+void mtk_secondary_startup_fixup(void);
+#define secondary_startup mtk_secondary_startup_fixup
+#endif
+
 static int mtk_boot_secondary(unsigned int cpu, struct task_struct
*idle)
 {
 	if (!mtk_smp_base)
