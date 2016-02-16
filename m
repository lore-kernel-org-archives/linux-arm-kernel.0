From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 12:57:30 +0100
Subject: [PATCH 1/3] ARM: zynq: Move early printk virtual address to
 vmalloc area
In-Reply-To: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
Message-ID: <4209295.YSuxZXZMPH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 17:05:17 Michal Simek wrote:
> The patch
> "ARM: 8432/1: move VMALLOC_END from 0xff000000 to 0xff800000"
> (sha1: 6ff0966052c46efb53980b8a1add2e7b49c9f560)
> has moved also start of VMALLOC area because size didn't change.
> That's why origin location of vmalloc was
>    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> and now is
>    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
> 
> That's why uart virtual addresses need to be changed to reflect this new
> memory setup. Starting address should be vmalloc start address.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

All three patches look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I would like to hear back from Nico on this though: is this an expected
outcome of your patch, or is it something you had not considered at
all?

Do we need to audit all platforms for other instances of the same
problem? I see for instance

static struct map_desc jornada720_io_desc[] __initdata = {
        {       /* Epson registers */
                .virtual        = 0xf0000000,
                .pfn            = __phys_to_pfn(EPSONREGSTART),
                .length         = EPSONREGLEN,
                .type           = MT_DEVICE
        }, {    /* Epson frame buffer */

in arch/arm/mach-sa1100/jornada720.c. Could this have the same problem?

I would guess that only machines with 768MB of RAM (or more) can run
into the bug.

	Arnd
