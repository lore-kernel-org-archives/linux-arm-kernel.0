From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 14 Sep 2015 11:41:13 +0200
Subject: [PATCH v4] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
In-Reply-To: <1472478.qiY0UY0ao8@wuerfel>
References: <1442220063-7520-1-git-send-email-boris.brezillon@free-electrons.com>
 <1472478.qiY0UY0ao8@wuerfel>
Message-ID: <20150914114113.4aa7ea03@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, 14 Sep 2015 10:59:02 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 14 September 2015 10:41:03 Boris Brezillon wrote:
> >                 /* Fill OOB data in */
> > -               if (oob_required) {
> > -                       tmp = 0xffffffff;
> > -                       memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
> > -                                   4);
> > -               } else {
> > -                       memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE,
> > -                                   chip->oob_poi + offset - mtd->writesize,
> > -                                   4);
> > -               }
> > +               writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
> > +                                           layout->oobfree[i].offset),
> > +                      nfc->regs + NFC_REG_USER_DATA_BASE);
> 
> This looks like you are changing the endianess of the data that gets written.
> Is that intentional?

Hm, the real goal of this patch was to avoid accessing the
NFC_REG_USER_DATA_BASE register using byte accessors (writeb()).
The first version of this series was directly copying data from the
buffer into a temporary u32 variable, thus forcing the data to be stored
in little endian (tell me if I'm wrong), and then changing endianness
using le32_to_cpu().
Brian suggested to use __raw_writel() (as you seem to suggest too), but
I was worried about the missing mem barrier in this function.
That's why I made my own macro doing the little endian to CPU conversion
manually, but still using the standard writel() accessor (which will
do the conversion in reverse order).
Maybe I should use __raw_writel() and add an explicit memory barrier.

> 
> memcpy_toio() uses the same endianess for source and destination, while writel()
> assumes that the destination is a little-endian register, and that could break
> if the kernel is built to run as big-endian. I also see that sunxi_nfc_write_buf()
> uses memcpy_toio() for writing the actual data, and you are not changing that.

AFAIU the peripheral is always in little endian, and only the CPU can
be switched to big endian, right?
Are you saying that memcpy_toio() uses writel? Because according to
this implementation [2] it uses writeb, which should be safe (accessing
the internal SRAM using byte accessors is authorized).

> 
> If all hardware can do 32-bit accesses here and the size is guaranteed to be a
> multiple of four bytes, you can probably improve performance by using a
> __raw_writel() loop there. Using __raw_writel() in general is almost always
> a bug, but here it actually makes sense. See also the powerpc implementation
> of _memcpy_toio().

AFAICT, buffer passed to ->write_bu() are not necessarily aligned on
32bits, so using writel here might require copying data in temporary
buffers :-/.

Don't hesitate to point where I'm wrong ;-).

Best Regards,

Boris

[1]https://patchwork.ozlabs.org/patch/502041/
[2]http://lxr.free-electrons.com/source/arch/arm/kernel/io.c#L56


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
