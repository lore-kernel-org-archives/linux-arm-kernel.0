From: achandran@mvista.com (Arun Chandran)
Date: Thu, 25 Jun 2015 15:38:10 +0530
Subject: BUG: Bad page state in process swapper pfn:XXXXX
In-Reply-To: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
References: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
Message-ID: <CAFdej029n2DHQRZmFp78hNUgA=rWGYK0fXG1+AxQEZrUGf3WdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 8:04 PM, Arun Chandran <achandran@mvista.com> wrote:
> Hi,
>
> I am booting the latest linus tree on altera cyclone5 soc development kit.
> (https://www.altera.com/products/boards_and_kits/dev-kits/altera/kit-cyclone-v-soc.html)
> With the dtb file arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb.
>
> I get these BUGS (page dumped because: non-NULL mapping) randomly; occurs
> around 1 in 5 times during cold boots.
>
> The entire bootlog with 'memblock=debug' is below.
>

Hi,

I printed the physical address of the "struct page" where
the error is happening and got[collected across multiple tests]

[    0.000000] BUG: Bad page state in process swapper  pfn:1a171
page_phys =1ff3ae20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5b9
page_phys =1ff43720
[    0.000000] BUG: Bad page state in process swapper  pfn:1a172
page_phys =1ff3ae40
[    0.000000] BUG: Bad page state in process swapper  pfn:1a639
page_phys =1ff44720
[    0.000000] BUG: Bad page state in process swapper  pfn:1a63a
page_phys =1ff44740
[    0.000000] BUG: Bad page state in process swapper  pfn:1a63b
page_phys =1ff44760
[    0.000000] BUG: Bad page state in process swapper  pfn:1a579
page_phys =1ff42f20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5f9
page_phys =1ff43f20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a579
page_phys =1ff42f20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a57a
page_phys =1ff42f40
[    0.000000] BUG: Bad page state in process swapper  pfn:1a172
page_phys =1ff3ae40
[    0.000000] BUG: Bad page state in process swapper  pfn:1a639
page_phys =1ff44720
[    0.000000] BUG: Bad page state in process swapper  pfn:1a63a
page_phys =1ff44740
[    0.000000] BUG: Bad page state in process swapper  pfn:1a63b
page_phys =1ff44760
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5f9
page_phys =1ff43f20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5fa
page_phys =1ff43f40
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5f9
page_phys =1ff43f20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5f9
page_phys =1ff43f20
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5fa
page_phys =1ff43f40
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5fb
page_phys =1ff43f60
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5fc
page_phys =1ff43f80
[    0.000000] BUG: Bad page state in process swapper  pfn:1a5fd
page_phys =1ff43fa0
[    0.000000] BUG: Bad page state in process swapper  pfn:1a172
page_phys =1ff3ae40
[    0.000000] BUG: Bad page state in process swapper  pfn:1a639
page_phys =1ff44720
[    0.000000] BUG: Bad page state in process swapper  pfn:1a63a
page_phys =1ff44740
[    0.000000] BUG: Bad page state in process swapper  pfn:1a63b
page_phys =1ff44760


A u-boot memtest for those areas resulted in errors[1 in 5 boots]

SOCFPGA_ARRIA5 #  mtest 0x1ff3a000 0x1ff4ffff
Pattern 00000002  Writing...  Reading...
Mem error @ 0x1FF4A714: found FFFFFFFF, expected 000041C7

Mem error @ 0x1FF4A718: found 1C00FFFF, expected 000041C8

Mem error @ 0x1FF4A71C: found 143DCB25, expected 000041C9

Mem error @ 0x1FF4A720: found 01000608, expected 000041CA

Mem error @ 0x1FF4A724: found 04060008, expected 000041CB

Mem error @ 0x1FF4A728: found 1C000100, expected 000041CC

Mem error @ 0x1FF4A72C: found 143DCB25, expected 000041CD

Mem error @ 0x1FF4A730: found 1967A20A, expected 000041CE

Mem error @ 0x1FF4A734: found 00000000, expected 000041CF

Mem error @ 0x1FF4A738: found A20A0000, expected 000041D0

Mem error @ 0x1FF4A73C: found 00001667, expected 000041D1

Mem error @ 0x1FF4A740: found 00000000, expected 000041D2

Mem error @ 0x1FF4A744: found 00000000, expected 000041D3

Mem error @ 0x1FF4A748: found 00000000, expected 000041D4

Mem error @ 0x1FF4A74C: found 00000000, expected 000041D5

Mem error @ 0x1FF4A750: found E3D2A784, expected 000041D6
Pattern 0000000A  Writing...  Reading...
Mem error @ 0x1FF3AE14: found 005A0320, expected 0000038F
Pattern FFFFFFF4  Writing...  Reading...
Mem error @ 0x1FF3AE14: found 00400320, expected FFFFFC6F
Pattern FFFFFFEF  Writing...  Reading...


That means there is problem with my RAM [or board reset].

Sorry for the noise.

--Arun
