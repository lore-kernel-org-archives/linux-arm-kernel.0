From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 2 Sep 2015 11:39:56 +0100
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150902103955.GF6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 08:23:29AM +0200, Robert Jarzmik wrote:
> On old ARM chips, unaligned accesses to memory are not trapped and
> fixed.  On module load, symbols are relocated, and the relocation of
> __bug_table symbols is done on a u32 basis. Yet the section is not
> aligned to a multiple of 4 address, but to a multiple of 2.
> 
> This triggers an Oops on pxa architecture, where address 0xbf0021ea
> is the first relocation in the __bug_table section :
>   apply_relocate(): pxa3xx_nand: section 13 reloc 0 sym ''
>   Unable to handle kernel paging request at virtual address bf0021ea
>   pgd = e1cd0000
>   [bf0021ea] *pgd=c1cce851, *pte=c1cde04f, *ppte=c1cde01f
>   Internal error: Oops: 23 [#1] ARM
>   Modules linked in:
>   CPU: 0 PID: 606 Comm: insmod Not tainted 4.2.0-rc8-next-20150828-cm-x300+ #887
>   Hardware name: CM-X300 module
>   task: e1c68700 ti: e1c3e000 task.ti: e1c3e000
>   PC is at apply_relocate+0x2f4/0x3d4
>   LR is at 0xbf0021ea
>   pc : [<c000e7c8>]    lr : [<bf0021ea>]    psr: 80000013
>   sp : e1c3fe30  ip : 60000013  fp : e49e8c60
>   r10: e49e8fa8  r9 : 00000000  r8 : e49e7c58
>   r7 : e49e8c38  r6 : e49e8a58  r5 : e49e8920  r4 : e49e8918
>   r3 : bf0021ea  r2 : bf007034  r1 : 00000000  r0 : bf000000
>   Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>   Control: 0000397f  Table: c1cd0018  DAC: 00000051
>   Process insmod (pid: 606, stack limit = 0xe1c3e198)
>   [<c000e7c8>] (apply_relocate) from [<c005ce5c>] (load_module+0x1248/0x1f5c)
>   [<c005ce5c>] (load_module) from [<c005dc54>] (SyS_init_module+0xe4/0x170)
>   [<c005dc54>] (SyS_init_module) from [<c000a420>] (ret_fast_syscall+0x0/0x38)
> 
> Fix this by ensuring entries in __bug_table are all aligned to at least
> of multiple of 4. This transforms a module section  __bug_table as :
> -   [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  1
> +   [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  4
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/include/asm/bug.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> index b274bde24905..e7335a92144e 100644
> --- a/arch/arm/include/asm/bug.h
> +++ b/arch/arm/include/asm/bug.h
> @@ -40,6 +40,7 @@ do {								\
>  		"2:\t.asciz " #__file "\n" 			\
>  		".popsection\n" 				\
>  		".pushsection __bug_table,\"a\"\n"		\
> +		".align 2\n"					\
>  		"3:\t.word 1b, 2b\n"				\
>  		"\t.hword " #__line ", 0\n"			\
>  		".popsection");					\

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

I added the .align in my recent patches implementing BUG for arm64,
but didn't touch arch/arm.

When referring to the arm code I did notice that there was no .align.
I'd concluded that the linker script layout and lack of bug reports
meant the arm code was alignment-safe in practice, but I guess I was
mistaken...

Cheers
---Dave
