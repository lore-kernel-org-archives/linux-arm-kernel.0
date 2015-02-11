From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 11 Feb 2015 07:07:45 +0000
Subject: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb
 property
In-Reply-To: <CAKv+Gu_uXs7tto3JdEOoEfqFpjUKdwFo4dSN3X3399uc+sJKrQ@mail.gmail.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
 <20150202134033.GR4278@bivouac.eciton.net>
 <20150202135051.GA3825@xora-haswell.xora.org.uk>
 <20150202163253.GG21175@leverpostej>
 <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
 <54D5884A.6050009@linaro.org>
 <CAKv+Gu-oDRjYPC3SxSDVZ7rV7eG9DCct=kNS0xBVd28YoV5fSg@mail.gmail.com>
 <20150209114624.GD4250@leverpostej>
 <CAKv+Gu-fnpxr-3T9RPuf4de2DGVE6xkDEcfFyzYp5KJCJH_fzw@mail.gmail.com>
 <alpine.DEB.2.02.1502110607250.29696@kaball.uk.xensource.com>
 <CAKv+Gu_uXs7tto3JdEOoEfqFpjUKdwFo4dSN3X3399uc+sJKrQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1502110704420.29696@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Feb 2015, Ard Biesheuvel wrote:
> > Given that Dom0 is not booted via EFI but as zImage, how are we going to
> > pass the two EFI table pointers to Linux? Via Device Tree? It doesn't
> > look like a great improvement to me.
> >
> 
> The EFI system table and memory map pointers shall be passed to the
> kernel in the exact same way as the stub does: via the /chosen node.
> This is currently documented in Documentation/arm/uefi.txt but it
> should be promoted to a proper binding.

Ah, right.


> > Generating those two EFI tables shouldn't be a problem though.
> >
> >
> 
> Good.
> 
> >> As this basically promotes the stub<->kernel interface to an external
> >> ABI, the current documentation about the /chosen node properties
> >> should also be promoted to a proper binding, with the above mandated
> >> minimal subset added as well.
> >>
> >> There are some minimal changes required to the current kernel code to
> >> adhere to the above: primarlly to deal with a NULL runtime services
> >> pointer, which is arguably an improvement anyway.
> >
> > This is not needed, if not for the first generation of patches
> >
> >
> 
> It is needed: the UEFI code needs to understand that the runtime
> pointer in the EFI system table may be NULL, in which case no virtual
> remapping or installation of the runtime services should take place.
> Whether Xen ends up installing its own runtime services is a separate
> matter.
> 
> >> Topic #2: how to identify an 'empty' DTB
> >>
> >> The proposed policy regarding whether DT or ACPI should be preferred
> >> if both methods are available hinges on being able to identify a DTB
> >> as containing a platform description or not. One suggested way of
> >> doing this is to make the stub add a /chosen node property that
> >> indicates that it didn't receive a DTB from the firmware, nor loaded
> >> one from the file system, but created an empty one from scratch.
> >>
> >> Considering the previous topic, i.e., the promotion of the
> >> stub<->kernel interface to external ABI, we should not be frivolous
> >> about adding new properties, and adding a 'stub-generated-dtb'
> >> property should be avoided if there is a better way to deal with this.
> >> Also, e.g., when booting via GRUB, it may in fact be GRUB and not the
> >> stub that creates the DTB (when booting with an initrd, for instance)
> >> so GRUB would have to be modified as well. (If not, simply adding a
> >> initrd= property to the command line would result in the kernel
> >> preferring DT over ACPI all of a sudden, which surely, we all agree is
> >> undesirable behavior)
> >>
> >> So instead, we propose to use a heuristic to decide whether a DTB
> >> should be considered empty or not:
> >> If /chosen is the only level 1 node in the tree, the DTB is empty,
> >> otherwise it is not.
> >>
> >> This can be trivially implemented into the existing EFI early FDT
> >> discovery code, and does not require any other changes to the stub or
> >> GRUB.
> >>
> >> Please, could those affected by this comment whether this is feasible
> >> or not? Other comments/remarks also highly appreciated, of course,
> >
> > Wouldn't it make sense to use the same interface between Xen and Dom0
> > and between stub and kernel?
> 
> That is exactly the point: the stub communicates the EFI entry points
> (system table and memmap) via the device tree. If you are not booting
> via UEFI, there is no way you can execute the stub, so Xen needs to
> add those properties to the /chosen node directly, and make them point
> to data that the UEFI layer can understand.

OK, it looks like the right way of doing it to me.
