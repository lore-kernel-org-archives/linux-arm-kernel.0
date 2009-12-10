From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 19:42:20 +0000
Subject: MXC: mx31pdk: mc13783: Trying to full support mc13783 regulators
In-Reply-To: <1260472292.2141.64.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260472292.2141.64.camel@climbing-alby>
Message-ID: <20091210194220.GE13210@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 08:11:32PM +0100, Alberto Panizzo wrote:
> ------------[ cut here ]------------
> WARNING: at kernel/lockdep.c:3154 check_flags+0xc0/0x1d4()
> Modules linked in:
> [<c002aa50>] (unwind_backtrace+0x0/0xdc) from [<c003db08>]
> (warn_slowpath_common+0x4c/0x80)
> [<c003db08>] (warn_slowpath_common+0x4c/0x80) from [<c005fdbc>]
> (check_flags+0xc0/0x1d4)
> [<c005fdbc>] (check_flags+0xc0/0x1d4) from [<c006527c>] (lock_acquire
> +0x40/0x98)
> [<c006527c>] (lock_acquire+0x40/0x98) from [<c02b2670>] (_spin_lock
> +0x40/0x78)
> [<c02b2670>] (_spin_lock+0x40/0x78) from [<c00a3670>] (set_task_comm
> +0x18/0x34)
> [<c00a3670>] (set_task_comm+0x18/0x34) from [<c0052730>] (kthreadd
> +0x24/0xf4)
> [<c0052730>] (kthreadd+0x24/0xf4) from [<c0025f78>] (kernel_thread_exit
> +0x0/0x8)
> ---[ end trace 1b75b31a2719ed1c ]---
> possible reason: unannotated irqs-on.
> irq event stamp: 1
> hardirqs last  enabled at (0): [<(null)>] (null)
> hardirqs last disabled at (1): [<c0024fcc>] ret_slow_syscall+0xc/0x1c
> softirqs last  enabled at (0): [<c003c548>] copy_process+0x35c/0xec4
> softirqs last disabled at (0): [<(null)>] (null)

BTW, this warning is created by the hidden irqs-on in the ret_slow_syscall
path - clearly we can't call lockdep to tell it that IRQs are now on once
they are because we'll generally be in userspace at that point.  I'm not
sure what the right answer to this is yet.
