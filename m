From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Sep 2016 00:39:15 +0100
Subject: [PATCH v24 9/9] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20160819132641.GA12709@rob-hp-laptop>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015747.28591-1-takahiro.akashi@linaro.org>
 <20160819132641.GA12709@rob-hp-laptop>
Message-ID: <20160927233915.GB3437@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Reviving an old thread -- "rock" and "hard place" come to mind.

On Fri, Aug 19, 2016 at 08:26:41AM -0500, Rob Herring wrote:
> On Tue, Aug 09, 2016 at 10:57:47AM +0900, AKASHI Takahiro wrote:
> > From: James Morse <james.morse@arm.com>

> > +linux,usable-memory-range
> > +-------------------------
> > +
> > +This property (currently used only on arm64) holds the memory range,
> > +the base address and the size, which can be used as system ram on
> > +the *current* kernel. Note that, if this property is present, any memory
> > +regions under "memory" nodes in DT blob or ones marked as "conventional
> > +memory" in EFI memory map should be ignored.
> > +e.g.
> > +
> > +/ {
> > +	chosen {
> > +		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
> > +	};
> > +};
> 
> I've read the discussion on this. I think you should use the existing 
> linux,usable-memory property in the memory nodes. If UEFI systems don't 
> have memory nodes, then you can find an UEFI way to describe this. DT is 
> not the dumping ground for what doesn't fit in UEFI. How do x86 systems 
> work?

Having looked at the proposals, I'm personally much keener on the approach
above (modulo naming and wording) than trying to bolt memory nodes onto a UEFI
system, or using reserved-memory to describe the inverse of the allowable
range.

I completely agree that we want one solution for DT-only and DT+UEFI.

While those approaches reuse existing infrastructure, they end up creating more
work, and I believe that they create more scope for painful problems. As kdump
is already a constrained case, I think that it's reasonable to have a
linux-specific property as above.

I also think we need to figure out how we expect this to work for the
kexec_file_load case, as that has a criticial impact on the above (e.g. what's
preferable out of cmdline options vs dt properties).

Can we try to sync at connect to discuss this?

Thanks,
Mark.
