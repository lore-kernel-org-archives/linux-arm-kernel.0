From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Oct 2017 16:05:49 +0100
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <CAKv+Gu95RR3SBb1dydKVVeQQ5+Ui56TcWLfNh=rfmw8_Ty=F7g@mail.gmail.com>
 (Ard Biesheuvel's message of "Mon, 30 Oct 2017 14:55:57 +0000")
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
 <CAKv+Gu95RR3SBb1dydKVVeQQ5+Ui56TcWLfNh=rfmw8_Ty=F7g@mail.gmail.com>
Message-ID: <87a8083cc2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,
 
 On lun., oct. 30 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 30 October 2017 at 13:48, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> Hi Russell,
>>
>>  On ven., oct. 27 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>>
>>> On Fri, Oct 27, 2017 at 05:19:55PM +0200, Gregory CLEMENT wrote:
>>>> Hi Arnd,
>>>>
>>>>  On ven., oct. 20 2017, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>
>>>> > The asm-generic/unaligned.h header provides two different implementations
>>>> > for accessing unaligned variables: the access_ok.h version used when
>>>> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set pretends that all pointers
>>>> > are in fact aligned, while the le_struct.h version convinces gcc that the
>>>> > alignment of a pointer is '1', to make it issue the correct load/store
>>>> > instructions depending on the architecture flags.
>>>> >
>>>> > On ARMv5 and older, we always use the second version, to let the compiler
>>>> > use byte accesses. On ARMv6 and newer, we currently use the access_ok.h
>>>> > version, so the compiler can use any instruction including stm/ldm and
>>>> > ldrd/strd that will cause an alignment trap. This trap can significantly
>>>> > impact performance when we have to do a lot of fixups and, worse, has
>>>> > led to crashes in the LZ4 decompressor code that does not have a trap
>>>> > handler.
>>>> >
>>>> > This adds an ARM specific version of asm/unaligned.h that uses the
>>>> > le_struct.h/be_struct.h implementation unconditionally. This should lead
>>>> > to essentially the same code on ARMv6+ as before, with the exception of
>>>> > using regular load/store instructions instead of the trapping instructions
>>>> > multi-register variants.
>>>> >
>>>> > The crash in the LZ4 decompressor code was probably introduced by the
>>>> > patch replacing the LZ4 implementation, commit 4e1a33b105dd ("lib: update
>>>> > LZ4 compressor module"), so linux-4.11 and higher would be affected most.
>>>> > However, we probably want to have this backported to all older stable
>>>> > kernels as well, to help with the performance issues.
>>>> >
>>>> > There are two follow-ups that I think we should also work on, but not
>>>> > backport to stable kernels, first to change the asm-generic version of
>>>> > the header to remove the ARM special case, and second to review all
>>>> > other uses of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to see if they
>>>> > might be affected by the same problem on ARM.
>>>> >
>>>> > Cc: stable at vger.kernel.org
>>>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> > ---
>>>> > Untested so far, please verify that this fixes all the known problems
>>>> > with the alignment traps.
>>>>
>>>> I think Russell already find this conclusion but this patch didn't solve
>>>> my boot issue with dtb append.
>>>>
>>>> I tested this patch onto a v4.14-rc6.
>>>>
>>>> Then at least with the patch from Ard: "efi/libstub: arm: omit sorting
>>>> of the UEFI memory map", it didn't prevent booting.
>>>
>>> There's three things wrong, all of which I have patches to address:
>>>
>>> 1. The decompressor code reading the image data sometimes issues unaligned
>>>    reads.  Some compilers get this wrong and cause an abort.  Arnds patch
>>>    addresses this.
>>>
>>> 2. Additional sections can appear in the zImage binary which adds extra
>>>    bytes on the end of the image.  Concatenating the zImage with the
>>>    extra bytes onto a DTB is the same thing as doing this:
>>>
>>>       cat zImage extrabytes foo.dtb > image
>>>
>>>    and the decompressor tolerates no additional bytes between the
>>>    _official_ end of the zImage and the DTB.  I've added a patch which
>>>    detects this situation and fails the kernel build when it happens.
>>
>> So I tested the branch fixes in your git tree.
>>
>> After doing a "make multi_v7_defconfig; make zImage", I got the message
>> "arm-linux-gnueabi-ld: error: zImage file size is incorrect" you added
>> in the commit "ARM: verify size of zImage".
>>
>> It is the same with mvebu_v7_defconfig, so I wonder wich with
>> configuration this patch was tested ?
>>
>
> Could you please share the output of 'readelf -S' for those vmlinux
> decompressor images?

Here it is:

In the meantime I also used an arm-linux-gnueabihf- in case it could be
related to the toolchain, I had te same issue and here it is the readelf
output:
arm-linux-gnueabi-readelf -S ../build/vmlinux
There are 40 section headers, starting at offset 0x7cc06bc:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .head.text        PROGBITS        c0008000 008000 00026c 00  AX  0   0  4
  [ 2] .text             PROGBITS        c0100000 010000 6bd280 00  AX  0   0 64
  [ 3] .fixup            PROGBITS        c07bd280 6cd280 00001c 00  AX  0   0  4
  [ 4] .rodata           PROGBITS        c0800000 6d0000 168321 00  WA  0   0 64
  [ 5] .pci_fixup        PROGBITS        c0968324 838324 001e40 00   A  0   0  4
  [ 6] __ksymtab         PROGBITS        c096a164 83a164 007c28 00   A  0   0  4
  [ 7] __ksymtab_gpl     PROGBITS        c0971d8c 841d8c 0081c8 00   A  0   0  4
  [ 8] __ksymtab_strings PROGBITS        c0979f54 849f54 0266e6 00   A  0   0  1
  [ 9] __param           PROGBITS        c09a063c 87063c 00102c 00   A  0   0  4
  [10] __modver          PROGBITS        c09a1668 871668 000998 00   A  0   0  4
  [11] __ex_table        PROGBITS        c09a2000 872000 000ef0 00   A  0   0  8
  [12] .ARM.unwind_idx   ARM_EXIDX       c09a2ef0 872ef0 02f348 00  AL 17   0  4
  [13] .ARM.unwind_tab   PROGBITS        c09d2238 8a2238 001458 00   A  0   0  4
  [14] .notes            NOTE            c09d3690 8a3690 000024 00   A  0   0  4
  [15] .vectors          PROGBITS        ffff0000 8b0000 000020 00  AX  0   0  4
  [16] .stubs            PROGBITS        ffff1000 8b1000 0002ac 00  AX  0   0 32
  [17] .init.text        PROGBITS        c0a002e0 8c02e0 04ee58 00  AX  0   0 32
  [18] .exit.text        PROGBITS        c0a4f138 90f138 0018cc 00  AX  0   0  4
  [19] .init.arch.info   PROGBITS        c0a50a04 910a04 000270 00   A  0   0  4
  [20] .init.tagtable    PROGBITS        c0a50c74 910c74 000040 00   A  0   0  4
  [21] .init.smpalt      PROGBITS        c0a50cb4 910cb4 00d070 00   A  0   0  4
  [22] .init.pv_table    PROGBITS        c0a5dd24 91dd24 0001ec 00   A  0   0  1
  [23] .init.data        PROGBITS        c0a5e000 91e000 011e7c 00  WA  0   0 4096
  [24] .data..percpu     PROGBITS        c0a70000 930000 008f0c 00  WA  0   0 64
  [25] .data             PROGBITS        c0b00000 940000 07f5e8 00  WA  0   0 64
  [26] .bss              NOBITS          c0b7f600 9bf5e8 02be6c 00  WA  0   0 64
  [27] .comment          PROGBITS        00000000 9bf5e8 00001c 01  MS  0   0  1
  [28] .ARM.attributes   ARM_ATTRIBUTES  00000000 9bf604 000031 00      0   0  1
  [29] .debug_line       PROGBITS        00000000 9bf635 706427 00      0   0  1
  [30] .debug_info       PROGBITS        00000000 10c5a5c 5c11e67 00      0   0  1
  [31] .debug_abbrev     PROGBITS        00000000 6cd78c3 2efd55 00      0   0  1
  [32] .debug_aranges    PROGBITS        00000000 6fc7618 011340 00      0   0  8
  [33] .debug_str        PROGBITS        00000000 6fd8958 24bc04 01  MS  0   0  1
  [34] .debug_ranges     PROGBITS        00000000 7224560 1f2bd0 00      0   0  8
  [35] .debug_frame      PROGBITS        00000000 7417130 14fa24 00      0   0  4
  [36] .debug_loc        PROGBITS        00000000 7566b54 4562b5 00      0   0  1
  [37] .symtab           SYMTAB          00000000 79bce0c 1b8f60 10     38 95872  4
  [38] .strtab           STRTAB          00000000 7b75d6c 14a7a2 00      0   0  1
  [39] .shstrtab         STRTAB          00000000 7cc050e 0001ab 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  y (purecode), p (processor specific)


arm-linux-gnueabihf-readelf -S ../build/vmlinux
There are 40 section headers, starting at offset 0x7cc853c:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .head.text        PROGBITS        c0008000 008000 00026c 00  AX  0   0  4
  [ 2] .text             PROGBITS        c0100000 010000 6bd860 00  AX  0   0 64
  [ 3] .fixup            PROGBITS        c07bd860 6cd860 00001c 00  AX  0   0  4
  [ 4] .rodata           PROGBITS        c0800000 6d0000 168361 00  WA  0   0 64
  [ 5] .pci_fixup        PROGBITS        c0968364 838364 001e40 00   A  0   0  4
  [ 6] __ksymtab         PROGBITS        c096a1a4 83a1a4 007c28 00   A  0   0  4
  [ 7] __ksymtab_gpl     PROGBITS        c0971dcc 841dcc 0081c8 00   A  0   0  4
  [ 8] __ksymtab_strings PROGBITS        c0979f94 849f94 0266e6 00   A  0   0  1
  [ 9] __param           PROGBITS        c09a067c 87067c 00102c 00   A  0   0  4
  [10] __modver          PROGBITS        c09a16a8 8716a8 000958 00   A  0   0  4
  [11] __ex_table        PROGBITS        c09a2000 872000 000ef0 00   A  0   0  8
  [12] .ARM.unwind_idx   ARM_EXIDX       c09a2ef0 872ef0 02f368 00  AL 17   0  4
  [13] .ARM.unwind_tab   PROGBITS        c09d2258 8a2258 001458 00   A  0   0  4
  [14] .notes            NOTE            c09d36b0 8a36b0 000024 00   A  0   0  4
  [15] .vectors          PROGBITS        ffff0000 8b0000 000020 00  AX  0   0  4
  [16] .stubs            PROGBITS        ffff1000 8b1000 0002ac 00  AX  0   0 32
  [17] .init.text        PROGBITS        c0a002e0 8c02e0 04ee58 00  AX  0   0 32
  [18] .exit.text        PROGBITS        c0a4f138 90f138 0018cc 00  AX  0   0  4
  [19] .init.arch.info   PROGBITS        c0a50a04 910a04 000270 00   A  0   0  4
  [20] .init.tagtable    PROGBITS        c0a50c74 910c74 000040 00   A  0   0  4
  [21] .init.smpalt      PROGBITS        c0a50cb4 910cb4 00d070 00   A  0   0  4
  [22] .init.pv_table    PROGBITS        c0a5dd24 91dd24 0001ec 00   A  0   0  1
  [23] .init.data        PROGBITS        c0a5e000 91e000 011e7c 00  WA  0   0 4096
  [24] .data..percpu     PROGBITS        c0a70000 930000 008f0c 00  WA  0   0 64
  [25] .data             PROGBITS        c0b00000 940000 07f5e8 00  WA  0   0 64
  [26] .bss              NOBITS          c0b7f600 9bf5e8 02be6c 00  WA  0   0 64
  [27] .comment          PROGBITS        00000000 9bf5e8 00001c 01  MS  0   0  1
  [28] .ARM.attributes   ARM_ATTRIBUTES  00000000 9bf604 000031 00      0   0  1
  [29] .debug_line       PROGBITS        00000000 9bf635 70533b 00      0   0  1
  [30] .debug_info       PROGBITS        00000000 10c4970 5c18a6b 00      0   0  1
  [31] .debug_abbrev     PROGBITS        00000000 6cdd3db 2eff72 00      0   0  1
  [32] .debug_aranges    PROGBITS        00000000 6fcd350 011340 00      0   0  8
  [33] .debug_str        PROGBITS        00000000 6fde690 24bc92 01  MS  0   0  1
  [34] .debug_ranges     PROGBITS        00000000 722a328 1f41c8 00      0   0  8
  [35] .debug_frame      PROGBITS        00000000 741e4f0 14fa78 00      0   0  4
  [36] .debug_loc        PROGBITS        00000000 756df68 456ca3 00      0   0  1
  [37] .symtab           SYMTAB          00000000 79c4c0c 1b8f90 10     38 95875  4
  [38] .strtab           STRTAB          00000000 7b7db9c 14a7f5 00      0   0  1
  [39] .shstrtab         STRTAB          00000000 7cc8391 0001ab 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  y (purecode), p (processor specific)

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
