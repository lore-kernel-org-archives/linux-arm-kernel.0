From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 10 Jun 2011 15:54:05 +0100 (BST)
Subject: [linux-pm] [RFC PATCH v4] ARM hibernation/suspend-to-disk support
In-Reply-To: <20110610140201.GM24424@n2100.arm.linux.org.uk>
References: <201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101110130.11513@localhost6.localdomain6>
	<20110610134311.GK24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101444490.20826@localhost6.localdomain6>
	<20110610140201.GM24424@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106101507390.20826@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2011, Russell King - ARM Linux wrote:

>> [ ... ]
> I think there's a fundamental problem here - what's required for S2RAM
> is not what's required for hibernate.  After cpu_suspend() has done
> its job, you are in a _very_ specific environment designed for the last
> stages of S2RAM _only_ and not hibernate.
>
> In order to use cpu_suspend() for hibernate, it requires a completely
> different path entirely, and there's no getting away from that.
>
> You can see that when you analyze the differences between S2RAM and
> hibernate, when you realize that the final part of the S2RAM process
> (which happens after cpu_suspend() returns) on many SoCs is dealing
> with putting SDRAM into self-refresh mode before writing some kind of
> power mode register to tell the power supply to kill power to most
> of the platform.  That is all _very_ SoC specific.

Yes, that's what I'm trying to say - the _final_ stage, for s2ram, sends 
the SoC to low-power.
Up until there, we do the same for hibernation, don't we ? Where exactly 
is it different ?

>
> Also realize that the code which executes after cpu_suspend() returns
> is _not_ running in the same context as the code which called
> cpu_suspend() - cpu_suspend() has modified the stack pointer to store
> the CPU specific state and that is not the same stack pointer as was
> the case before cpu_suspend() was called.

Yes, the function isn't "well behaved" from the ABI point of view because 
it doesn't preserve registers (including the stack), but that can be 
accommodated by the caller.
The current s2ram callers have to accommodate that as well. Which is 
ultimately easy for them - since poweroff doesn't care.


The only reason why hibernation / swsusp_arch_suspend() is different there 
is because the activity _after_ cpu_suspend() is extensive and _can fail_ 
(saving the image); on that failure, one would prefer to see an error 
message and continue instead of panicing the system. So the stack change 
you mention needs to be addressed, swsusp_arch_suspend() must be a 
well-behaved function from the ABI point of view.


Normally, if all goes _right_, swsusp_save() does not return either. It 
ends powering the system off. If one were willing to die without message 
on failure to save the snapshot to disk, and would be willing to block 
cpu_suspend during writing the snapshot (to guarantee sleep_save_sp isn't 
changing) one wouldn't need to care about the stack and could simply:

ENTRY(swsusp_arch_suspend)
 	mrs	r1, cpsr
 	mrs	r2, spsr
 	stmfd	sp! {r1-r12,lr}
 	bl	__swsusp_arch_get_vpoffset
 	mov	r1, r0
 	adr	r3, .Lresume_post_mmu
 	bl	cpu_suspend
 	bl	swsusp_save
0:
 	b	0b		@ should never reach this
ENDPROC(swsusp_arch_suspend)


Resume is quite trivial either way:

ENTRY(swsusp_arch_resume)
         setmode PSR_I_BIT | PSR_F_BIT | SVC_MODE, r2
         ldr     sp, =(__swsusp_resume_stk + PAGE_SIZE / 2)
 	/*
 	 * replays image, and ends in cpu_reset(cpu_resume)
 	 */
         b       __swsusp_arch_restore_image
.Lresume_post_mmu:
         ldmfd   sp!, {r1-r12}
         msr     cpsr, r1
         msr     spsr, r2
         bl      cpu_init                        @ reinitialize other modes
         ldmfd   sp!, {lr}
         b       __swsusp_arch_resume_finish     @ cleanup
ENDPROC(swsusp_arch_resume)


>
> You don't want to run any of that code when you're dealing with hibernate,
> so expecting to be able to reuse these S2RAM paths is not realistic.

Hmm, well ... in the end, hibernation does:

 	<snapshot state>
 	<some long operation that writes the image out>
 	<poweroff>

while s2ram does:

 	<snapshot state>
 	<some quick operation setting low power modes>
 	<poweroff>

>
> What we could do is provide a cpu_hibernate() function which has saner
> semantics for saving the CPU specific state for hibernate.

Yes, that's exactly what I'm hoping for. From my point of view, this 
would, though, end up in:

cpu_soc_suspend:
 	cpu_hibernate_snapshot_state();
 	/* S2RAM codepath to send soc to low power */

cpu_soc_resume:
 	/* S2RAM codepath for waking up soc essentials */
 	cpu_hibernate_restore_state();

At least I can't come up with a really good reason why the state 
snapshotting operation would have to be different between s2ram and 
s2disk.


FrankH.
