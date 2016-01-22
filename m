From: wcohen@redhat.com (William Cohen)
Date: Fri, 22 Jan 2016 10:36:12 -0500
Subject: [PATCH] Eliminate the .eh_frame sections from the aarch64 vmlinux
 and kernel modules
In-Reply-To: <20160122150256.GC11645@leverpostej>
References: <1453434986-19307-1-git-send-email-wcohen@redhat.com>
 <CAKv+Gu9j7VGqoOWOZ1T1CVQZfSy9HL9wzvAX83bRiks=6b3dzw@mail.gmail.com>
 <56A2400D.5080707@redhat.com> <20160122150256.GC11645@leverpostej>
Message-ID: <56A24C6C.4010807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2016 10:02 AM, Mark Rutland wrote:
> On Fri, Jan 22, 2016 at 09:43:25AM -0500, William Cohen wrote:
>> On 01/22/2016 02:41 AM, Ard Biesheuvel wrote:
>>> On 22 January 2016 at 04:56, William Cohen <wcohen@redhat.com> wrote:
>>>> By default the aarch64 gcc generates .eh_frame sections.  Unlike
>>>> .debug_frame sections, the .eh_frame sections are loaded into memory
>>>> when the associated code is loaded.  On an example kernel being built
>>>> with this default the .eh_frame section in vmlinux used an extra 1.7MB
>>>> of memory.  The x86 disables the creation of the .eh_frame section.
>>>> The aarch64 should probably do the same to save some memory.
>>>>
>>>
>>> With my GCC-4.9.3 Linaro toolchain, I am not getting .eh_frame
>>> sections only .debug_frame sections. The patch still makes sense imo,
>>> but it appears to be redundant in some cases, and it would be useful
>>> to figure out why. Which toolchain have you tested this with?
>>
>> Hi,
>>
>> I have observed the .eh_frame being generated with gcc-5.3.1 that is in Fedora 23.
> 
> FWIW, I do not see this with the Linaro 15.08 GCC 5.1.1.
> 
> It would be interesting to know if that's something that changed
> upstream between 5.1.x and 5.3.x or if that's a Fedora-specific
> configuration option, but either way the patch seems reasonable.
> 
> Thanks,
> Mark.
> 

Hi Mark,

The sizes of the resulting vmlinux files are pretty similar. However, I could see the change in available memory when I booted the kernels. To see the change without booting you need to use eu-readelf.  The vmlinux.eh_frame is the original build and the vmlinux.no_eh_frame is the build with the -fno-asynchronous-unwind-tables.  The "LOAD" line of "eu-readelf -l" show MemSiz drop.  The "ue-readelf -S" output shows movement of the data moved from the .eh_frame to the .debug_frame section.  Below is the various eu-readelf output.

-Will

[linaro at localhost kernel]$ eu-readelf -l vmlinux.eh_frame 
Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  LOAD           0x010000 0xffffffc000080000 0xffffffc000080000 0xe33800 0x1b2a648 RWE 0x10000
  NOTE           0xd04a00 0xffffffc000d74a00 0xffffffc000d74a00 0x000024 0x000024 R   0x4
  GNU_STACK      0x000000 0x0000000000000000 0x0000000000000000 0x000000 0x000000 RW  0x10

 Section to Segment mapping:
  Segment Sections...
   00      .head.text .text .text.init .rodata .eh_frame .init.rodata.str1.8 .init.eh_frame __bug_table .pci_fixup __ksymtab __ksymtab_gpl __ksymtab_strings __param __modver __ex_table .notes .init.text .exit.text .init.data .data..percpu .altinstructions .altinstr_replacement .data .pecoff_edata_padding .bss
   01      .notes
   02     
[linaro at localhost kernel]$ eu-readelf -l vmlinux.no_eh_frame 
Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  LOAD           0x010000 0xffffffc000080000 0xffffffc000080000 0xc83800 0x197a648 RWE 0x10000
  NOTE           0xb53a00 0xffffffc000bc3a00 0xffffffc000bc3a00 0x000024 0x000024 R   0x4
  GNU_STACK      0x000000 0x0000000000000000 0x0000000000000000 0x000000 0x000000 RW  0x10

 Section to Segment mapping:
  Segment Sections...
   00      .head.text .text .text.init .rodata .init.rodata.str1.8 __bug_table .pci_fixup __ksymtab __ksymtab_gpl __ksymtab_strings __param __modver __ex_table .notes .init.text .exit.text .init.data .data..percpu .altinstructions .altinstr_replacement .data .pecoff_edata_padding .bss
   01      .notes
   02     

