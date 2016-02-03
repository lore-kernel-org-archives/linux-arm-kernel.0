From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 10:16:46 +0100
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <20160203091331.GB10826@n2100.arm.linux.org.uk>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000351.GX10826@n2100.arm.linux.org.uk>
 <CAKv+Gu_kYWczCazqgRC3y-n7s3WRTDhJXLO1RM1FE-6h1BhSUw@mail.gmail.com>
 <20160203091331.GB10826@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8jbfs6HuzoFTQV2z-0LLiEZ9p0ZHO6eF3itE8p1LMwBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2016 at 10:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 03, 2016 at 08:56:35AM +0100, Ard Biesheuvel wrote:
>> On 3 February 2016 at 01:03, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Feb 02, 2016 at 02:19:32PM +0100, Ard Biesheuvel wrote:
>> >> The sections themselves are emitted 4 KB apart, as required:
>> >>   ...
>> >>   [16] .stubs       PROGBITS   c0c35000 a35000 0002c0 00  AX  0   0 32
>> >>   [17] .vectors     PROGBITS   c0c34000 a44000 000020 00  AX  0   0  2
>> >>   ...
>> >
>> > ... which means we end up wasting most of a page for absolutely no
>> > purpose what so ever.  Sorry, I'm really not happy about this
>> > gratuitous wastage.
>> >
>>
>> No, we don't. Here's some more context:
>>
>> Before:
>>   [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
>>   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
>>   [16] .vectors          PROGBITS        00000000 a40000 000020 00  AX  0   0  2
>>   [17] .stubs            PROGBITS        00001000 a41000 0002c0 00  AX  0   0 32
>>   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
>>
>> After
>>   [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
>>   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
>>   [16] .stubs            PROGBITS        c0c35000 a35000 0002c0 00  AX  0   0 32
>>   [17] .vectors          PROGBITS        c0c34000 a44000 000020 00  AX  0   0  2
>>   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
>
> Meaningless numbers... Do you think you can quote with the header
> please?  I don't tend to carry around the objdump headers in my head.
> Thanks.
>

BEFORE

$ readelf -S vmlinux
There are 34 section headers, starting at offset 0x10a6e60:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .head.text        PROGBITS        c0208000 008000 000268 00  AX  0   0  4
  [ 2] .text             PROGBITS        c0209000 009000 5d6e7c 00  AX
 0   0 4096
  [ 3] .fixup            PROGBITS        c07dfe7c 5dfe7c 000024 00  AX  0   0  4
  [ 4] .rodata           PROGBITS        c07e0000 5e0000 3ca310 00   A  0   0 64
  [ 5] __bug_table       PROGBITS        c0baa310 9aa310 0082c8 00   A  0   0  4
  [ 6] .pci_fixup        PROGBITS        c0bb25d8 9b25d8 001910 00   A  0   0  4
  [ 7] __ksymtab         PROGBITS        c0bb3ee8 9b3ee8 008a70 00   A  0   0  4
  [ 8] __ksymtab_gpl     PROGBITS        c0bbc958 9bc958 007d60 00   A  0   0  4
  [ 9] __ksymtab_strings PROGBITS        c0bc46b8 9c46b8 027c07 00   A  0   0  1
  [10] __param           PROGBITS        c0bec2c0 9ec2c0 0015b8 00   A  0   0  4
  [11] __modver          PROGBITS        c0bed878 9ed878 000788 00   A  0   0  4
  [12] __ex_table        PROGBITS        c0bee000 9ee000 001068 00   A  0   0  8
  [13] .ARM.unwind_idx   ARM_EXIDX       c0bef068 9ef068 03ff30 00  AL 18   0  4
  [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
  [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
  [16] .vectors          PROGBITS        00000000 a40000 000020 00  AX  0   0  2
  [17] .stubs            PROGBITS        00001000 a41000 0002c0 00  AX  0   0 32
  [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
  [19] .exit.text        PROGBITS        c0ca0498 ab0498 002f40 00  AX  0   0  4
  [20] .init.arch.info   PROGBITS        c0ca33d8 ab33d8 0026e8 00   A  0   0  8
  [21] .init.tagtable    PROGBITS        c0ca5ac0 ab5ac0 000048 00   A  0   0  4
  [22] .init.smpalt      PROGBITS        c0ca5b08 ab5b08 00dff8 00   A  0   0  4
  [23] .init.pv_table    PROGBITS        c0cb3b00 ac3b00 000a20 00   A  0   0  1
  [24] .init.data        PROGBITS        c0cb5000 ac5000 06de0c 00  WA
 0   0 4096
  [25] .data..percpu     PROGBITS        c0d23000 b33000 0049c0 00  WA  0   0 64
  [26] .data             PROGBITS        c0d28000 b38000 107d00 00  WA  0   0 64
  [27] .data..page_align PROGBITS        c0e30000 c40000 002000 00  WA
 0   0 4096
  [28] .bss              NOBITS          c0e32000 c42000 056ec8 00  WA  0   0 64
  [29] .comment          PROGBITS        00000000 c42000 00002d 01  MS  0   0  1
  [30] .ARM.attributes   ARM_ATTRIBUTES  00000000 c4202d 000033 00      0   0  1
  [31] .shstrtab         STRTAB          00000000 c42060 000165 00      0   0  1
  [32] .symtab           SYMTAB          00000000 c421c8 28f340 10
33 140990  4
  [33] .strtab           STRTAB          00000000 ed1508 1d5956 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

AFTER

$ readelf -S vmlinux
There are 34 section headers, starting at offset 0x10a6e50:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .head.text        PROGBITS        c0208000 008000 000268 00  AX  0   0  4
  [ 2] .text             PROGBITS        c0209000 009000 5d6e7c 00  AX
 0   0 4096
  [ 3] .fixup            PROGBITS        c07dfe7c 5dfe7c 000024 00  AX  0   0  4
  [ 4] .rodata           PROGBITS        c07e0000 5e0000 3ca310 00   A  0   0 64
  [ 5] __bug_table       PROGBITS        c0baa310 9aa310 0082c8 00   A  0   0  4
  [ 6] .pci_fixup        PROGBITS        c0bb25d8 9b25d8 001910 00   A  0   0  4
  [ 7] __ksymtab         PROGBITS        c0bb3ee8 9b3ee8 008a70 00   A  0   0  4
  [ 8] __ksymtab_gpl     PROGBITS        c0bbc958 9bc958 007d60 00   A  0   0  4
  [ 9] __ksymtab_strings PROGBITS        c0bc46b8 9c46b8 027c07 00   A  0   0  1
  [10] __param           PROGBITS        c0bec2c0 9ec2c0 0015b8 00   A  0   0  4
  [11] __modver          PROGBITS        c0bed878 9ed878 000788 00   A  0   0  4
  [12] __ex_table        PROGBITS        c0bee000 9ee000 001068 00   A  0   0  8
  [13] .ARM.unwind_idx   ARM_EXIDX       c0bef068 9ef068 03ff30 00  AL 18   0  4
  [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
  [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
  [16] .stubs            PROGBITS        c0c35000 a35000 0002c0 00  AX  0   0 32
  [17] .vectors          PROGBITS        c0c34000 a44000 000020 00  AX  0   0  2
  [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
  [19] .exit.text        PROGBITS        c0ca0498 ab0498 002f40 00  AX  0   0  4
  [20] .init.arch.info   PROGBITS        c0ca33d8 ab33d8 0026e8 00   A  0   0  8
  [21] .init.tagtable    PROGBITS        c0ca5ac0 ab5ac0 000048 00   A  0   0  4
  [22] .init.smpalt      PROGBITS        c0ca5b08 ab5b08 00dff8 00   A  0   0  4
  [23] .init.pv_table    PROGBITS        c0cb3b00 ac3b00 000a20 00   A  0   0  1
  [24] .init.data        PROGBITS        c0cb5000 ac5000 06de0c 00  WA
 0   0 4096
  [25] .data..percpu     PROGBITS        c0d23000 b33000 0049c0 00  WA  0   0 64
  [26] .data             PROGBITS        c0d28000 b38000 107d00 00  WA  0   0 64
  [27] .data..page_align PROGBITS        c0e30000 c40000 002000 00  WA
 0   0 4096
  [28] .bss              NOBITS          c0e32000 c42000 056ec8 00  WA  0   0 64
  [29] .comment          PROGBITS        00000000 c42000 00002d 01  MS  0   0  1
  [30] .ARM.attributes   ARM_ATTRIBUTES  00000000 c4202d 000033 00      0   0  1
  [31] .shstrtab         STRTAB          00000000 c42060 000165 00      0   0  1
  [32] .symtab           SYMTAB          00000000 c421c8 28f330 10
33 140988  4
  [33] .strtab           STRTAB          00000000 ed14f8 1d5956 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
