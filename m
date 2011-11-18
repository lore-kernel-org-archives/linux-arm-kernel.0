From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Nov 2011 12:02:03 +0000
Subject: [PATCH 1/4] ARM: idmap: populate identity map pgd at init time
 using .init.text
In-Reply-To: <1321462094-6647-2-git-send-email-will.deacon@arm.com>
References: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
 <1321462094-6647-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk6DCipMmqQMiLqZ8aAQs6LLsC5=2buPARfouNpnezCJog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2011 16:48, Will Deacon <will.deacon@arm.com> wrote:
> When disabling and re-enabling the MMU, it is necessary to take out an
> identity mapping for the code that manipulates the SCTLR in order to
> avoid it disappearing from under our feet. This is useful when soft
> rebooting and returning from CPU suspend.
>
> This patch allocates a set of page tables during boot and populates them
> with an identity mapping for the .idmap.text section. This means that
> users of the identity map do not need to manage their own pgd and can
> instead annotate their functions with __idmap or, in the case of assembly
> code, place them in the correct section.
>
> Tested-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
...
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -425,6 +425,12 @@
> ? ? ? ? ? ? ? ?*(.kprobes.text) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> ? ? ? ? ? ? ? ?VMLINUX_SYMBOL(__kprobes_text_end) = .;
>
> +#define IDMAP_TEXT ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? ALIGN_FUNCTION(); ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? VMLINUX_SYMBOL(__idmap_text_start) = .; ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? *(.idmap.text) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? VMLINUX_SYMBOL(__idmap_text_end) = .;
> +
> ?#define ENTRY_TEXT ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ? ? ? ? ?ALIGN_FUNCTION(); ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ? ? ? ? ?VMLINUX_SYMBOL(__entry_text_start) = .; ? ? ? ? ? ? ? ? \

Since IDMAP is specific to ARM, we should just add the IDMAP_TEXT
macro to vmlinux.lds.S.

-- 
Catalin
