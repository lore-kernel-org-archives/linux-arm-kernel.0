From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Dec 2015 10:54:47 +0000
Subject: [PATCH v6 09/20] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <15616150.rsIFodoBKz@wuerfel>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <20151216165819.GD27051@e104818-lin.cambridge.arm.com>
 <20151216171904.GF27051@e104818-lin.cambridge.arm.com>
 <15616150.rsIFodoBKz@wuerfel>
Message-ID: <20151217105445.GA25232@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 08:17:25PM +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 17:19:05 Catalin Marinas wrote:
> > On Wed, Dec 16, 2015 at 04:58:20PM +0000, Catalin Marinas wrote:
> > > On Wed, Dec 16, 2015 at 04:54:34PM +0100, Arnd Bergmann wrote:
> > > > On Wednesday 16 December 2015 00:42:35 Yury Norov wrote:
> > > > > 
> > > > >  #ifdef CONFIG_COMPAT
> > > > > -#define COMPAT_ELF_HWCAP       (compat_elf_hwcap)
> > > > > -#define COMPAT_ELF_HWCAP2      (compat_elf_hwcap2)
> > > > >  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> > > > > +#define COMPAT_ELF_HWCAP       \
> > > > > +       (is_a32_compat_task()   \
> > > > > +         ? compat_elf_hwcap    \
> > > > > +         : elf_hwcap)
> > > > > +
> > > > > +#define COMPAT_ELF_HWCAP2      \
> > > > > +       (is_a32_compat_task()   \
> > > > > +         ? compat_elf_hwcap2   \
> > > > > +         : 0)
> > > > > +
> > > > >  #endif
> > > > 
> > > > I'm trying to understand how this is used. Are you compiling
> > > > fs/compat_binfmt_elf.c twice to handle both 32-bit ELF types?
> > > 
> > > It's the same compat_binfmt_elf.c which handles all 32-bit ELF types,
> > > i.e. AArch32 and A64/ILP32. The above macros are not constants, so they
> > > are evaluated every time a new ELF file is loaded. We do a similar trick
> > > with COMPAT_SET_PERSONALITY in patch 11.
> 
> Ok, I see. I've also looked at other architectures, and found that
> MIPS does it the way I thought it would be
> 
> git grep -w binfmt_elf.c
> arch/mips/kernel/binfmt_elfn32.c:#include "../../../fs/binfmt_elf.c"
> arch/mips/kernel/binfmt_elfo32.c:#include "../../../fs/binfmt_elf.c"
> 
> I still think doing the same for arm64 would result in more maintainable
> code, because it completely separates the two different formats into
> separate files. We'd obviously leave the existing compat handling as
> it is, and just add one more file, not do both of them separately as
> MIPS does.

It will probably simplify some of the code like setting personality,
COMPAT_ELF_HWCAP, elf_check_arch.

> Do you see any downsides of that approach?

Not really. execve may take just a little bit longer to search the right
binfmt but that's lost in the noise anyway, the execve operation itself
is expensive.

AFAICT, the main decision on choosing the ELF binfmt comes from
elf_check_arch() and sizeof(struct elf_phdr). The ILP32 would use the
EM_AARCH64 class but a smaller struct elf_phdr (with 32-bit members). So
there won't be any confusion with the AArch32 (compat) and AArch64
(native) binfmt elf loaders.

> > IIUC, we may have a problem with this. elf_hwcap is 64-bit long while
> > elf_info[n] is 32-bit (Elf32_Addr), so we truncate AT_HWCAP if we ever
> > go beyond bit 31. The above may need to look something like:
> > 
> > #define COMPAT_ELF_HWCAP        \
> >         (is_a32_compat_task()   \
> >          ? compat_elf_hwcap     \
> >          : (u32)elf_hwcap)
> > 
> > #define COMPAT_ELF_HWCAP2       \
> >         (is_a32_compat_task()   \
> >          ? compat_elf_hwcap2    \
> >          : (u32)(elf_hwcap >> 32))
> 
> Yes, interesting find.

BTW, we need to make sure this series (primarily the ABI) is big-endian
safe. I know it is not targeted at this initially but given that the
reason for doing it is legacy networking code, I wouldn't be surprised
if someone asks for BE at some point in the future.

-- 
Catalin
