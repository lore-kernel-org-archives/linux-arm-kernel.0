From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 Aug 2017 17:56:17 +0100
Subject: [PATCH 08/14] arm64: kexec_file: create purgatory
In-Reply-To: <20170824081811.19299-9-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
Message-ID: <20170824165617.GC29665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
> This is a basic purgtory, or a kind of glue code between the two kernel,
> for arm64. We will later add a feature of verifying a digest check against
> loaded memory segments.
> 
> arch_kexec_apply_relocations_add() is responsible for re-linking any
> relative symbols in purgatory. Please note that the purgatory is not
> an executable, but a non-linked archive of binaries so relative symbols
> contained here must be resolved at kexec load time.
> Despite that arm64_kernel_start and arm64_dtb_addr are only such global
> variables now, arch_kexec_apply_relocations_add() can manage more various
> types of relocations.

Why does the purgatory code need to be so complex?

Why is it not possible to write this as position-independent asm?

> +/*
> + * Apply purgatory relocations.
> + *
> + * ehdr: Pointer to elf headers
> + * sechdrs: Pointer to section headers.
> + * relsec: section index of SHT_RELA section.
> + *
> + * Note:
> + * Currently R_AARCH64_ABS64, R_AARCH64_LD_PREL_LO19 and R_AARCH64_CALL26
> + * are the only types to be generated from purgatory code.

Is this all that has been observed, or is this ensured somehow?

The arch_kexec_apply_relocations_add() function below duplicates a lot
of logic that already exists in the arm64 module loader's
apply_relocate_add() function.

Please reuse that code. Having a duplicate or alternative implementation
is just asking for subtle bugs.

Thanks,
Mark.
