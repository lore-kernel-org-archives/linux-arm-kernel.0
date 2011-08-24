From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 13:34:31 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110824123431.GH23757@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Aug 23, 2011 at 10:46:44PM +0100, Will Deacon wrote:
> Hello,
> 
> This is version 4 of the patches originally posted here:
> 
> v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
> v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
> v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html
> 
> There are many changes since v3. Notably:
> 	- Support for Thumb-2
> 	- Based on 3.1-rc3 (now that some of the previous patches have
> 	  been merged)
> 	- The reserved stack page now sits below swapper and is reserved
> 	  by memblock during memory init. This has the advantage of being
> 	  at a known physical address for a platform, which will be helpful
> 	  for non-hotplug SMP booting.
> 
> Currently, SMP kexec relies on platform_cpu_kill (a CPU hotplug callback)
> doing the right thing. I'm working on a generic SMP soft reboot implementation
> but this isn't quite working yet (and my git repo is predictably offline
> at the moment so I can't provide a link to the patches).

I've tried this on picoxcell and reboot with arm_machine_reset() works 
nicely, but I couldn't get kexec to work (though it didn't work without 
your patches...).

With your patches applied I get the following output on booting the new 
kernel:

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.1.0-rc3+ (jamiei at pulham) (gcc version 4.5.3 20110223 (prerelease) (GCC) ) #40 PREEMPT Wed Aug 24 13:21:06 BST 2011
[    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387f
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
[    0.000000] Machine: Picochip picoXcell
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.
[    0.000000]
[    0.000000] [<c001368c>] (unwind_backtrace+0x0/0xe0) from [<c02c875c>] (panic+0x68/0x1a0)
[    0.000000] [<c02c875c>] (panic+0x68/0x1a0) from [<c03c5180>] (memblock_alloc_base+0x2c/0x34)
[    0.000000] [<c03c5180>] (memblock_alloc_base+0x2c/0x34) from [<c03be894>] (early_alloc.clone.1+0x10/0x28)
[    0.000000] [<c03be894>] (early_alloc.clone.1+0x10/0x28) from [<c03bf2b4>] (paging_init+0x4c4/0x6d0)
[    0.000000] [<c03bf2b4>] (paging_init+0x4c4/0x6d0) from [<c03bca54>] (setup_arch+0x424/0x780)
[    0.000000] [<c03bca54>] (setup_arch+0x424/0x780) from [<c03bb510>] (start_kernel+0xac/0x2e4)
[    0.000000] [<c03bb510>] (start_kernel+0xac/0x2e4) from [<00008040>] (0x8040)

and the allocation that fails appears to be allocating the vectors page.  
Without your patches I don't get any output though so it's a definite 
improvement!

Note that this is a device tree enabled platform so there is no 
/proc/atags.  I'm happy to test any related patches on our platform, but 
kexec isn't something we really use.

Jamie
