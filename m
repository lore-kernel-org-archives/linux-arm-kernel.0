From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 09 Dec 2017 16:33:58 +0000
Subject: 4.15-rc2 crash on RPi2 in teardown_hyp_mode()
In-Reply-To: <d0168f56-cb8e-add8-5fd0-18599af13886@suse.de>
References: <45e72322-52dd-4fdb-2e51-176524fb56a8@arm.com>
 <d0168f56-cb8e-add8-5fd0-18599af13886@suse.de>
Message-ID: <86a7yrsvwp.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 Dec 2017 15:48:05 +0000,
Andreas F?rber wrote:
> 
> [1  <text/plain; utf-8 (8bit)>]
> Hi,
> 
> Am 06.12.2017 um 15:11 schrieb Andre Przywara:
> > while trying to boot 4.15-rc1 on my Calxeda Midway I observed a crash
> [snip]
> 
> I'm seeing a possibly related crash in 4.15-rc2 on Raspberry Pi 2.
> Using its 4.15-rc2 dtb I see a ton of timer interrupt errors (attached)
> and then KVM runs into an error in unmap_hyp_range():
> 
> [    3.974575] kvm [1]: 8-bit VMID
> [    3.977734] kvm [1]: IDMAP page: 401000
> [    3.981632] kvm [1]: HYP VA range: c0000000:ffffffff
> [    3.987575] kvm [1]: Invalid trigger for IRQ19, assuming level low
> [    3.993864] kvm [1]: kvm_arch_timer: error setting vcpu affinity
> [    4.000174] Unable to handle kernel paging request at virtual address
> ae46a000
> [    4.007470] pgd = 6db59d0e
> [    4.010206] [ae46a000] *pgd=80000000306003, *pmd=00000000
> [    4.015666] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> [    4.021181] Modules linked in:
> [    4.024259] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 4.15.0-rc2-2.gef715eb-lpae #1
> [    4.031955] Hardware name: BCM2835
> [    4.035373] task: 27c0e1b0 task.stack: 6730d7bc
> [    4.039936] PC is at unmap_hyp_range+0x130/0x414
> [    4.044580] LR is at 0x40000000
> [...]
> [    4.273820] [<c0425b0c>] (unmap_hyp_range) from [<c0427728>]
> (free_hyp_pgds+0x10c/0x18c)
> [    4.281965] [<c0427728>] (free_hyp_pgds) from [<c0423338>]
> (teardown_hyp_mode+0x28/0x84)
> [    4.290109] [<c0423338>] (teardown_hyp_mode) from [<c04256b0>]
> (kvm_arch_init+0x324/0x52c)
> 
> 4.14.3 boots fine on RPi2 with the same dtb.
> 4.15-rc2 boots fine on RPi3 with its latest dtb.
> 
> I'm assuming there's two bugs here, one in the RPi2 dts for the

No. Or rather, the RPi bug is to lack a GIC altogether.

> arch_timer and that error triggering Andre's kvm teardown bug that
> hopefully will be fixed with Marc's patch.

Only you can tell. You'll probably need both of these patches:

https://lists.cs.columbia.edu/pipermail/kvmarm/2017-December/028864.html
https://lists.cs.columbia.edu/pipermail/kvmarm/2017-December/028865.html

	M.

-- 
Jazz is not dead, it just smell funny.
