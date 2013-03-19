From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Mar 2013 19:00:57 +0530
Subject: [PATCH v2 11/11] ARM: OMAP2+: omap_hwmod: Don't call
 _init_mpu_rt_base if no sysc
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1363699857-5505-12-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP hwmod layer does the reset of the IPs in early code so that
we have SOC in sane state. To do the soft-reset, it needs to ioremap()
the ip address space to be able to write to sysconfig registers.

But there are few hwmod which doesn't have sysconfig registers and hence
no need to ioremap() them in early init code.

So this patch makes prevet calling the _init_mpu_rt_base() conditional
based on sysc availability.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4501038..1a1f0a4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2449,7 +2449,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
-	_init_mpu_rt_base(oh, NULL);
+	if (oh->class->sysc)
+		_init_mpu_rt_base(oh, NULL);
 
 	r = _init_clocks(oh, NULL);
 	if (IS_ERR_VALUE(r)) {
-- 
1.7.9.5
