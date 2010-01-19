From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 19 Jan 2010 15:50:37 -0800
Subject: [PATCH 04/10] OMAP clockdomain/powerdomain: remove runtime
	register/unregister
In-Reply-To: <20100112010536.6275.36524.stgit@localhost.localdomain> (Paul
	Walmsley's message of "Mon\, 11 Jan 2010 18\:05\:37 -0700")
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
	<20100112010536.6275.36524.stgit@localhost.localdomain>
Message-ID: <87ljftd582.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> OMAP clockdomains and powerdomains are currently defined statically,
> only registered at boot, and never unregistered, so we can remove the
> unregister function and the locking.   A variant of this was originally
> suggested a while ago by Dmitry Baryshkov <dbaryshkov@gmail.com>.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>

Hi Paul,

This patch removes the _nolock() iterator but forgot to fixup the
users.  I found this when building an updated PM branch on top of your
fixes branch.

Please fold the following diff into this patch.  Applies on top of
your current for_2.6.33rc_d branch.

Thanks,

Kevin

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 860b755..283bdca 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -575,7 +575,7 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("time", S_IRUGO,
 		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
 
-	pwrdm_for_each_nolock(pwrdms_setup, (void *)d);
+	pwrdm_for_each(pwrdms_setup, (void *)d);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
