From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 25 Aug 2017 10:00:59 +0900
Subject: [PATCH 08/14] arm64: kexec_file: create purgatory
In-Reply-To: <20170824165617.GC29665@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <20170824165617.GC29665@leverpostej>
Message-ID: <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 05:56:17PM +0100, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
> > This is a basic purgtory, or a kind of glue code between the two kernel,
> > for arm64. We will later add a feature of verifying a digest check against
> > loaded memory segments.
> > 
> > arch_kexec_apply_relocations_add() is responsible for re-linking any
> > relative symbols in purgatory. Please note that the purgatory is not
> > an executable, but a non-linked archive of binaries so relative symbols
> > contained here must be resolved at kexec load time.
> > Despite that arm64_kernel_start and arm64_dtb_addr are only such global
> > variables now, arch_kexec_apply_relocations_add() can manage more various
> > types of relocations.
> 
> Why does the purgatory code need to be so complex?
> 
> Why is it not possible to write this as position-independent asm?

I don't get your point, but please note that these values are also
re-written by the 1st kernel when it loads the 2nd kernel and so
they must appear as globals.

> > +/*
> > + * Apply purgatory relocations.
> > + *
> > + * ehdr: Pointer to elf headers
> > + * sechdrs: Pointer to section headers.
> > + * relsec: section index of SHT_RELA section.
> > + *
> > + * Note:
> > + * Currently R_AARCH64_ABS64, R_AARCH64_LD_PREL_LO19 and R_AARCH64_CALL26
> > + * are the only types to be generated from purgatory code.
> 
> Is this all that has been observed, or is this ensured somehow?

It was observed by inserting a debug print message in this function,
I'm not sure whether we can restrict only those three types.

> The arch_kexec_apply_relocations_add() function below duplicates a lot
> of logic that already exists in the arm64 module loader's
> apply_relocate_add() function.
> 
> Please reuse that code. Having a duplicate or alternative implementation
> is just asking for subtle bugs.

Okey, I'll look at it.

Thanks,
-Takahiro AKASHI


> Thanks,
> Mark.
