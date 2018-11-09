From: vincent.whitchurch@axis.com (Vincent Whitchurch)
Date: Fri, 9 Nov 2018 14:53:01 +0100
Subject: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
In-Reply-To: <20181102135322.GA5289@linux-8ccs>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
 <20181031155341.GA27878@linux-8ccs>
 <20181101152913.r2isskngiahi6o2u@axis.com>
 <20181102135322.GA5289@linux-8ccs>
Message-ID: <20181109135300.3tyord6amvd7wy54@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 02:53:22PM +0100, Jessica Yu wrote:
> +++ Vincent Whitchurch [01/11/18 16:29 +0100]:
> > On Wed, Oct 31, 2018 at 04:53:41PM +0100, Jessica Yu wrote:
> > > Could this be done in modpost? I'm guessing the answer is no as some
> > > relocations may rely on that bit being set in st_value, right?
> > > Therefore we can only clear the bit _after_ relocations to the module
> > > are applied at runtime, correct?
> > 
> > Yes, that's correct, it needs to be done after the relocations.
> > 
> > > I'm not against having an arch-specific kallsyms fixup function, my
> > > only concern would be if this would interfere with the delayed
> > > relocations livepatching does, if there are plans in the future to
> > > have livepatching on arm (IIRC there was an attempt at a port in
> > > 2016). If there exists some Thumb-2 relocation types that rely on that
> > > lowest bit in st_value being set in order to be applied, and we clear
> > > it permanently from the symtab, then livepatching wouldn't be able to
> > > apply those types of relocations anymore. If this is a legitimate
> > > concern, then perhaps an alternative solution would be to have an
> > > arch-specific kallsyms symbol-value-fixup function for accesses to
> > > sym.st_value, without modifying the module symtab.
> > 
> > I'm not familiar with livepatching, but yes, if it needs to do
> > relocations later I guess we should preserve the original value.
> 
> Yeah, I think the symtab needs to remain unmodified for livepatch to
> be able to do delayed relocations after module load.
> 
> > I gave the alternative solution a go and it seems to work.
> > add_kallsyms() currently overwrites st_info so I had to move the
> > elf_type to the unused st_other field instead to preserve st_info:
> 
> I think that's fine, I think the only usages of st_other I've found
> are during relocations, and the field is big enough for a char, so it
> should be fine to reuse it afterwards.

If livepatch can do relocations later, doesn't that mean that we _can't_
reuse st_other for storing the elf_type?  OTOH, the current code
overwrites st_info, and I see that used from various archs' relocation
functions too, so perhaps I'm missing something.
