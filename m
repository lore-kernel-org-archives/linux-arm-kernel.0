From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Feb 2016 17:15:42 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <20160203170114.GD1234@leverpostej>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203170114.GD1234@leverpostej>
Message-ID: <20160203171541.GC26487@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 05:01:15PM +0000, Mark Rutland wrote:
> On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K Poulose wrote:
> > From: Suzuki K. Poulose <suzuki.poulose@arm.com>
> > 
> > A secondary CPU could fail to come online due to insufficient
> > capabilities and could simply die or loop in the kernel.
> > e.g, a CPU with no support for the selected kernel PAGE_SIZE
> > loops in kernel with MMU turned off.
> > or a hotplugged CPU which doesn't have one of the advertised
> > system capability will die during the activation.
> > 
> > There is no way to synchronise the status of the failing CPU
> > back to the master. This patch solves the issue by adding a
> > field to the secondary_data which can be updated by the failing
> > CPU. If the secondary CPU fails even before turning the MMU on,
> > it updates the status in a special variable reserved in the head.txt
> > section to make sure that the update can be cache invalidated safely
> > without possible sharing of cache write back granule.
> > 
> > Here are the possible states :
> > 
> >  -1. CPU_MMU_OFF - Initial value set by the master CPU, this value
> > indicates that the CPU could not turn the MMU on, hence the status
> > could not be reliably updated in the secondary_data. Instead, the
> > CPU has updated the status in __early_cpu_boot_status (reserved in
> > head.txt section)
> > 
> >  0. CPU_BOOT_SUCCESS - CPU has booted successfully.
> > 
> >  1. CPU_KILL_ME - CPU has invoked cpu_ops->die, indicating the
> > master CPU to synchronise by issuing a cpu_ops->cpu_kill.
> > 
> >  2. CPU_STUCK_IN_KERNEL - CPU couldn't invoke die(), instead is
> > looping in the kernel. This information could be used by say,
> > kexec to check if it is really safe to do a kexec reboot.
> > 
> >  3. CPU_PANIC_KERNEL - CPU detected some serious issues which
> > requires kernel to crash immediately. The secondary CPU cannot
> > call panic() until it has initialised the GIC. This flag can
> > be used to instruct the master to do so.
> 
> When would we use this last case?

It's used in a subsequent series when verifying the ASID bits. I haven't
followed the previous discussions but I guess Suzuki aims to panic the
whole kernel rather than just stop the current CPU when incompatible
ASID size is found.

-- 
Catalin
