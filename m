From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 18:24:43 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <CALCETrVSqH66jqG2_O2dir-3md4SHH800qs++4KhWYsGm9T-BQ@mail.gmail.com>
References: <53B1D8AC.7060104@mit.edu> <20140701090309.GC28164@arm.com>
 <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
 <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
 <20140702144050.GD24879@arm.com>
 <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
 <53B430F3.9070804@mentor.com> <20140702162726.GG24879@arm.com>
 <CALCETrVSqH66jqG2_O2dir-3md4SHH800qs++4KhWYsGm9T-BQ@mail.gmail.com>
Message-ID: <20140702172443.GI24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 05:47:08PM +0100, Andy Lutomirski wrote:
> On Wed, Jul 2, 2014 at 9:27 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 02, 2014 at 05:18:59PM +0100, Nathan Lynch wrote:
> >> On 07/02/2014 10:54 AM, Andy Lutomirski wrote:
> >> > Caveat 2: (major) I'm kind of surprised that this, or the current
> >> > code, works reliably.  You're doing something that I tried briefly for
> >> > x86_64:
> >> >
> >> >         _end = .;
> >> >         PROVIDE(end = .);
> >> >
> >> >         . = ALIGN(PAGE_SIZE);
> >> >         PROVIDE(_vdso_data = .);
> >> >
> >> > This sounds great, except that you're assuming that vdso_end -
> >> > vdso_start == ALIGN(_end, PAGE_SIZE) - (vdso base address).
> >> >
> >> > If you *fully* strip the vdso (eu-strip --strip-sections), then this
> >> > is true: eu-strip --strip-sections outputs just the PT_LOAD piece of
> >> > the vdso.  But any binutils-generated incompletely stripped ELF image
> >> > contains a section table and possible non-allocatable sections at the
> >> > end.  If these exceed the amount of unused space in the last PT_LOAD
> >> > page, then they'll spill into the next page, and _vdso_data in the
> >> > vdso will no longer match the address at which vdso.c loads it.  Boom!
> >> >
> >> > I bet you're getting away with this because the whole arm64 vdso seems
> >> > to be written in assembly, so it seems extremely unlikely to exceed
> >> > one page minus a few hundred bytes.  But if you start adding
> >> > complexity, you might get unlucky.
> >>
> >> This is why I switched (in v5) the proposed 32-bit ARM VDSO to place the
> >> data page before the code -- adding -frecord-gcc-switches to the
> >> compiler flags was enough to break it.
> >>
> >> I meant to call Will's attention to it at the time for arm64's sake, but
> >> I guess it slipped my mind... sorry.
> >
> > Hmm, so I could definitely look at doing the same thing, but I don't know if
> > we actually need to for arm64. As Andy points out, we're written entirely in
> > assembly and we objcopy -S to create the vdso.so. I've dumped the headers
> > below and everything appears to be PT_LOAD.
> 
> Your dump doesn't show the location of the section and section string
> tables themselves.  Try:
> 
> eu-readelf -l -h -S whatever.so

Thanks. See below.

Will

--->8

ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           AArch64
  Version:                           0x1
  Entry point address:               0x2d0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          1888 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         4
  Size of section headers:           64 (bytes)
  Number of section headers:         14
  Section header string table index: 13

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .hash             HASH             0000000000000120  00000120
       0000000000000030  0000000000000004   A       2     0     8
  [ 2] .dynsym           DYNSYM           0000000000000150  00000150
       00000000000000a8  0000000000000018   A       3     2     8
  [ 3] .dynstr           STRTAB           00000000000001f8  000001f8
       0000000000000077  0000000000000000   A       0     0     1
  [ 4] .gnu.version      VERSYM           0000000000000270  00000270
       000000000000000e  0000000000000002   A       2     0     2
  [ 5] .gnu.version_d    VERDEF           0000000000000280  00000280
       0000000000000038  0000000000000000   A       3     2     8
  [ 6] .note             NOTE             00000000000002b8  000002b8
       0000000000000018  0000000000000000   A       0     0     4
  [ 7] .text             PROGBITS         00000000000002d0  000002d0
       0000000000000220  0000000000000000  AX       0     0     16
  [ 8] .eh_frame_hdr     PROGBITS         00000000000004f0  000004f0
       0000000000000034  0000000000000000   A       0     0     4
  [ 9] .eh_frame         PROGBITS         0000000000000528  00000528
       00000000000000b0  0000000000000000   A       0     0     8
  [10] .dynamic          DYNAMIC          00000000000005d8  000005d8
       00000000000000f0  0000000000000010  WA       3     0     8
  [11] .got              PROGBITS         00000000000006c8  000006c8
       0000000000000008  0000000000000008  WA       0     0     8
  [12] .got.plt          PROGBITS         00000000000006d0  000006d0
       0000000000000018  0000000000000008  WA       0     0     8
  [13] .shstrtab         STRTAB           0000000000000000  000006e8
       0000000000000078  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x00000000000006e8 0x00000000000006e8  R E    10
  DYNAMIC        0x00000000000005d8 0x00000000000005d8 0x00000000000005d8
                 0x00000000000000f0 0x00000000000000f0  R      8
  NOTE           0x00000000000002b8 0x00000000000002b8 0x00000000000002b8
                 0x0000000000000018 0x0000000000000018  R      4
  GNU_EH_FRAME   0x00000000000004f0 0x00000000000004f0 0x00000000000004f0
                 0x0000000000000034 0x0000000000000034  R      4

 Section to Segment mapping:
  Segment Sections...
   00     .hash .dynsym .dynstr .gnu.version .gnu.version_d .note .text .eh_frame_hdr .eh_frame .dynamic .got .got.plt 
   01     .dynamic 
   02     .note 
   03     .eh_frame_hdr 
