From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 11:26:14 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308091439.15c7bafd@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130308091439.15c7bafd@skate>
Message-ID: <20130308182614.GF4094@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 09:14:39AM +0100, Thomas Petazzoni wrote:
> > The discussion was around the SOC specific tables in the driver and if
> > they should be in DT or C code. These tables very much describe the
> > hardware, and are copied from similar tables in the Marvell manuals.
> > 
> > For instance I repeated this idea:
> > 
> >    ranges =<MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
> >             MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
> >             MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
> >              [..]
> 
> A few other issues with this:
> 
>  * It forces us to repeat the base address of the NOR twice in the
>    Device Tree. Once in the ranges = <...> property of the MBus DT node,
>    and once in the reg = <...> property of the NOR DT node. Duplication
>    of identical information, isn't that something that sounds broken?

Uhm. That is how DT works. DT is not ment to be human readable, it is
a machine parsible format. Look at a DT that comes out of a full
featured firmware and there will be lots of duplicate information,
especially in ranges.

Downstream stanzas will *always* duplicate the information in upstream
ranges. The format absolutely requires it.
 
>  * If we do dynamic allocation of the base address, it means that the
>    DT is no longer an accurate representation of what happens for real.
>    The user will write 0xDEADBEEF in the DT, and will get its NOR
>    mapped at 0xBEEFDEAD. Isn't that uselessly confusing?

The *input* DTB may not match the *runtime* DTB, but the in-kernel
runtime DTB can be accurate.

> Sorry, but your proposal still has many, many disadvantages over the
> currently proposed solution, and no compelling argument other than your
> own perception that the DT should describing the address mapping.

Hold on here. Your current solution fails on the significant point
that the kernel hard codes CPU addresses and sets up windows on those
addresses. The DT is then required to exactly match those hard coded
addresess.

You dismissed this complaint by saying that would go away with dynamic
assignment - but, there isn't a complete proposal for this. For
instance, take this from Ezequiel:

>> If we want to upgrade this behavior and support dynamically
>> allocated windows, we can simply fix the device bus driver to find a
>> suitable address when there is no 'ranges' property for that chip
>> select.

Okay. So you drop the ranges property and dynamically assign. Go
through these questions:
 - What will the source DTS look like for this case?
 - What happens in the kernel when the child cfi-nor device is created?
 - Will you rely on the usual OF populate code?
 - If no, you write a custom OF populate code path, is that good for
   maintainability?
 - If yes, how do you make of_translate_address return the correct value
   so the cfi-nor platform device's resources and name are correct?
 - Are you going to patch the child's 'reg' value in the dtb?
 - How is patching 'reg' in a child different from patching 'ranges'
   in the parent? Is this any less confusing?
 - What value do you put in the source DTS for the child regs?
 - What value do you put in the runtime DTB for the child's reg?
 - How do you deal with other 'ranges' translation in enclosing
   stanzas?
 - What if the child doesn't have a 'reg' but has a 'ranges', for
   some reason?

Go through the same thinking process with my proposal. Now constrast
the two.

> With MBus, the DT cannot describe the address mapping because it is
> fundamentally dynamic. Why the heck would we describe NOR windows in
> the DT and not the PCIe ones? They are both dynamic in the exact same
> way.

They are not the same. The NOR flash has a DT stanza associated with
it. The dynamic PCIe windows do not. The need to describe the NOR
window int DT arises *directly* from the need to describe the NOR
device in DT.

Jason
