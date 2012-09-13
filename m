From: mturquette@ti.com (Mike Turquette)
Date: Thu, 13 Sep 2012 11:27:49 -0700
Subject: [PATCH] ARM: Tegra: Add smp_twd clock for Tegra20
In-Reply-To: <5052174A.8090701@wwwdotorg.org>
References: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
 <5052027F.1000404@wwwdotorg.org> <5052174A.8090701@wwwdotorg.org>
Message-ID: <20120913182749.3094.64766@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2012-09-13 10:26:34)
> On 09/13/2012 09:57 AM, Stephen Warren wrote:
> > On 09/13/2012 03:34 AM, Prashant Gaikwad wrote:
> >> Clockevent's frequency is changed upon cpufreq change
> >> notification. It fetches local timer's rate to update the
> >> clockevent frequency. This patch adds local timer clock
> >> for Tegra20.
> > 
> > Hmm. Off-list, I'd asked you to check whether this patch, and Mike's
> > twd/clk-notifier changes were OK for Tegra, and part of your reponse was:
> > 
> > Tegra20 (Ventana)
> >         Tegra's for-next (common clock) + smp_twd : Panic
> > 
> > Is that true? If so, I can't apply this patch...
> 
> Oh, perhaps you mean the warning below? That's exactly the issue that
> Mike's patch was intended to solve, so it's not surprising that it'd be
> seen as soon as we actually implement the smp_twd clock. If that's all,
> then it seems OK to apply this.
> 

Can you confirm that the problem goes away with this patch:
http://article.gmane.org/gmane.linux.ports.arm.kernel/187488/match=

Thanks,
Mike

> > [    1.287406] ------------[ cut here ]------------
> > [    1.292049] WARNING: at kernel/mutex.c:198 __mutex_lock_slowpath+0x2c8/0x34c()
> > [    1.299259] Modules linked in:
> > [    1.302361] [<c0015118>] (unwind_backtrace+0x0/0x138) from [<c0027d3c>] (warn_slowpath_common+0x4c/0x64)
> > [    1.311843] [<c0027d3c>] (warn_slowpath_common+0x4c/0x64) from [<c0027d70>] (warn_slowpath_null+0x1c/0x24)
> > [    1.321497] [<c0027d70>] (warn_slowpath_null+0x1c/0x24) from [<c04a140c>] (__mutex_lock_slowpath+0x2c8/0x34c)
> > [    1.331412] [<c04a140c>] (__mutex_lock_slowpath+0x2c8/0x34c) from [<c04a149c>] (mutex_lock+0xc/0x24)
> > [    1.340551] [<c04a149c>] (mutex_lock+0xc/0x24) from [<c0306a04>] (clk_get_rate+0x10/0x68)
> > [    1.348731] [<c0306a04>] (clk_get_rate+0x10/0x68) from [<c00148a0>] (twd_update_frequency+0x14/0x48)
> > [    1.357865] [<c00148a0>] (twd_update_frequency+0x14/0x48) from [<c0070a58>] (generic_smp_call_function_single_interrupt+0xd0/0x130)
> > [    1.369686] [<c0070a58>] (generic_smp_call_function_single_interrupt+0xd0/0x130) from [<c00140c4>] (handle_IPI+0xb0/0x154)
> > [    1.380723] [<c00140c4>] (handle_IPI+0xb0/0x154) from [<c0008560>] (gic_handle_irq+0x54/0x5c)
> > [    1.389255] [<c0008560>] (gic_handle_irq+0x54/0x5c) from [<c000e9e0>] (__irq_svc+0x40/0x70)
> > [    1.397594] Exception stack(0xef083f50 to 0xef083f98)
> > [    1.402643] 3f40:                                     ef083fa0 00000000 00000000 000f4240
> > [    1.410815] 3f60: 00001093 00000000 00000000 c0f3d3d8 ef083f98 411fc090 00000000 00000000
> > [    1.418984] 3f80: 3b9ac9ff ef083f98 c01e4728 c001f010 20000013 ffffffff
> > [    1.425612] [<c000e9e0>] (__irq_svc+0x40/0x70) from [<c001f010>] (tegra_idle_enter_lp3+0x68/0x78)
> > [    1.434488] [<c001f010>] (tegra_idle_enter_lp3+0x68/0x78) from [<c02d80f8>] (cpuidle_enter+0x14/0x18)
> > [    1.443705] [<c02d80f8>] (cpuidle_enter+0x14/0x18) from [<c02d868c>] (cpuidle_idle_call+0xb0/0x140)
> > [    1.452752] [<c02d868c>] (cpuidle_idle_call+0xb0/0x140) from [<c000fb14>] (cpu_idle+0xbc/0x110)
> > [    1.461448] [<c000fb14>] (cpu_idle+0xbc/0x110) from [<0049d414>] (0x49d414)
> > [    1.468421] ---[ end trace bb3563806344f4a0 ]---
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
