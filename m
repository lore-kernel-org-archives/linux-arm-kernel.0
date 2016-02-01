From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 20:22:43 +0100
Subject: [PATCH] ARM: vmlinux.lds: assert that ROM and RAM don't overlap
 when XIP_KERNEL=y
In-Reply-To: <1454346154-12931-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454346154-12931-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <10106138.pyoAFMVxSu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 February 2016 18:02:34 Ard Biesheuvel wrote:
> When building an XIP kernel, the linker produces two disjoint VMA regions,
> where the first is mapped onto ROM and the second onto RAM. For this reason,
> the linker output pointer '.' is updated halfway through the linker script,
> and set to a value that corresponds with the start of the RAM region.
> 
> However, in some cases, the ROM region exceeds the expected size, and the
> assignment of the output pointer results in a decrement rather than an
> increment, causing the virtual addresses of the .data region to clash with
> the .text region. Such a kernel cannot boot normally, but it also confuses
> the hell out of kallsyms, since .data symbols may appear inside the
> [_stext, _etext] or [_sinittext, _einittext] intervals in the first pass,
> but not in the second (or vice versa), resulting in inconsistent kallsyms
> data.
> 
> So let's make sure that the output pointer only advances, and never jumps
> back into the ROM region.
> 
> Cc: arnd at arndb.de
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I've tested this in multiple configurations, and it reliably prints
a useful error message in broken configurations, while it has no
effect on working configurations. This is more helpful than the
mysterious

   Inconsistent kallsyms data
   Try make KALLSYMS_EXTRA_PASS=1 as a workaround

message that we get without the patch.

	Arnd
