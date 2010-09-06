From: per.fransson.ml@gmail.com (Per Fransson)
Date: Mon, 6 Sep 2010 08:58:25 +0000 (UTC)
Subject: [PATCH] ARM: Implement =?utf-8?b?Y3B1X3Y3X3Jlc2V0Lg==?=
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
	<20100902115206.GK25559@gw.healthdatacare.com>
	<20100902121838.GB26319@n2100.arm.linux.org.uk>
	<20100902134834.GL25559@gw.healthdatacare.com>
	<20100903060443.GM25559@gw.healthdatacare.com>
Message-ID: <loom.20100906T103236-552@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg <mika.westerberg <at> iki.fi> writes:

> 
> On Thu, Sep 02, 2010 at 04:48:34PM +0300, Mika Westerberg wrote:
> > On Thu, Sep 02, 2010 at 01:18:38PM +0100, Russell King - ARM Linux wrote:
> > > > 
> > > > I tested this patch without that cache invalidate instruction + dsb
> > > > and it still hangs. Exactly the same code works perfectly when it is run
> > > > via 1:1 mapping.
> > > 

How do you run it via a 1-1 mapping? Do you call the physical address of
cpu_reset() from machine_kexec() after calling setup_mm_for_reboot()? I.e.

	outer_inv_all();
	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
	(virt_to_phys(cpu_reset))(reboot_code_buffer_phys);

In that case, we're relying on two pieces of code being identity mapped,
cpu_v7_reset() and relocate_new_kernel(). I still promote limiting the scope of
setup_mm_for_reboot() to the bare minimum, so as not to destroy the user-space
mapping. If we set up a 1-1 around cpu_reset() for example, couldn't we idle
away there until we are sure the MMU is off and *then* jump to the physical
address of relocate_new_kernel() which wouldn't have to be 1-1 mapped?

>         "After a CP15 c1 instruction disables the MMU, the processor
>         flushes all following instructions in the pipeline. The
>         processor then begins refetching instructions and uses flat
>         address mapping. In flat address mapping, PA = VA."
> 

If this is the case, the Qemu issue I mentioned here

  http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019678.html

wasn't so far off the mark after all =o)

Regards,
Per