[linaro at localhost kernel]$ eu-readelf -S vmlinux.eh_frame 
There are 37 section headers, starting at offset 0x8b07650:

Section Headers:
[Nr] Name                 Type         Addr             Off      Size     ES Flags Lk Inf Al
[ 0]                      NULL         0000000000000000 00000000 00000000  0        0   0  0
[ 1] .head.text           PROGBITS     ffffffc000080000 00010000 00002000  0 AX     0   0 4096
[ 2] .text                PROGBITS     ffffffc000082000 00012000 00807890  0 AX     0   0 4096
[ 3] .text.init           PROGBITS     ffffffc000889890 00819890 00000090  0 AX     0   0 16
[ 4] .rodata              PROGBITS     ffffffc00088a000 0081a000 002d22a0  0 A      0   0 4096
[ 5] .eh_frame            PROGBITS     ffffffc000b5c2a0 00aec2a0 001b0960  0 A      0   0  8
[ 6] .init.rodata.str1.8  PROGBITS     ffffffc000d0cc00 00c9cc00 00000768  1 AMS    0   0  8
[ 7] .init.eh_frame       PROGBITS     ffffffc000d0d368 00c9d368 00000530  0 A      0   0  8
[ 8] __bug_table          PROGBITS     ffffffc000d0d898 00c9d898 000147b4  0 A      0   0  4
[ 9] .pci_fixup           PROGBITS     ffffffc000d22050 00cb2050 00002358  0 A      0   0  8
[10] __ksymtab            PROGBITS     ffffffc000d243a8 00cb43a8 00012360  0 A      0   0  8
[11] __ksymtab_gpl        PROGBITS     ffffffc000d36708 00cc6708 0000f610  0 A      0   0  8
[12] __ksymtab_strings    PROGBITS     ffffffc000d45d18 00cd5d18 00028fa4  0 A      0   0  1
[13] __param              PROGBITS     ffffffc000d6ecc0 00cfecc0 00002580  0 A      0   0  8
[14] __modver             PROGBITS     ffffffc000d71240 00d01240 00000dc0  0 A      0   0  8
[15] __ex_table           PROGBITS     ffffffc000d72000 00d02000 00002a00  0 A      0   0  8
[16] .notes               NOTE         ffffffc000d74a00 00d04a00 00000024  0 A      0   0  4
[17] .init.text           PROGBITS     ffffffc000d75000 00d05000 000394b8  0 AX     0   0 16
[18] .exit.text           PROGBITS     ffffffc000dae4b8 00d3e4b8 00002f20  0 AX     0   0  4
[19] .init.data           PROGBITS     ffffffc000db13e0 00d413e0 00045bd8  0 WA     0   0 32
[20] .data..percpu        PROGBITS     ffffffc000df7000 00d87000 00006cc0  0 WA     0   0 64
[21] .altinstructions     PROGBITS     ffffffc000dfe000 00d8e000 000091c8  0 A      0   0  1
[22] .altinstr_replacement PROGBITS     ffffffc000e071c8 00d971c8 00003098  0 AX     0   0  1
[23] .data                PROGBITS     ffffffc000e0b000 00d9b000 000a8668  0 WA     0   0 4096
[24] .pecoff_edata_padding PROGBITS     ffffffc000eb3668 00e43668 00000198  0 WA     0   0  1
[25] .bss                 NOBITS       ffffffc000eb4000 00e43800 00cf6648  0 WA     0   0 4096
[26] .comment             PROGBITS     0000000000000000 00e43800 0000002c  1 MS     0   0  1
[27] .debug_line          PROGBITS     0000000000000000 00e4382c 00645ee5  0        0   0  1
[28] .debug_info          PROGBITS     0000000000000000 01489711 05f6205d  0        0   0  1
[29] .debug_abbrev        PROGBITS     0000000000000000 073eb76e 00294bdc  0        0   0  1
[30] .debug_aranges       PROGBITS     0000000000000000 07680350 0001dfd0  0        0   0 16
[31] .debug_ranges        PROGBITS     0000000000000000 0769e320 0046a880  0        0   0 16
[32] .debug_str           PROGBITS     0000000000000000 07b08ba0 00223043  1 MS     0   0  1
[33] .debug_loc           PROGBITS     0000000000000000 07d2bbe3 00976164  0        0   0  1
[34] .shstrtab            STRTAB       0000000000000000 086a1d47 00000193  0        0   0  1
[35] .symtab              SYMTAB       0000000000000000 086a1ee0 002f4ba0 24       36 102756  8
[36] .strtab              STRTAB       0000000000000000 08996a80 00170bcc  0        0   0  1


