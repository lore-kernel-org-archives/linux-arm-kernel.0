From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 20:17:25 +0100
Subject: [PATCH v6 09/20] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <20151216171904.GF27051@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <20151216165819.GD27051@e104818-lin.cambridge.arm.com>
 <20151216171904.GF27051@e104818-lin.cambridge.arm.com>
Message-ID: <15616150.rsIFodoBKz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 17:19:05 Catalin Marinas wrote:
> On Wed, Dec 16, 2015 at 04:58:20PM +0000, Catalin Marinas wrote:
> > On Wed, Dec 16, 2015 at 04:54:34PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 16 December 2015 00:42:35 Yury Norov wrote:
> > > > 
> > > >  #ifdef CONFIG_COMPAT
> > > > -#define COMPAT_ELF_HWCAP       (compat_elf_hwcap)
> > > > -#define COMPAT_ELF_HWCAP2      (compat_elf_hwcap2)
> > > >  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> > > > +#define COMPAT_ELF_HWCAP       \
> > > > +       (is_a32_compat_task()   \
> > > > +         ? compat_elf_hwcap    \
> > > > +         : elf_hwcap)
> > > > +
> > > > +#define COMPAT_ELF_HWCAP2      \
> > > > +       (is_a32_compat_task()   \
> > > > +         ? compat_elf_hwcap2   \
> > > > +         : 0)
> > > > +
> > > >  #endif
> > > 
> > > I'm trying to understand how this is used. Are you compiling
> > > fs/compat_binfmt_elf.c twice to handle both 32-bit ELF types?
> > 
> > It's the same compat_binfmt_elf.c which handles all 32-bit ELF types,
> > i.e. AArch32 and A64/ILP32. The above macros are not constants, so they
> > are evaluated every time a new ELF file is loaded. We do a similar trick
> > with COMPAT_SET_PERSONALITY in patch 11.

Ok, I see. I've also looked at other architectures, and found that
MIPS does it the way I thought it would be

git grep -w binfmt_elf.c
arch/mips/kernel/binfmt_elfn32.c:#include "../../../fs/binfmt_elf.c"
arch/mips/kernel/binfmt_elfo32.c:#include "../../../fs/binfmt_elf.c"

I still think doing the same for arm64 would result in more maintainable
code, because it completely separates the two different formats into
separate files. We'd obviously leave the existing compat handling as
it is, and just add one more file, not do both of them separately as
MIPS does.

Do you see any downsides of that approach?

> IIUC, we may have a problem with this. elf_hwcap is 64-bit long while
> elf_info[n] is 32-bit (Elf32_Addr), so we truncate AT_HWCAP if we ever
> go beyond bit 31. The above may need to look something like:
> 
> #define COMPAT_ELF_HWCAP        \
>         (is_a32_compat_task()   \
>          ? compat_elf_hwcap     \
>          : (u32)elf_hwcap)
> 
> #define COMPAT_ELF_HWCAP2       \
>         (is_a32_compat_task()   \
>          ? compat_elf_hwcap2    \
>          : (u32)(elf_hwcap >> 32))

Yes, interesting find.

	Arnd
