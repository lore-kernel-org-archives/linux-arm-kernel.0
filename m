From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Feb 2015 15:58:59 +0000
Subject: (AArch64) NR_CPUS limit
In-Reply-To: <CANMBJr45rUdK0AKQ6OY3OS8XMAUQvosuDuvBxtxWE7sYOABR-w@mail.gmail.com>
References: <54D27FBF.8040909@redhat.com>
 <CANMBJr45rUdK0AKQ6OY3OS8XMAUQvosuDuvBxtxWE7sYOABR-w@mail.gmail.com>
Message-ID: <20150205155859.GB20735@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 05:49:02AM +0000, Tyler Baker wrote:
> Hi Jon,
> 
> On 4 February 2015 at 12:23, Jon Masters <jcm@redhat.com> wrote:
> > Hi Folks,
> >
> > We're currently patching our kernels with a (much) higher maximum for
> > NR_CPUS. There are some very large ARM systems coming soon - any
> > objections to increasing this to something like 1024 or 4096?

There's already a patch out there going for 4096:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318853.html

That seems large enough to cater for everyone. I see x86_64 will go up
to 8192 CPUs in some configurations, and if anyone wants NR_CPUS parity,
now is the time to speak...

Do we have an idea as to what the memory footprint and/or runtime
performance hit looks like going from NR_CPUS=64 to NR_CPUS=4096? It
would be nice to know if there's a scalability problem anywhere in the
arch code.

We also want defconfig to work on as many systems as possible, and it
would be nice to know whether or not bumping the default is feasible.

> FWIW, I have a few ARMv7 systems complaining about this issue as well.
> 
> [    0.000000] WARNING: CPU: 0 PID: 0 at
> ../arch/arm/kernel/devtree.c:144 arm_dt_init_cpu_maps+0x118/0x1e8()
> [    0.000000] DT /cpu 9 nodes greater than max cores 8, capping them
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 3.19.0-rc7-00032-g5ee0e962603e #1
> [    0.000000] Hardware name: Hisilicon HiP04 (Flattened Device Tree)
> [    0.000000] [<c0215d94>] (unwind_backtrace) from [<c021165c>]
> (show_stack+0x10/0x14)
> [    0.000000] [<c021165c>] (show_stack) from [<c091841c>]
> (dump_stack+0x78/0x94)
> [    0.000000] [<c091841c>] (dump_stack) from [<c0247bc8>]
> (warn_slowpath_common+0x74/0xb0)
> [    0.000000] [<c0247bc8>] (warn_slowpath_common) from [<c0247c98>]
> (warn_slowpath_fmt+0x30/0x40)
> [    0.000000] [<c0247c98>] (warn_slowpath_fmt) from [<c0c624b4>]
> (arm_dt_init_cpu_maps+0x118/0x1e8)
> [    0.000000] [<c0c624b4>] (arm_dt_init_cpu_maps) from [<c0c613a8>]
> (setup_arch+0x714/0xa98)
> [    0.000000] [<c0c613a8>] (setup_arch) from [<c0c5e940>]
> (start_kernel+0x94/0x3d4)
> [    0.000000] [<c0c5e940>] (start_kernel) from [<10208084>] (0x10208084)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> 
> Is there an advantage (other than convenience) to increasing this
> default, then say using the nr_cpu[1] kernel parameter?

NR_CPUS >= nr_cpus due to compile-time allocations relying on NR_CPUS.
You can't allocate more space for these at runtime...

Mark.
