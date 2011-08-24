From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 13:42:01 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <20110824123431.GH23757@pulham.picochip.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<20110824123431.GH23757@pulham.picochip.com>
Message-ID: <20110824124201.GN32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 01:34:31PM +0100, Jamie Iles wrote:
> Hi Will,

Hello Jamie,

> On Tue, Aug 23, 2011 at 10:46:44PM +0100, Will Deacon wrote:
> > Currently, SMP kexec relies on platform_cpu_kill (a CPU hotplug callback)
> > doing the right thing. I'm working on a generic SMP soft reboot implementation
> > but this isn't quite working yet (and my git repo is predictably offline
> > at the moment so I can't provide a link to the patches).
> 
> I've tried this on picoxcell and reboot with arm_machine_reset() works 
> nicely, but I couldn't get kexec to work (though it didn't work without 
> your patches...).

Ok, thanks for giving it a go though!

> With your patches applied I get the following output on booting the new 
> kernel:
> 
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.1.0-rc3+ (jamiei at pulham) (gcc version 4.5.3 20110223 (prerelease) (GCC) ) #40 PREEMPT Wed Aug 24 13:21:06 BST 2011
> [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387f
> [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
> [    0.000000] Machine: Picochip picoXcell
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.
> [    0.000000]
> [    0.000000] [<c001368c>] (unwind_backtrace+0x0/0xe0) from [<c02c875c>] (panic+0x68/0x1a0)
> [    0.000000] [<c02c875c>] (panic+0x68/0x1a0) from [<c03c5180>] (memblock_alloc_base+0x2c/0x34)
> [    0.000000] [<c03c5180>] (memblock_alloc_base+0x2c/0x34) from [<c03be894>] (early_alloc.clone.1+0x10/0x28)
> [    0.000000] [<c03be894>] (early_alloc.clone.1+0x10/0x28) from [<c03bf2b4>] (paging_init+0x4c4/0x6d0)
> [    0.000000] [<c03bf2b4>] (paging_init+0x4c4/0x6d0) from [<c03bca54>] (setup_arch+0x424/0x780)
> [    0.000000] [<c03bca54>] (setup_arch+0x424/0x780) from [<c03bb510>] (start_kernel+0xac/0x2e4)
> [    0.000000] [<c03bb510>] (start_kernel+0xac/0x2e4) from [<00008040>] (0x8040)
> 
> and the allocation that fails appears to be allocating the vectors page.  
> Without your patches I don't get any output though so it's a definite 
> improvement!

Wahey, that's not bad. If you're starting to boot the new kernel then lots
of the tricky stuff is out of the way.

> Note that this is a device tree enabled platform so there is no 
> /proc/atags.  I'm happy to test any related patches on our platform, but 
> kexec isn't something we really use.

This is almost certainly the problem as the ARM kexec code doesn't have FDT
support afaict, so the new kernel doesn't think it has any memory. Can you
try hardcoding a command line into the kernel image which specifies the
memory layout?

I think the way forward with the kexec work is for me to get it working
solidly on UP platforms (including Thumb-2 and FDT) and then add SMP support
later on.

Will
