From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Apr 2012 10:46:23 +0100
Subject: RFC: setting up a pci-to-amba bridge device
In-Reply-To: <20120405093152.GA24229@mail.gnudd.com>
References: <20120405093152.GA24229@mail.gnudd.com>
Message-ID: <20120405094623.GF24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 11:31:52AM +0200, Alessandro Rubini wrote:
> * CONFIG_ARM_AMBA: Russell, you suggested to rename to
> CONFIG_ARM_PRIMECELL, for a good reason.  Shall I take over this
> and submit patches or is just a theoretical idea?

Yes please.

> * <asm/sizes.h> I submitted patches to move to <linux/sizes.h> as you
> suggested but got no feedback. This was on March 1st, in a patch set
> with other stuff that was not good.  Should I re-run the procedure,
> with a sizes.h-only patch set?  If so, who is responsible to merge
> this change which is somewhat multi-arch?  If I do it, I'd leave the
> asm/ headers in place to not disturb current users, coming back to
> this after a few months to add a #warning so users can fix themselves,
> to then remove the asm/ headers after other few months. Ok?

It's been moved to asm-generic.h, and we now use:
generic-y += sizes.h

in our arch/arm/include/asm/Kbuild.  Even so, I think if everyone starts
to use it, it should be in include/linux.

> * clk API: you suggested to wait for the unified implementation
> to be merged and that's fine (I haven't checked recently the status,
> but I'm going to do my homework here).

This is now in mainline.

> * memory areas (this is a new point, not present in my older message).
> When amba/bus.c requests the device resources, it fails because of
> the hosting PCI bus:
> 
>    [    6.866591] request [mem 0xcec00000-0xcec00fff]
>    [    6.871110] conflict [mem 0xc7f00000-0xdfffffff]
> 
> This is the current /proc/iomem, after ignoring the error:
> 
>    c7f00000-dfffffff : PCI Bus 0000:00
>      ce000000-dfffffff : PCI Bus 0000:01
>        ce000000-dfffffff : PCI Bus 0000:02
>          ce000000-d1ffffff : PCI Bus 0000:03
>            cec00000-cec00fff : uart-pl011
> 
> Any suggestion about a good solution to this "ownership" problem of memory
> areas?

That's because we're wanting the parent resource, not &iomem_resource
to be passed.  If you do that it should work fine.  I'm no fan of
insert_resource() - I've seen it screw up the resource tree by
misplacing or swapping the order of device resources when they should've
actually failed.
