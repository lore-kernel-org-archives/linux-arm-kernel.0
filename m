From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Nov 2015 07:36:02 +0100
Subject: aarch64-linux-gnu-objdump gives all zeros in init_sequence_f[]
In-Reply-To: <20151112054316.GA5043@dragon>
References: <20151112054316.GA5043@dragon>
Message-ID: <CAKv+Gu8KyP8YQzhiJu6ThnMJCUc2U9mUhJk6mdxL3PGcV59Bcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 06:43, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi,
>
> I need some help to understand aarch64-linux-gnu-objdump output in .data
> section as below.  It's part of the dump of u-boot image with command
> 'aarch64-linux-gnu-objdump -D -z u-boot'.
>
> Disassembly of section .data:
>
> 0000000035039898 <reserved_list>:
>         <snip>
>
> 0000000035039948 <init_sequence_f>:
>     35039948:   00000000        .word   0x00000000
[...]
>     35039a48:   00000000        .word   0x00000000
>     35039a4c:   00000000        .word   0x00000000
>
> The init_sequence_f[] is an array defined in U-Boot v2015.04 source
> common/board_f.c, which holds a bunch of pointers to critical
> initialization functions that have to be called during boot.  Obviously,
> the array cannot be all zeros like what objdump tells.  And I confirmed
> that by printing the pointers at run-time as below.
>
[..]
>
> Here are my questions:
>
> - Is this only because that ARM 64-bit toolchain doesn't show the real
>   value of the pointers, or there are some linking or run-time magics to
>   get these pointers correct when the binary is actually running?
>

AArch64 uses the ELF RELA relocation format, where the target location
of the relocation is not used to hold the addend. In contrast, ARM
uses the REL format, where the addend is stored in the same place
where the result of the relocation computation needs to be stored.

Since U-Boot is a PIE executable, it makes heavy use of
R_ARM_RELATIVE/R_AARCH64_RELATIVE relocations, which are not symbol
based, but simply point to places in the binary such as your init
array) where the offset between the link time and load time addresses
needs to be taken into account. For this type of relocation (and since
the u-boot link time base address is 0x0), the addends happen to
coincide with the actual addresses of the functions. These relocations
are applied at runtime by u-boot itself, since it moves itself to the
top of DRAM right after boot.

In the AArch64 case, these addends are stored in the relocation
entries themselves. If you dump the relocations form the u-boot binary
using readelf, you will probably find the values you are looking for.

> - Is this different behavior between ARM 32-bit and 64-bit toolchain
>   expected?  Or did I miss anything on 64-bit toolchain usage?
>

This is expected, although a bit unfortunate, since you may need a
post-build step to apply the relocations in case you need them applied
in the static image (i.e., a ROM image).

-- 
Ard.


> Any hints or comments are much appreciated.
>
> Thanks,
> Shawn
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-dev
