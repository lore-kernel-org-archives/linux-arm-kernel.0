From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Jul 2013 16:52:00 +0800
Subject: [PATCH 07/32] arm: delete __cpuinit/__CPUINIT usage from all
 ARM users
In-Reply-To: <1372102237-8757-8-git-send-email-paul.gortmaker@windriver.com>
References: <1372102237-8757-1-git-send-email-paul.gortmaker@windriver.com>
 <1372102237-8757-8-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1372755120.2874.18.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-tegra in Cc.

On Tue, 2013-06-25 at 03:30 +0800, Paul Gortmaker wrote:
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
> 
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
> 
> Note that some harmless section mismatch warnings may result, since
> notify_cpu_starting() and cpu_up() are arch independent (kernel/cpu.c)
> and are flagged as __cpuinit  -- so if we remove the __cpuinit from
> the arch specific callers, we will also get section mismatch warnings.
> As an intermediate step, we intend to turn the linux/init.h cpuinit
> related content into no-ops as early as possible, since that will get
> rid of these warnings.  In any case, they are temporary and harmless.
> 
> This removes all the ARM uses of the __cpuinit macros from C code,
> and all __CPUINIT from assembly code.  It also had two ".previous"
> section statements that were paired off against __CPUINIT
> (aka .section ".cpuinit.text") that also get removed here.
> 
> [1] https://lkml.org/lkml/2013/5/20/589
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [This commit is part of the __cpuinit removal work.  If you don't see
>  any problems with it, then you don't have to do anything ; it will be
>  submitted with all the rest of the __cpuinit removal work.  On the
>  other hand, if you want to carry this patch in with your other pending
>  changes so as to handle conflicts with other pending work yourself, then
>  that is fine too, as the commits can largely be treated independently.
>  For more information, please see: https://lkml.org/lkml/2013/6/20/513 ]
> 

Hi Paul,

I just tested this series on Tegra platform. It looks broken CPU hotplug
function for Tegra at least. The CPU can't plug-in after unplugging. And
the system resume function also not working when "enable_nonboot_cpus".

Both of the issue cause system hang up. Are we missing something for
__cpuinit removal work?

Thanks,
Joseph
