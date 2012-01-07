From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 7 Jan 2012 13:48:31 +0800
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120106120345.8157a839b1c924315d728eea@canb.auug.org.au>
References: <20120106120345.8157a839b1c924315d728eea@canb.auug.org.au>
Message-ID: <20120107054829.GF4790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 12:03:45PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-imx/mm-imx5.c between commit 9bdd46257ab3 ("ARM: plat-mxc:
> hook special idle handlers to arm_pm_idle") from the arm tree and commit
> 010dc8af8f28 ("ARM: mx5: use generic irq chip pm interface for pm
> functions on") from the arm-soc tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.

Hi Stephen,

When I was testing this fix on next-20120106, I spotted another compile
error from this file.

  CC      arch/arm/mach-imx/mm-imx5.o
arch/arm/mach-imx/mm-imx5.c:58:24: error: redefinition of ?mx50_io_desc?
arch/arm/mach-imx/mm-imx5.c:48:24: note: previous definition of ?mx50_io_desc? was here
arch/arm/mach-imx/mm-imx5.c:48:24: warning: ?mx50_io_desc? defined but not used

The fix could just be removing the duplication.

-- 
Regards,
Shawn


8<----
@@ -53,16 +54,6 @@ static struct map_desc mx50_io_desc[] __initdata = {
 };

 /*
- * Define the MX50 memory map.
- */
-static struct map_desc mx50_io_desc[] __initdata = {
-       imx_map_entry(MX50, TZIC, MT_DEVICE),
-       imx_map_entry(MX50, SPBA0, MT_DEVICE),
-       imx_map_entry(MX50, AIPS1, MT_DEVICE),
-       imx_map_entry(MX50, AIPS2, MT_DEVICE),
-};
-
-/*
