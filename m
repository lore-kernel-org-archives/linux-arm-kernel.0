From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Feb 2013 18:25:12 +0000
Subject: [PATCH 6/6] ARM: integrator: ensure ap_syscon_base is
 initialised when !CONFIG_MMU
In-Reply-To: <201302042149.44727.arnd@arndb.de>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <20130131225630.GB26523@quad.lixom.net>
 <20130203114847.GB27474@mudshark.cambridge.arm.com>
 <201302042149.44727.arnd@arndb.de>
Message-ID: <20130206182512.GB28640@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 09:49:44PM +0000, Arnd Bergmann wrote:
> On Sunday 03 February 2013, Will Deacon wrote:
> > I think it's been broken for a little while as it only affects !MMU
> > configurations, which aren't especially popular. My guess is that
> > 83feba511e5d ("ARM: integrator: remove static AP syscon mapping") is what
> > caused the breakage.
> > 
> > The fix should apply against mainline.
> 
> Sounds like a candidate for stable as well then. I'm not sure if anyone
> cares about !MMU stable kernels, but it's totally possible with the
> LTSI kernels.

Agreed. I've lost where we've got to, so here's the patch against -rc5 with
the CC stable and Linus' ack.

Will

--->8

>From b6eafe04b20997b968df4903a4ca6039a3f224be Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 30 Jan 2013 14:02:46 +0000
Subject: [PATCH] ARM: integrator: ensure ap_syscon_base is initialised when !CONFIG_MMU

When running on Integrator/AP using atags, ap_syscon_base is initialised
in ->map_io, which isn't called for !MMU platforms.

Instead, initialise the pointer in ->machine_init, as we do when booting
with device-tree.

Cc: <stable@vger.kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-integrator/integrator_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 11e2a41..26762bf 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -613,7 +613,6 @@ static struct map_desc ap_io_desc_atag[] __initdata = {
 static void __init ap_map_io_atag(void)
 {
 	iotable_init(ap_io_desc_atag, ARRAY_SIZE(ap_io_desc_atag));
-	ap_syscon_base = __io_address(INTEGRATOR_SC_BASE);
 	ap_map_io();
 }
 
@@ -685,6 +684,7 @@ static void __init ap_init(void)
 
 	platform_device_register(&cfi_flash_device);
 
+	ap_syscon_base = __io_address(INTEGRATOR_SC_BASE);
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
-- 
1.8.0
