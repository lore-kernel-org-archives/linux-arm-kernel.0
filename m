From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 17 Aug 2010 22:34:15 -0600
Subject: [PATCH 1/5] ARM: add PrimeCell generic DMA to PL022 v9
In-Reply-To: <20100817044834.GA27060@angua.secretlab.ca>
References: <1281095419-15600-1-git-send-email-linus.walleij@stericsson.com>
	<20100817044834.GA27060@angua.secretlab.ca>
Message-ID: <AANLkTi=vCb8rQu3KPcCv7cP94ovQ_ZFrs7aBjGYtPQmy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 10:48 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, Aug 06, 2010 at 01:50:19PM +0200, Linus Walleij wrote:
>> This extends the PL022 SSP/SPI driver with generic DMA engine
>> support using the PrimeCell DMA engine interface. Also fix up the
>> test code for the U300 platform.
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>
> Applied to my next-spi branch. ?Thanks

Hi Linus,

This patch causes the following build error and warnings.  The
warnings are simple init annotation mismatches.  I haven't dug into
the error, but I suspect the driver needs to depend on or select
another config symbol.  I'm dropping it from my tree.

g.


  LD      drivers/spi/built-in.o
WARNING: drivers/spi/built-in.o(.devinit.text+0x1a8): Section mismatch
in reference from the function pl022_probe() to the function
.init.text:pl022_dma_probe()
The function __devinit pl022_probe() references
a function __init pl022_dma_probe().
If pl022_dma_probe is only used by pl022_probe then
annotate pl022_dma_probe with a matching annotation.

  LD      drivers/built-in.o
WARNING: drivers/built-in.o(.devinit.text+0x1a8): Section mismatch in
reference from the function pl022_probe() to the function
.init.text:pl022_dma_probe()
The function __devinit pl022_probe() references
a function __init pl022_dma_probe().
If pl022_dma_probe is only used by pl022_probe then
annotate pl022_dma_probe with a matching annotation.

  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.devinit.text+0x1a8): Section mismatch in reference
from the function pl022_probe() to the function
.init.text:pl022_dma_probe()
The function __devinit pl022_probe() references
a function __init pl022_dma_probe().
If pl022_dma_probe is only used by pl022_probe then
annotate pl022_dma_probe with a matching annotation.

  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `pl022_dma_remove':
hid-input.c:(.text+0x43434): undefined reference to `dma_release_channel'
hid-input.c:(.text+0x43444): undefined reference to `dma_release_channel'
drivers/built-in.o: In function `pl022_dma_probe':
hid-input.c:(.init.text+0x244c): undefined reference to `__dma_request_channel'
hid-input.c:(.init.text+0x2480): undefined reference to `__dma_request_channel'
hid-input.c:(.init.text+0x24cc): undefined reference to `dma_release_channel'
hid-input.c:(.init.text+0x2514): undefined reference to `dma_release_channel'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2
