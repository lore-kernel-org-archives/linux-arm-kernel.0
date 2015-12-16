From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Dec 2015 16:58:20 +0000
Subject: [PATCH v6 09/20] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <2049962.OV4jWs7vGi@wuerfel>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-10-git-send-email-ynorov@caviumnetworks.com>
 <2049962.OV4jWs7vGi@wuerfel>
Message-ID: <20151216165819.GD27051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 04:54:34PM +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 00:42:35 Yury Norov wrote:
> > 
> >  #ifdef CONFIG_COMPAT
> > -#define COMPAT_ELF_HWCAP       (compat_elf_hwcap)
> > -#define COMPAT_ELF_HWCAP2      (compat_elf_hwcap2)
> >  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> > +#define COMPAT_ELF_HWCAP       \
> > +       (is_a32_compat_task()   \
> > +         ? compat_elf_hwcap    \
> > +         : elf_hwcap)
> > +
> > +#define COMPAT_ELF_HWCAP2      \
> > +       (is_a32_compat_task()   \
> > +         ? compat_elf_hwcap2   \
> > +         : 0)
> > +
> >  #endif
> 
> I'm trying to understand how this is used. Are you compiling
> fs/compat_binfmt_elf.c twice to handle both 32-bit ELF types?

It's the same compat_binfmt_elf.c which handles all 32-bit ELF types,
i.e. AArch32 and A64/ILP32. The above macros are not constants, so they
are evaluated every time a new ELF file is loaded. We do a similar trick
with COMPAT_SET_PERSONALITY in patch 11.

-- 
Catalin
