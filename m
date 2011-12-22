From: robert.richter@amd.com (Robert Richter)
Date: Thu, 22 Dec 2011 15:54:12 +0100
Subject: [PATCH] arm: oprofile: fix linkage issue
In-Reply-To: <20111222142140.GP16765@erda.amd.com>
References: <1324561016-19389-1-git-send-email-vladimir.zapolskiy@nokia.com>
 <20111222142140.GP16765@erda.amd.com>
Message-ID: <20111222145412.GV16765@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.12.11 15:21:40, Robert Richter wrote:
> On 22.12.11 15:36:56, Vladimir Zapolskiy wrote:
> > This change fixes a linking problem, which happens if oprofile is selected to
> > be compiled as built-in:
> > 
> >   `oprofile_arch_exit' referenced in section `.init.text' of
> >   arch/arm/oprofile/built-in.o: defined in discarded section
> >   `.exit.text' of arch/arm/oprofile/built-in.o
> > 
> > The problem is appeared after commit 87121ca504, which introduced
> > oprofile_arch_exit() calls from __init function. Note that the aforementioned
> > commit has been backported to stable branches, and the problem is known to be
> > reproduced at least with 3.0.13 and 3.1.5 kernels.
> 
> I will fix it upstream, afterwards this goes into stable due to the
> stable tag.
> 
> Right, commit 87121ca504 went into stable kernels 3.0 and 3.1, need to
> fix them too:
> 
> CC: stable at kernel.org # 3.0+
> 
> Please fix also arch/sh with this patch:
> 
>  $ git grep exit.*oprofile_arch_exit arch/*/oprofile drivers/oprofile/ 
>  arch/arm/oprofile/common.c:void __exit oprofile_arch_exit(void)
>  arch/sh/oprofile/common.c:void __exit oprofile_arch_exit(void)
>  arch/sh/oprofile/common.c:void __exit oprofile_arch_exit(void) {}
> 
> Thanks,

To make things easier: if you aggree I will apply your patch with the
changes below in addition. No need to respin a new patch version.

Thanks,

-Robert



diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
index b4c2d2b..e4dd5d5 100644
--- a/arch/sh/oprofile/common.c
+++ b/arch/sh/oprofile/common.c
@@ -49,7 +49,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
        return oprofile_perf_init(ops);
 }
 
-void __exit oprofile_arch_exit(void)
+void oprofile_arch_exit(void)
 {
        oprofile_perf_exit();
        kfree(sh_pmu_op_name);
@@ -60,5 +60,5 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
        ops->backtrace = sh_backtrace;
        return -ENODEV;
 }
-void __exit oprofile_arch_exit(void) {}
+void oprofile_arch_exit(void) {}
 #endif /* CONFIG_HW_PERF_EVENTS */


-- 
Advanced Micro Devices, Inc.
Operating System Research Center
