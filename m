From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 May 2016 09:52:01 +0100
Subject: [PATCH] arm64: always use STRICT_MM_TYPECHECKS
In-Reply-To: <1461964074-12544-1-git-send-email-yang.shi@linaro.org>
References: <1461964074-12544-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160503085201.GA10733@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 02:07:54PM -0700, Yang Shi wrote:
> Inspired by the counterpart of powerpc [1], which shows there is no negative
> effect on code generation from enabling STRICT_MM_TYPECHECKS with a modern
> compiler.
> 
> And, Arnd's comment [2] about that patch says STRICT_MM_TYPECHECKS could
> be default as long as the architecture can pass structures in registers as
> function arguments. ARM64 can do it as long as the size of structure <= 16
> bytes. All the page table value types are u64 on ARM64.
> 
> The below disassembly demonstrates it, entry is pte_t type:
> 
>             entry = arch_make_huge_pte(entry, vma, page, writable);
>    0xffff00000826fc38 <+80>:    and     x0, x0, #0xfffffffffffffffd
>    0xffff00000826fc3c <+84>:    mov     w3, w21
>    0xffff00000826fc40 <+88>:    mov     x2, x20
>    0xffff00000826fc44 <+92>:    mov     x1, x19
>    0xffff00000826fc48 <+96>:    orr     x0, x0, #0x400
>    0xffff00000826fc4c <+100>:   bl      0xffff00000809bcc0 <arch_make_huge_pte>
> 
> [1] http://www.spinics.net/lists/linux-mm/msg105951.html
> [2] http://www.spinics.net/lists/linux-mm/msg105969.html
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I'm fine with this change. If Will is still cherry-picking patches for
4.7:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
