From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Aug 2017 12:41:20 -0400 (EDT)
Subject: [PATCH v2 0/8] ELF-FDPIC support for ARM
In-Reply-To: <20170817083716.GN20805@n2100.armlinux.org.uk>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
 <20170817083716.GN20805@n2100.armlinux.org.uk>
Message-ID: <alpine.LFD.2.20.1708231158090.14288@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Aug 2017, Russell King - ARM Linux wrote:

> On Thu, Aug 17, 2017 at 03:23:39AM -0400, Nicolas Pitre wrote:
> > This series provides the needed changes to suport the ELF_FDPIC binary
> > format on ARM. Both MMU and non-MMU systems are supported. This format
> > has many advantages over the BFLT format used on MMU-less systems, such
> > as being real ELF that can be parsed by standard tools, can support
> > shared dynamic libs, etc.
> 
> I don't see anything issues from the core arch point of view with this,
> most of it looks straight forward, and the impact on existing users
> should be low.  However, it would be nice to get some acks (if possible)
> for the non-arch stuff and some tested-by's on this.

Well...

I did prod a few people for testing. Either they're on vacation, or not 
interested, but I've received no tested-by's nor ACK's what so ever at 
this point. I did test it myself of course, on both MMU and non-MMU 
targets, and with static and dynamic binaries.

For the non-arch stuff I did post the relevant patches separately to 
viro and cc to lkml a while ago. So far I've been greated with silence 
there as well. Here's what those changes are:

1) binfmt_elf: don't attempt to load FDPIC binaries

This adds a default definition for elf_check_fdpic returning false. 
Therefore on architectures with no ELF-FDPIC support this is a no-op. 
Among those architectures actually defining elf_check_fdpic, only ARM 
(with this series applied) does support standard ELF as well. The FRV 
architecture could possibly do both but it is currently marked BROKEN. 
Maybe this patch could potentially "fix" FRV too? So in practice the 
only place where this has an effect right now is on ARM.

2) binfmt_elf_fdpic: fix crash on MMU system with dynamic binaries

This one should be obvious enough to people actually _using_ it. 
Apparently there aren't that many or this would have been fixed long 
ago. This is turning a direct user space access into one with a proper 
accessor. On no-MMU targets those accessors are transparent so this 
won't change anything to the compiled code.

3) ARM: enable elf_fdpic on systems with an MMU

This adds a block surrounded by #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES 
in fs/binfmt_elf_fdpic.c inside a block already surrounded by #ifdef 
CONFIG_MMU. As indicated in #2, the MMU version of fs/binfmt_elf_fdpic.c 
was already non-functional so this is unlikely to affect anyone. 
Furthermore, none of the architectures that may enable this code (MMU or 
not) have ARCH_HAS_SETUP_ADDITIONAL_PAGES defined, except for ARM.

So I think that the non-arch changes is demonstrably not going to affect 
any existing users.

Therefore at this point I'd suggest you pull the branch so it gets some 
exposure in linux-next to see if this clashes with other people's work 
somehow (I doubt it will). If ever ACKs come by I'll add them and ask 
you to repull before the merge window.

http://git.linaro.org/people/nicolas.pitre/linux fdpic


Nicolas
