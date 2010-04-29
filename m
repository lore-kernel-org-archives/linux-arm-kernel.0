From: mboards@prograde.net (Michael Cashwell)
Date: Thu, 29 Apr 2010 14:59:25 -0400
Subject: Decompression failure in an inexplicable case
In-Reply-To: <1272558886.15152.4.camel@e102109-lin.cambridge.arm.com>
References: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
	<1272558886.15152.4.camel@e102109-lin.cambridge.arm.com>
Message-ID: <355FF471-B747-4E3D-95A9-8D8A60D6CC83@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 29, 2010, at 12:34 PM, Catalin Marinas wrote:

> On Thu, 2010-04-29 at 16:27 +0100, Michael Cashwell wrote:
>> If I omit CPUFreq support [CONFIG_CPU_FREQ is not set], or enable both it and its debugging support [CONFIG_CPU_FREQ_DEBUG=y], the kernel builds and runs seemingly fine.
>> 
>> But if I have CONFIG_CPU_FREQ enabled but NOT its debugging support then kernel builds OK (including full mrproper cleanings in between):
> 
> BTW, one of the suggestions at the time was to try this:
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 3dc2cf8..e12e382 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -316,7 +316,7 @@ LC0:		.word	LC0			@ r1
> 		.word	_start			@ r5
> 		.word	_got_start		@ r6
> 		.word	_got_end		@ ip
> -		.word	user_stack+4096		@ sp
> +		.word	user_stack+8192		@ sp
> LC1:		.word	reloc_end - reloc_start
> 		.size	LC0, . - LC0
> 
> @@ -1086,4 +1086,4 @@ reloc_end:
> 
> 		.align
> 		.section ".stack", "w"
> -user_stack:	.space	4096
> +user_stack:	.space	8192

OK, I tried this (with Uwe's other malloc heap size and decompress_flush() callback patches) and sadly my results were unchanged:

Bytes transferred = 1736932 (1a80e4 hex)
## Booting image at a2000000 ...
   Image Name:   2.6.33.2-gum1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1736868 Bytes =  1.7 MB
   Load Address: a1000000
   Entry Point:  a1000000
   Verifying Checksum ... OK
No initrd

Starting kernel at address a1000000 ...

Uncompressing Linux..............................................................................................................

uncompression error

 -- System halted

So there still seems to be some data-dependent issues in the kernel's gunzip decompressor.

-Mike
