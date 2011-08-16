From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 16 Aug 2011 16:50:22 +0900
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <001601cc5be9$275a5200$760ef600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
>
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway.
>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Samsung folks: I cannot find a defconfig that actually compiles
> this driver in, can you help me testing it so I didn't break
> anything, and Ack if it looks OK? Thanks.

Hello Linus,

I tested this patch on SMDKC210 but happened following build error with
exynos4_defconfig.

arch/arm/common/pl330.c: In function 'pl330_add':
arch/arm/common/pl330.c:1844: error: invalid type argument of '->' (have
'u32')
arch/arm/common/pl330.c:1845: error: invalid type argument of '->' (have
'u32')

So I added following.

From: Boojin Kim <boojin.kim@samsung.com>
Date: Tue, 16 Aug 2011 16:27:22 +0900
Subject: [PATCH] ARM: PL330: use amba_device structure to get amba
information

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/common/pl330.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 2b3b8b3..af6d96d 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1822,6 +1822,8 @@ int pl330_add(struct pl330_info *pi)
 	struct pl330_dmac *pl330;
 	int i, ret;
 	u32 cid, pid;
+	struct amba_device *adev = container_of(pi->dev,
+					struct amba_device, dev);

 	if (!pi || !pi->dev)
 		return -EINVAL;
@@ -1841,8 +1843,8 @@ int pl330_add(struct pl330_info *pi)
 	cid = amba_get_cid(pi->base, PCELL_SIZE);
 	pid = amba_get_pid(pi->base, PCELL_SIZE);
 	if (cid != AMBA_CID ||
-	    amba_manf(pid) != AMBA_VENDOR_ARM ||
-	    amba_part(pid) != PART) {
+	    amba_manf(adev) != AMBA_VENDOR_ARM ||
+	    amba_part(adev) != PART) {
 		dev_err(pi->dev, "PID: 0x%x, CID: 0x%x !\n", pid, cid);
 		return -EINVAL;
 	}
--
1.7.1


Tested-by: Boojin Kim <boojin.Kim@samsung.com>
with above on smdkc210 board

If my ack is required on this,
Acked-by: Boojin Kim <boojin.Kim@samsung.com>

If you need more test, please kindly let me know.
