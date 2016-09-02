From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 2 Sep 2016 19:11:54 +0900
Subject: [PATCH v24 9/9] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20160831050215.GQ20080@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015747.28591-1-takahiro.akashi@linaro.org>
 <20160819132641.GA12709@rob-hp-laptop>
 <20160822042832.GJ20080@linaro.org>
 <CAL_JsqJ5SqesEL5QWX_NJj+gL2jpne4NN_WzADiH+1VB7CkvOA@mail.gmail.com>
 <20160830234545.GP20080@linaro.org>
 <20160831050215.GQ20080@linaro.org>
Message-ID: <20160902101153.GZ20080@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wed, Aug 31, 2016 at 02:02:16PM +0900, AKASHI Takahiro wrote:
> On Wed, Aug 31, 2016 at 08:45:46AM +0900, AKASHI Takahiro wrote:
> > Rob,
> > 
> > On Tue, Aug 30, 2016 at 11:34:10AM -0500, Rob Herring wrote:
> > > On Sun, Aug 21, 2016 at 11:28 PM, AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > > Rob,
> > > > [Cc: Mark]
> > > >
> > > > On Fri, Aug 19, 2016 at 08:26:41AM -0500, Rob Herring wrote:
> > > >> On Tue, Aug 09, 2016 at 10:57:47AM +0900, AKASHI Takahiro wrote:
> > > >> > From: James Morse <james.morse@arm.com>
> > > >> >
> > > >> > Add documentation for
> > > >> >     linux,crashkernel-base and crashkernel-size,
> > > >> >     linux,usable-memory-range, and
> > > >> >     linux,elfcorehdr
> > > >> > used by arm64 kexec/kdump to decribe the kdump reserved area, and
> > > >> > the elfcorehdr's location within it.
> > > >> >
> > > >> > Signed-off-by: James Morse <james.morse@arm.com>
> > > >> > [takahiro.akashi at linaro.org:
> > > >> >     renamed "usable-memory" to "usable-memory-range",
> > > >> >     added "linux,crashkernel-base" and "-size" ]
> > > >> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > >> > ---
> > > >> >  Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
> > > >> >  1 file changed, 50 insertions(+)
> > > >> >
> > > >> > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > > >> > index 6ae9d82..236188a 100644
> > > >> > --- a/Documentation/devicetree/bindings/chosen.txt
> > > >> > +++ b/Documentation/devicetree/bindings/chosen.txt
> > > >> > @@ -52,3 +52,53 @@ This property is set (currently only on PowerPC, and only needed on
> > > >> >  book3e) by some versions of kexec-tools to tell the new kernel that it
> > > >> >  is being booted by kexec, as the booting environment may differ (e.g.
> > > >> >  a different secondary CPU release mechanism)
> > > >> > +
> > > >> > +linux,crashkernel-base
> > > >> > +linux,crashkernel-size
> > > >> > +----------------------
> > > >> > +These properties (currently used on PowerPC and arm64) indicates
> > > >> > +the base address and the size, respectively, of the reserved memory
> > > >> > +range for crash dump kernel.
> > > >> > +e.g.
> > > >> > +
> > > >> > +/ {
> > > >> > +   chosen {
> > > >> > +           linux,crashkernel-base = <0x9 0xf0000000>;
> > > >> > +           linux,crashkernel-size = <0x0 0x10000000>;
> > > >> > +   };
> > > >> > +};
> > > >> > +
> > > >> > +linux,usable-memory-range
> > > >> > +-------------------------
> > > >> > +
> > > >> > +This property (currently used only on arm64) holds the memory range,
> > > >> > +the base address and the size, which can be used as system ram on
> > > >> > +the *current* kernel. Note that, if this property is present, any memory
> > > >> > +regions under "memory" nodes in DT blob or ones marked as "conventional
> > > >> > +memory" in EFI memory map should be ignored.
> > > >> > +e.g.
> > > >> > +
> > > >> > +/ {
> > > >> > +   chosen {
> > > >> > +           linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
> > > >> > +   };
> > > >> > +};
> > > >>
> > > >> I've read the discussion on this. I think you should use the existing
> > > >> linux,usable-memory property in the memory nodes. If UEFI systems don't
> > > >> have memory nodes, then you can find an UEFI way to describe this. DT is
> > > >> not the dumping ground for what doesn't fit in UEFI. How do x86 systems
> > > >> work?
> > > >
> > > > Kdump for x86 passes the range of usable memory to crash dump kernel
> > > > either via:
> > > > (a) "memmap=nn at ss" command line parameter, or
> > > > (b) faked BIOS e820 map (a sort of memory map table)
> > > >
> > > > (a) was rejected by Mark [1], and (b) is x86-specific.
> > > >
> > > > I believe that my approach is better because it works in the same way
> > > > either on UEFI systems or DT-based systems.
> > > 
> > > So we have a new way for both UEFI and DT. If UEFI folks can't come up
> > > with a standard way to do things in the UEFI standard, then we just
> > > dump them into DT?
> > 
> > No, I don't think so.
> > According to "Documentation/devicetree/bindings/chosen.txt,
> >   "The chosen node does not represent a real device, but serves as a place
> >    for passing data between firmware and the operating system, like boot
> >    arguments."
> > 
> > Since kexec/dump is some sort of boot loader, it all makes sense to
> > add a new property as an interface from the old kernel(kexec/dump)
> > to the new kernel. So my approach doesn't break any DT rules.
> > 
> > Please note that, even on UEFI/APCI systems, there are already a few
> > properties used under /chosen, like "linux,uefi-system-table" and 
> > "linux,mmap-*."
> > (Those properties are currently *not* defined in this document, though.)
> > 
> > > I'd rather see alignment with existing DT systems
> > > (PPC) and in particular the tools.
> > 
> > I'm not sure what you mean here, but I guess:
> > 1) On DT-only systems, we should follow the way that PPC does.
> >    (That is, adding "usable-memory" property to each "memory" node.)
> > 2) On UEFI/ACPI system, we must invent a new own way for our purpose
> >    because, as I said before, there is no standard, but x86-specific way. 
> > 
> > Is this what you want to do?

