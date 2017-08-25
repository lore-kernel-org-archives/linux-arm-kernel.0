From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Aug 2017 11:22:50 +0100
Subject: [PATCH 08/14] arm64: kexec_file: create purgatory
In-Reply-To: <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <20170824165617.GC29665@leverpostej>
 <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
Message-ID: <20170825102250.GA3127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 10:00:59AM +0900, AKASHI Takahiro wrote:
> On Thu, Aug 24, 2017 at 05:56:17PM +0100, Mark Rutland wrote:
> > On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
> > > This is a basic purgtory, or a kind of glue code between the two kernel,
> > > for arm64. We will later add a feature of verifying a digest check against
> > > loaded memory segments.
> > > 
> > > arch_kexec_apply_relocations_add() is responsible for re-linking any
> > > relative symbols in purgatory. Please note that the purgatory is not
> > > an executable, but a non-linked archive of binaries so relative symbols
> > > contained here must be resolved at kexec load time.
> > > Despite that arm64_kernel_start and arm64_dtb_addr are only such global
> > > variables now, arch_kexec_apply_relocations_add() can manage more various
> > > types of relocations.
> > 
> > Why does the purgatory code need to be so complex?
> > 
> > Why is it not possible to write this as position-independent asm?
> 
> I don't get your point, but please note that these values are also
> re-written by the 1st kernel when it loads the 2nd kernel and so
> they must appear as globals.

My fear about complexity is that we must "re-link" the purgatory.

I don't understand why that has to be necessary. Surely we can have the
purgatory code be position independent, and store those globals in a
single struct purgatory_info that we can fill in from the host?

i.e. similar to what we do for values shared with the VDSO, where we
just poke vdso_data->field, no re-linking required.

Otherwise, why can't the purgatory code be written in assembly? AFAICT,
the only complex part is the hashing code, which I don't beleive is
strictly necessary.

[...]

> > > +/*
> > > + * Apply purgatory relocations.
> > > + *
> > > + * ehdr: Pointer to elf headers
> > > + * sechdrs: Pointer to section headers.
> > > + * relsec: section index of SHT_RELA section.
> > > + *
> > > + * Note:
> > > + * Currently R_AARCH64_ABS64, R_AARCH64_LD_PREL_LO19 and R_AARCH64_CALL26
> > > + * are the only types to be generated from purgatory code.
> > 
> > Is this all that has been observed, or is this ensured somehow?
> 
> It was observed by inserting a debug print message in this function,
> I'm not sure whether we can restrict only those three types.

If we have to perform linking, I don't think we can assume the above is
sufficient.

> > The arch_kexec_apply_relocations_add() function below duplicates a lot
> > of logic that already exists in the arm64 module loader's
> > apply_relocate_add() function.
> > 
> > Please reuse that code. Having a duplicate or alternative implementation
> > is just asking for subtle bugs.
> 
> Okey, I'll look at it.

Ok.

As above, I think it would be preferable that we avoid linking entirely.

Thanks,
Mark.
