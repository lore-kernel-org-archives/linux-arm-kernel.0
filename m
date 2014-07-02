From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 17:27:26 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <53B430F3.9070804@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <20140701090309.GC28164@arm.com>
 <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
 <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
 <20140702144050.GD24879@arm.com>
 <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
 <53B430F3.9070804@mentor.com>
Message-ID: <20140702162726.GG24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 05:18:59PM +0100, Nathan Lynch wrote:
> On 07/02/2014 10:54 AM, Andy Lutomirski wrote:
> > Caveat 2: (major) I'm kind of surprised that this, or the current
> > code, works reliably.  You're doing something that I tried briefly for
> > x86_64:
> > 
> >         _end = .;
> >         PROVIDE(end = .);
> > 
> >         . = ALIGN(PAGE_SIZE);
> >         PROVIDE(_vdso_data = .);
> > 
> > This sounds great, except that you're assuming that vdso_end -
> > vdso_start == ALIGN(_end, PAGE_SIZE) - (vdso base address).
> > 
> > If you *fully* strip the vdso (eu-strip --strip-sections), then this
> > is true: eu-strip --strip-sections outputs just the PT_LOAD piece of
> > the vdso.  But any binutils-generated incompletely stripped ELF image
> > contains a section table and possible non-allocatable sections at the
> > end.  If these exceed the amount of unused space in the last PT_LOAD
> > page, then they'll spill into the next page, and _vdso_data in the
> > vdso will no longer match the address at which vdso.c loads it.  Boom!
> > 
> > I bet you're getting away with this because the whole arm64 vdso seems
> > to be written in assembly, so it seems extremely unlikely to exceed
> > one page minus a few hundred bytes.  But if you start adding
> > complexity, you might get unlucky.
> 
> This is why I switched (in v5) the proposed 32-bit ARM VDSO to place the
> data page before the code -- adding -frecord-gcc-switches to the
> compiler flags was enough to break it.
> 
> I meant to call Will's attention to it at the time for arm64's sake, but
> I guess it slipped my mind... sorry.

Hmm, so I could definitely look at doing the same thing, but I don't know if
we actually need to for arm64. As Andy points out, we're written entirely in
assembly and we objcopy -S to create the vdso.so. I've dumped the headers
below and everything appears to be PT_LOAD.

Will

--->8

arch/arm64/kernel/vdso/vdso.so:     file format elf64-littleaarch64
arch/arm64/kernel/vdso/vdso.so
architecture: aarch64, flags 0x00000150:
HAS_SYMS, DYNAMIC, D_PAGED
start address 0x00000000000002d0

Program Header:
    LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
         filesz 0x00000000000006e8 memsz 0x00000000000006e8 flags r-x
 DYNAMIC off    0x00000000000005d8 vaddr 0x00000000000005d8 paddr 0x00000000000005d8 align 2**3
         filesz 0x00000000000000f0 memsz 0x00000000000000f0 flags r--
    NOTE off    0x00000000000002b8 vaddr 0x00000000000002b8 paddr 0x00000000000002b8 align 2**2
         filesz 0x0000000000000018 memsz 0x0000000000000018 flags r--
EH_FRAME off    0x00000000000004f0 vaddr 0x00000000000004f0 paddr 0x00000000000004f0 align 2**2
         filesz 0x0000000000000034 memsz 0x0000000000000034 flags r--

Dynamic Section:
  SONAME               linux-vdso.so.1
  HASH                 0x0000000000000120
  STRTAB               0x00000000000001f8
  SYMTAB               0x0000000000000150
  STRSZ                0x0000000000000077
  SYMENT               0x0000000000000018
  VERDEF               0x0000000000000280
  VERDEFNUM            0x0000000000000002
  VERSYM               0x0000000000000270

Version definitions:
1 0x01 0x0deebfa1 linux-vdso.so.1
2 0x00 0x075fcb89 LINUX_2.6.39
private flags = 0:

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .hash         00000030  0000000000000120  0000000000000120  00000120  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .dynsym       000000a8  0000000000000150  0000000000000150  00000150  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .dynstr       00000077  00000000000001f8  00000000000001f8  000001f8  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .gnu.version  0000000e  0000000000000270  0000000000000270  00000270  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .gnu.version_d 00000038  0000000000000280  0000000000000280  00000280  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .note         00000018  00000000000002b8  00000000000002b8  000002b8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_CONTENTS
  6 .text         00000220  00000000000002d0  00000000000002d0  000002d0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  7 .eh_frame_hdr 00000034  00000000000004f0  00000000000004f0  000004f0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 .eh_frame     000000b0  0000000000000528  0000000000000528  00000528  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 .dynamic      000000f0  00000000000005d8  00000000000005d8  000005d8  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 10 .got          00000008  00000000000006c8  00000000000006c8  000006c8  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 11 .got.plt      00000018  00000000000006d0  00000000000006d0  000006d0  2**3
                  CONTENTS, ALLOC, LOAD, DATA
SYMBOL TABLE:
no symbols
