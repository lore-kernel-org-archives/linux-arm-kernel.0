From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 14:06:50 +0100
Subject: [PATCH v3] arm64: add ARM64-specific support for flatmem
In-Reply-To: <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
References: <20180706174724.44594-1-nkela@cisco.com>
 <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
Message-ID: <20180710130650.GD31318@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jul 10, 2018 at 02:55:41PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 6, 2018 at 7:47 PM, Nikunj Kela <nkela@cisco.com> wrote:
> > Flatmem is useful in reducing kernel memory usage.
> > One usecase is in kdump kernel. We are able to save
> > ~14M by moving to flatmem scheme.
> >
> > Cc: xe-kernel at external.cisco.com
> > Cc: Nikunj Kela <nkela@cisco.com>
> > Signed-off-by: Nikunj Kela <nkela@cisco.com>
> > ---
> >  arch/arm64/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 42c090c..f5b4c49 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -775,6 +775,9 @@ config ARCH_SPARSEMEM_DEFAULT
> >  config ARCH_SELECT_MEMORY_MODEL
> >         def_bool ARCH_SPARSEMEM_ENABLE
> >
> > +config ARCH_FLATMEM_ENABLE
> > +       def_bool y
> > +
> >  config HAVE_ARCH_PFN_VALID
> >         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> >
> 
> I'm getting hundreds of errors in randconfig builds with this:

Damn, I was worried something like this might happen. Sorry!

Does randconfig also fuzz CONFIG_EXPERT? We only added ARCH_FLATMEM_ENABLE
so that people can hand-configure crashkernels to make them small; there will
be plenty of situations where it's just going to cause more problems than it
solves, so I'd be happy hiding it behind EXPERT if it helps.

Otherwise we can probably through a 'def_bool !NUMA' at it.

Will

> + /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld
> -EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic
> --no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T
> ./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a
> --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a
> --end-group
> init/do_mounts.o: In function `mount_block_root':
> do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
> /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
> init/do_mounts.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
> `mem_map' which may bind externally can not be used when making a
> shared object; recompile with -fPIC
> do_mounts.c:(.init.text+0x1e8): dangerous relocation: unsupported relocation
> do_mounts.c:(.init.text+0x1f4): undefined reference to `mem_map'
> arch/arm64/kernel/vdso.o: In function `vdso_init':
> vdso.c:(.init.text+0xb4): undefined reference to `mem_map'
> /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
> arch/arm64/kernel/vdso.o: relocation R_AARCH64_ADR_PREL_PG_HI21
> against symbol `mem_map' which may bind externally can not be used
> when making a shared object; recompile with -fPIC
> vdso.c:(.init.text+0xb4): dangerous relocation: unsupported relocation
> vdso.c:(.init.text+0xbc): undefined reference to `mem_map'
> vdso.c:(.init.text+0xec): undefined reference to `mem_map'
> arch/arm64/kernel/insn.o:insn.c:(.text+0x2ec): more undefined
> references to `mem_map' follow
> /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
> arch/arm64/kernel/insn.o: relocation R_AARCH64_ADR_PREL_PG_HI21
> against symbol `mem_map' which may bind externally can not be used
> when making a shared object; recompile with -fPIC
> 
> The problem seems to be that CONFIG_NUMA is enabled in my
> build, so mem_map[] is not defined anywhere.
> 
>      Arnd
