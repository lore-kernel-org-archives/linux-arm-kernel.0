From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 13 Nov 2018 13:57:07 +0000
Subject: [PATCH v3] ARM: module: Fix function kallsyms on Thumb-2
In-Reply-To: <20181113112745.15945-1-vincent.whitchurch@axis.com>
References: <20181113112745.15945-1-vincent.whitchurch@axis.com>
Message-ID: <20181113135705.GI3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 12:27:45PM +0100, Vincent Whitchurch wrote:
> Thumb-2 functions have the lowest bit set in the symbol value in the
> symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
> generated from the output of nm, and nm clears the lowest bit.
> 
>  $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
>   95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
>  $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
>  8015dc88 T show_interrupts
>  $ cat /proc/kallsyms | grep show_interrupts
>  8015dc88 T show_interrupts
> 
> However, for modules, the kallsyms uses the values in the symbol table
> without modification, so for functions in modules, the lowest bit is set
> in kallsyms.
> 
>  $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
>     268: 000000e1    44 FUNC    GLOBAL DEFAULT    2 tun_get_socket
>  $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
>  000000e0 T tun_get_socket
>  $ cat /proc/kallsyms | grep tun_get_socket
>  7fcd30e1 t tun_get_socket  [tun]
> 
> Because of this, the offset of the crashing instruction shown in oopses
> is incorrect when the crash is in a module.  For example, given a
> tun_get_socket which starts like this,
> 
>  000000e0 <tun_get_socket>:
>        e0:       b500            push    {lr}
>        e2:       f7ff fffe       bl      0 <__gnu_mcount_nc>
>        e6:       4b08            ldr     r3, [pc, #32]
>        e8:       6942            ldr     r2, [r0, #20]
>        ea:       429a            cmp     r2, r3
>        ec:       d002            beq.n   f4 <tun_get_socket+0x14>
> 
> a crash when tun_get_socket is called with NULL results in:
> 
>  PC is at tun_get_socket+0x7/0x2c [tun]
>  pc : [<7fcdb0e8>]
> 
> which can result in the incorrect line being reported by gdb if this
> symbol+offset is used there.  If the crash is on the first instruction
> of a function, the "PC is at" line would also report the symbol name of
> the preceding function.
> 
> To solve this, introduce a weak module_kallsyms_symbol_value() function
> which arches can override to fix up these symbol values, and implement

(Jumping into this patch without having reviewed previous versions in
detail, so I may have misunderstood some things...)


Anyway:

I prefer this to the previous approach of directly hacking the symbol
values in the module kallsyms table.

> this for Thumb-2.  We need to move elf_type() to st_other so that the
> original value of st_info is preserved.

Are you sure modifying st_other won't break anything?

It's hard to imagine how ELF symbol visibility would be relevant in the
kernel, but some arches put other stuff in st_other.  See alpha,
powerpc, sh for example.  I haven't attempted to understand whether any
of those uses matters here.


Ideally, we wouldn't abuse st_info to store elf_type() in the first
place, but that may be messier to solve.  kallsyms could wrap the
ElfXX_Sym in another struct to store extra metadata for example, but it
would increase runtime memory consumption.

Another option would be wedge STT_FUNC in bit 7 of st_info, say.
Since elf_type() always yields an ASCII char, that bit shouldn't be
used for anything today.  We would of course need to wrap further
access to st_info to mask that bit off as appropriate.

Cheers
---Dave

[...]

> diff --git a/kernel/module.c b/kernel/module.c
> index 49a405891587..5a588cfbb8f8 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>  
>  	/* Set types up while we still have access to sections. */
>  	for (i = 0; i < mod->kallsyms->num_symtab; i++)
> -		mod->kallsyms->symtab[i].st_info
> +		mod->kallsyms->symtab[i].st_other
>  			= elf_type(&mod->kallsyms->symtab[i], info);
>  
>  	/* Now populate the cut down core kallsyms for after init. */
> @@ -3916,6 +3916,11 @@ static const char *symname(struct mod_kallsyms *kallsyms, unsigned int symnum)
>  	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
>  }
>  
> +unsigned long __weak module_kallsyms_symbol_value(Elf_Sym *sym)
> +{
> +	return sym->st_value;
> +}
> +

Can we make this a header inline that the arch can override?

Otherwise, we add a little overhead to every arch in kallsyms core
loops, just to support the arm Thumb-2 kernel case.

[...]

Cheers
---Dave
