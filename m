From: hechtb@googlemail.com (Bastian Hecht)
Date: Fri, 19 Oct 2012 12:05:09 +0200
Subject: [PATCH v2 0/2] Add DMA and device tree support to the flash
 controller FLCTL
In-Reply-To: <1350626232.5769.318.camel@sauron.fi.intel.com>
References: <1349776729-9311-1-git-send-email-hechtb@gmail.com>
 <1350473030.5769.137.camel@sauron.fi.intel.com>
 <CABYn4szACuH3LQ193VJj6E=J4q4Ye4E4O6cUgjB8jmQK6RRmpA@mail.gmail.com>
 <1350626232.5769.318.camel@sauron.fi.intel.com>
Message-ID: <CABYn4swnc5xT=gOCHk5wzQTHWe8TNOE5_o2A36xEgPSnDosSBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Artem,

>> I can reproduce the error with the following output:
>> /tmp/ccYAbker.s: Assembler messages:
>> /tmp/ccYAbker.s: Error: bad immediate value for 8-bit offset (2048)
>> make[3]: *** [drivers/mtd/nand/docg4.o] Error 1
>>
>> The compiler version is: gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
>> I usually use: gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) and
>> can compile things without problems.
>
> Yeah, a bug report would be great. I've switched to 4.4.1 and checked
> your patches with aiaiai:

Ok I'll file one.

I've added a cleanup patch 1/3 and tackled the problems below as follows:

> --------------------------------------------------------------------------------
>
> Successfully built configuration "arm-mackerel_defconfig,arm,arm-none-linux-gnueabi-", results:
>
> --- before_patching.log
> +++ after_patching.log
> @@ @@
> +drivers/mtd/nand/sh_flctl.c:1142 flctl_probe() warn: 'irq' was not released on error [smatch]
> +drivers/mtd/nand/sh_flctl.c:1142:2-8: ERROR: missing iounmap; ioremap on line 1117 and execution via conditional on line 1140 [coccinelle]

Oh yes, my bad. Fixed in patch 3 (formerly 2).

> +drivers/mtd/nand/sh_flctl.c:164:25: warning: cast removes address space of expression [sparse]
> +drivers/mtd/nand/sh_flctl.c:181:25: warning: cast removes address space of expression [sparse]

Here I have no idea how to fix it. dma_addr_t is a typedef to u32. How
could I possibly not loose the address space?

> -drivers/mtd/nand/sh_flctl.c:311 write_fiforeg() Error invalid range 4096 to -1 [smatch]

Here my smatch (git head version) doesn't complain. Still I switched
to unsigned int for indexing an array member and hope this solves the
problem. Done in new patch 1/3.

> -drivers/mtd/nand/sh_flctl.c:317:17: warning: incorrect type in argument 2 (different address spaces) [sparse]
> -drivers/mtd/nand/sh_flctl.c:317:17:    expected void volatile [noderef] <asn:2>*addr [sparse]
> -drivers/mtd/nand/sh_flctl.c:317:17:    got void *fifo_addr [sparse]

Fixed in new patch 1/3.

> +drivers/mtd/nand/sh_flctl.c:469 write_fiforeg() Error invalid range 4096 to -1 [smatch]

Same as above. Unclear how to solve.

> +drivers/mtd/nand/sh_flctl.c:485:17: warning: incorrect type in argument 2 (different address spaces) [sparse]
> +drivers/mtd/nand/sh_flctl.c:485:17:    expected void volatile [noderef] <asn:2>*addr [sparse]
> +drivers/mtd/nand/sh_flctl.c:485:17:    got void *fifo_addr [sparse]

Fixed in patch 1/3.

Thanks for checking, I'll send out the new patch series in a moment,

Bastian
