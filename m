From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 26 Oct 2016 21:07:59 +1100
Subject: [PATCH v2] modversions: treat symbol CRCs as 32 bit quantities on
 64 bit archs
In-Reply-To: <1476956263-1787-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476956263-1787-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <871sz3xw1s.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I like the concept, but ...

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> The symbol CRCs are emitted as ELF symbols, which allows us to easily
> populate the kcrctab sections by relying on the linker to associate
> each kcrctab slot with the correct value.
>
> This has two downsides:
> - given that the CRCs are treated as pointers, we waste 4 bytes for
>   each CRC on 64 bit architectures,
> - on architectures that support runtime relocation, a relocation entry is
>   emitted for each CRC value, which may take up 24 bytes of __init space
>   (on ELF64 systems)
>
> This comes down to a x8 overhead in [uncompressed] kernel size. In addition,
> each relocation has to be reverted before the CRC value can be used.
>
> Switching to explicit 32 bit values on 64 bit architectures fixes both
> issues, since 32 bit values are not treated as relocatable quantities on
> ELF64 systems, even if the value ultimately resolves to a linker supplied
> value.

Are we sure that part is true? ("not treated as relocatable")

A quick test build on powerpc gives me:

  WARNING: 6829 bad relocations
  c000000000ca3748 R_PPC64_ADDR16    *ABS*+0x0000000013f53da6
  c000000000ca374a R_PPC64_ADDR16    *ABS*+0x00000000f7272059
  c000000000ca374c R_PPC64_ADDR16    *ABS*+0x0000000002013d36
  c000000000ca374e R_PPC64_ADDR16    *ABS*+0x00000000a59dffc8
  ...

Which is coming from our relocs_check.sh script, which checks that the
generated relocations are ones we know how to handle.

And when I try to boot it I get:

  virtio: disagrees about version of symbol module_layout
  virtio: disagrees about version of symbol module_layout
  scsi_mod: disagrees about version of symbol module_layout

And it can't find my root file system (unsurprisingly as it's on scsi).

Will try and investigate more tomorrow.

cheers