Yes?

> > If so,
> > do you agree to my approach of adding "linux,usable-memory-range" property
> > to /chosen *for UEFI/ACPI use*?
> 
> I've got another idea here: using "/memreserve/" field.

We'd better to use "reserved-memory" node:
  reserved-memory {
    #address-cells = <2>;
    #size-cells = <2>;
    ranges;

    crash_dump at 80000000 {
      reg = <0x0 0x80000000 0x0 0x8000000>;
      no-map;
    }
    ...
  }
so that we can clearly state that those regions are for kdump.
Unfortunately, we can't place "reserved-memory" under /chosen.

> All the memory regions used by the crashed kernel would be added
> as "/memreserve/" and be memblock_reserve'd later in crash dump kernel.
> Consequently, they will be excluded from the usable memory.
> 
> Obviously,
> - this approach will work both on UEFI/ACPI and DT-only systems, and
> - patch#2 ("memblock: add memblock_cap_memory_range()"), as well as
>   "linux,usable-memory-range" property, is no longer necessary.
>   (So nothing new, except for "linux.elfcorehdr," will be invented.)
> 
> But on the other hand,
> - arm64 and ppc do the different ways even though both are DT systems,
> - those reserved regions are still *in* linear mapping and appear as
>   "System RAM" in /proc/iomem, and
> - this may imply that we cannot do kexec on crash dump kernel.

If you never accept my approach of adding "linux,usable-memory-range,"
I will send a new version, v26, based on "reserved-memory" next week.

(The only change is to remove patch#2/#3 from v25, though.)

-Takahiro AKASHI


> -Takahiro AKASHI
> 
> 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > Rob
