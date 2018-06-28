From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 28 Jun 2018 08:40:14 -0400
Subject: [PATCH] arm64: remove no-op -p linker flag
In-Reply-To: <20180628093928.GB10751@arm.com>
References: <20180627194614.188210-1-ghackmann@google.com>
 <20180628093928.GB10751@arm.com>
Message-ID: <CAKwvOdnhPhXc+V2aTzpyCDCeCmFtzPe+-7+YrRrPeWDF1f5s1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 5:38 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Jun 27, 2018 at 12:46:14PM -0700, Greg Hackmann wrote:
> > Linking the ARM64 defconfig kernel with LLVM lld fails with the error:
> >
> >   ld.lld: error: unknown argument: -p
> >   Makefile:1015: recipe for target 'vmlinux' failed
> >
> > Without this flag, the ARM64 defconfig kernel successfully links with
> > lld and boots on Dragonboard 410c.

Ha! Just one single unknown linker flag, to link and boot? That's not too bad.

> > After digging through binutils source and changelogs, it turns out that
> > -p is only relevant to ancient binutils installations targeting 32-bit
> > ARM.  binutils accepts -p for AArch64 too, but it's always been
> > undocumented and silently ignored.

Nothing in the man pages for ld in regards to -p.  Seems like it was
shortform for "--no-pipeline-knowledge: Stop the linker knowing about
the pipeline length".

Looks like it was added to binutils via this commit in 1999:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=7ca69e9e10ef290eb3dd62a1e6bebbe4c87fa202

And removed in 2004:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=dea514f51da1051f9f3cd7a746e3b68085aa1a72

arch/arm/Makefile has -p as a LD_FLAGS.  Is it actually needed there
too, or can it be removed from there?  I assume we'll want to use lld
for arm32 at some point.

> > A comment in
> > ld/emultempl/aarch64elf.em explains that it's "Only here for backwards
> > compatibility".

Yep: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=ld/emultempl/aarch64elf.em;h=edc548f65298e563481bdd9d547fcb9c6b13da04;hb=HEAD#l405

armelf.em also has that comment.

Looks like -p has been in arch/arm64/Makefile since the initial commit
that added that file. So likely copy+pasted from arch/arm/Makefile.

commit 8c2c3df31e3b ("arm64: Build infrastructure"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/Makefile?id=8c2c3df31e3b87cb5348e48776c366ebd1dc5a7a

And it looks like arch/arm/Makefile has has -p since the move to git
for Linux 2.6:

commit 1da177e4c3f4 ("Linux-2.6.12-rc2")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm/Makefile?id=1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

So nothing in the kernel commit history to hint at what it was ever used for.

As long as you have a version of binutils that not 14 years old, you
should be good.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
