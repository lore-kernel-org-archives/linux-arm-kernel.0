From: jeffy.chen@rock-chips.com (jeffy)
Date: Mon, 23 Oct 2017 18:24:12 +0800
Subject: [PATCH] ARM: Fix zImage file size not aligned with CONFIG_EFI_STUB
 enabled
In-Reply-To: <20171023085006.GM20805@n2100.armlinux.org.uk>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
 <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
 <20171022124757.GL20805@n2100.armlinux.org.uk>
 <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
 <59ED6179.5020301@rock-chips.com>
 <20171023085006.GM20805@n2100.armlinux.org.uk>
Message-ID: <59EDC34C.40109@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for your reply.

On 10/23/2017 04:50 PM, Russell King - ARM Linux wrote:
>> >
>> >hmm, right, didn't notice the data is already aligned...
>> >so it's indeed caused by the ksym:
>> >
>> >   [ 9] .data             PROGBITS        006ce000 6d6000 000200 00  WA  0
>> >0 4096
>> >   [10] ___ksymtab+sort   PROGBITS        006ce200 6d6200 000008 00  WA  0
>> >0  4
>> >   [11] .bss              NOBITS          006ce208 6d6208 00001c 00  WA  0
>> >0  4
> It's earlier - look for __ksymtab_strings.

the problem i meet is the appended dtb code found dtb invalid. i thought 
that is because of unaligned zImage size, but i was wrong...


it looks like the size is still aligned, and after add more logs, it 
seems the problem is due to _edata not matched the real file size, which 
is because of the unexpected ___ksymtab+sort:

currently:
zImage size is 6d6208:
-rwxr-xr-x 1 root root 7135752 Oct 23 18:12 zImage

_edata is 006ce200:
  006ce200     0 NOTYPE  GLOBAL DEFAULT    9 _edata

vmlinux sections:
Section Headers:
   [Nr] Name              Type            Addr     Off    Size   ES Flg 
Lk Inf Al
   [ 0]                   NULL            00000000 000000 000000 00 
  0   0  0
   [ 1] .text             PROGBITS        00000000 008000 00b7a0 00  AX 
  0   0 4096
   [ 2] .table            PROGBITS        0000b7a0 0137a0 000014 00  WA 
  0   0  4
   [ 3] .rodata           PROGBITS        0000b7b4 0137b4 0015ef 00   A 
  0   0  2
   [ 4] __ksymtab_strings PROGBITS        0000cda3 014da3 000005 00   A 
  0   0  1
   [ 5] .piggydata        PROGBITS        0000cda8 014da8 6c026f 00   A 
  0   0  1
   [ 6] .got.plt          PROGBITS        006cd018 6d5018 00000c 04  WA 
  0   0  4
   [ 7] .got              PROGBITS        006cd024 6d5024 000028 00  WA 
  0   0  4
   [ 8] .pad              PROGBITS        006cd04c 6d504c 000004 00  WA 
  0   0  1
   [ 9] .data             PROGBITS        006ce000 6d6000 000200 00  WA 
  0   0 4096
   [10] ___ksymtab+sort   PROGBITS        006ce200 6d6200 000008 00  WA 
  0   0  4
   [11] .bss              NOBITS          006ce208 6d6208 00001c 00  WA 
  0   0  4





and it turns out moving around .pad section only hide the problem by 
placing the .pad after the ___ksymtab+sort:

Section Headers:
   [Nr] Name              Type            Addr     Off    Size   ES Flg 
Lk Inf Al
   [ 0]                   NULL            00000000 000000 000000 00 
  0   0  0
   [ 1] .text             PROGBITS        00000000 008000 00b7a0 00  AX 
  0   0 4096
   [ 2] .table            PROGBITS        0000b7a0 0137a0 000014 00  WA 
  0   0  4
   [ 3] .rodata           PROGBITS        0000b7b4 0137b4 0015ef 00   A 
  0   0  2
   [ 4] __ksymtab_strings PROGBITS        0000cda3 014da3 000005 00   A 
  0   0  1
   [ 5] .piggydata        PROGBITS        0000cda8 014da8 6c026f 00   A 
  0   0  1
   [ 6] .got.plt          PROGBITS        006cd018 6d5018 00000c 04  WA 
  0   0  4
   [ 7] .got              PROGBITS        006cd024 6d5024 000028 00  WA 
  0   0  4
   [ 8] .data             PROGBITS        006ce000 6d6000 000200 00  WA 
  0   0 4096
   [ 9] ___ksymtab+sort   PROGBITS        006ce200 6d6200 000008 00  WA 
  0   0  4
   [10] .pad              PROGBITS        006ce208 6d6208 000008 00  WA 
  0   0  1
   [11] .bss              NOBITS          006ce210 6d6210 00001c 00  WA 
  0   0  4

-rwxr-xr-x 1 root root 7135760 Oct 23 18:09 zImage

  006ce210     0 NOTYPE  GLOBAL DEFAULT   10 _edata




and i think Ard's new patch could be the right way to fix it :)
