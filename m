From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 18 Nov 2014 22:11:03 +0000
Subject: [PATCH v5.5] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <20141118172545.GC14323@leverpostej>
References: <1415984735-32388-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141118165145.4F6A8C40966@trevor.secretlab.ca>
 <20141118172545.GC14323@leverpostej>
Message-ID: <20141118221103.4ECB3C40966@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Nov 2014 17:25:45 +0000
, Mark Rutland <mark.rutland@arm.com>
 wrote:
> On Tue, Nov 18, 2014 at 04:51:45PM +0000, Grant Likely wrote:
> > On Fri, 14 Nov 2014 18:05:35 +0100
> > , Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >  wrote:
> > > Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
> > > that was passed to the kernel by the bootloader. This allows userland
> > > applications such as kexec to access the raw binary.
> > > 
> > > The fact that this node does not reside under /sys/firmware/device-tree
> > > is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
> > > communicate just the UEFI and ACPI entry points, but the FDT is never
> > > unflattened and used to configure the system.
> > > 
> > > A CRC32 checksum is calculated over the entire FDT blob, and verified
> > > at late_initcall time. The sysfs entry is instantiated only if the
> > > checksum is valid, i.e., if the FDT blob has not been modified in the
> > > mean time. Otherwise, a warning is printed.
> > > 
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > 
> > So, I have a doubt...
> > 
> > When this patch is merged, we have two separate ABIs for extracting the
> > DT from the kernel. /proc/device-tree and /sys/firmware/fdt. Merging it
> > into mainline means we're committed to supporting both interfaces.
> > 
> > The whole purpose of this patch is to support kexec. Specifically, kexec
> > on ACPI platforms that don't currently unflatten the tree.*  Would it
> > not be better to always unflatten the tree and have only one interface
> > that kexec needs to use to obtain the tree?
> 
> The whole reasoning for not unflattening the DTB in the presence of ACPI
> is that it's unlikely we can stop drivers using DTB information in
> addition to ACPI, leaving us with a completely non-standard mess. We
> really don't want people mixing the two, and it's going to be a struggle
> if the information is readily available (even preventing probing based
> on compatible string isn't enough because of some drivers which probe
> from an initcall or look up magic paths).
> 
> So if we were to unflatten the tree in the ACPI case, at a minimum it
> needs to be unflattened to a separate root that only exists for sysfs,
> and is not at exposed to the mercy of the rest of the kernel.

Not setting the of_root pointer would do that. That should work.

> > * It also helps with exposing the reserved map to userspace, but kexec
> >   has done without that feature for years, and it is in the process of
> >   being deprecated in favour of /reserved-memory anyway.
> 
> This is the first I'd heard of the reserve map being deprecated, and
> we're going to have DTs with reserved map entries for a long time going
> forwards.

Deprecated, not removed or disabled. It will still work pretty much
forever, but users should be encouraged to move to the reserve-memory
tree.

> Can't we expose the header fields under something like
> /sys/firmware/devicetree/dtb-header/, parallel to the usual
> /sys/firmware/devicetree/base for nodes?

We could do that too.

Honestly though, I'm just unsure of what the best thing to do is. If you
and a few others tell me that, "no, exporting the raw dtb is the right
thing to do", then I'll be okay, merge the patch and sleep properly.

If you think my concerns have merit though, then say so and we'll do one
of the above.

g.