[linaro at localhost kernel]$ eu-readelf -S vmlinux.no_eh_frame 
There are 36 section headers, starting at offset 0x8b3b950:

Section Headers:
[Nr] Name                 Type         Addr             Off      Size     ES Flags Lk Inf Al
[ 0]                      NULL         0000000000000000 00000000 00000000  0        0   0  0
[ 1] .head.text           PROGBITS     ffffffc000080000 00010000 00002000  0 AX     0   0 4096
[ 2] .text                PROGBITS     ffffffc000082000 00012000 00807890  0 AX     0   0 4096
[ 3] .text.init           PROGBITS     ffffffc000889890 00819890 00000090  0 AX     0   0 16
[ 4] .rodata              PROGBITS     ffffffc00088a000 0081a000 002d22a0  0 A      0   0 4096
[ 5] .init.rodata.str1.8  PROGBITS     ffffffc000b5c2a0 00aec2a0 00000768  1 AMS    0   0  8
[ 6] __bug_table          PROGBITS     ffffffc000b5ca08 00aeca08 000147b4  0 A      0   0  4
[ 7] .pci_fixup           PROGBITS     ffffffc000b711c0 00b011c0 00002358  0 A      0   0  8
[ 8] __ksymtab            PROGBITS     ffffffc000b73518 00b03518 00012360  0 A      0   0  8
[ 9] __ksymtab_gpl        PROGBITS     ffffffc000b85878 00b15878 0000f610  0 A      0   0  8
[10] __ksymtab_strings    PROGBITS     ffffffc000b94e88 00b24e88 00028fa4  0 A      0   0  1
[11] __param              PROGBITS     ffffffc000bbde30 00b4de30 00002580  0 A      0   0  8
[12] __modver             PROGBITS     ffffffc000bc03b0 00b503b0 00000c50  0 A      0   0  8
[13] __ex_table           PROGBITS     ffffffc000bc1000 00b51000 00002a00  0 A      0   0  8
[14] .notes               NOTE         ffffffc000bc3a00 00b53a00 00000024  0 A      0   0  4
[15] .init.text           PROGBITS     ffffffc000bc4000 00b54000 00039498  0 AX     0   0 16
[16] .exit.text           PROGBITS     ffffffc000bfd498 00b8d498 00002f20  0 AX     0   0  4
[17] .init.data           PROGBITS     ffffffc000c003c0 00b903c0 00045bd8  0 WA     0   0 32
[18] .data..percpu        PROGBITS     ffffffc000c46000 00bd6000 00006cc0  0 WA     0   0 64
[19] .altinstructions     PROGBITS     ffffffc000c4d000 00bdd000 000091c8  0 A      0   0  1
[20] .altinstr_replacement PROGBITS     ffffffc000c561c8 00be61c8 00003098  0 AX     0   0  1
[21] .data                PROGBITS     ffffffc000c5a000 00bea000 000a9668  0 WA     0   0 4096
[22] .pecoff_edata_padding PROGBITS     ffffffc000d03668 00c93668 00000198  0 WA     0   0  1
[23] .bss                 NOBITS       ffffffc000d04000 00c93800 00cf6648  0 WA     0   0 4096
[24] .comment             PROGBITS     0000000000000000 00c93800 0000002c  1 MS     0   0  1
[25] .debug_line          PROGBITS     0000000000000000 00c9382c 00646080  0        0   0  1
[26] .debug_info          PROGBITS     0000000000000000 012d98ac 05f61fab  0        0   0  1
[27] .debug_abbrev        PROGBITS     0000000000000000 0723b857 00294bd3  0        0   0  1
[28] .debug_aranges       PROGBITS     0000000000000000 074d0430 0001dfd0  0        0   0 16
[29] .debug_ranges        PROGBITS     0000000000000000 074ee400 0046ad10  0        0   0 16
[30] .debug_frame         PROGBITS     0000000000000000 07959110 001e35c8  0        0   0  8
[31] .debug_str           PROGBITS     0000000000000000 07b3c6d8 002230a2  1 MS     0   0  1
[32] .debug_loc           PROGBITS     0000000000000000 07d5f77a 009768ea  0        0   0  1
[33] .shstrtab            STRTAB       0000000000000000 086d6064 00000191  0        0   0  1
[34] .symtab              SYMTAB       0000000000000000 086d61f8 002f4b88 24       35 102755  8
[35] .strtab              STRTAB       0000000000000000 089cad80 00170bcc  0        0   0  1
