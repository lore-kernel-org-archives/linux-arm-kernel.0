From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Sep 2015 10:59:02 +0200
Subject: [PATCH v4] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
In-Reply-To: <1442220063-7520-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442220063-7520-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1472478.qiY0UY0ao8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 September 2015 10:41:03 Boris Brezillon wrote:
>                 /* Fill OOB data in */
> -               if (oob_required) {
> -                       tmp = 0xffffffff;
> -                       memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
> -                                   4);
> -               } else {
> -                       memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE,
> -                                   chip->oob_poi + offset - mtd->writesize,
> -                                   4);
> -               }
> +               writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
> +                                           layout->oobfree[i].offset),
> +                      nfc->regs + NFC_REG_USER_DATA_BASE);

This looks like you are changing the endianess of the data that gets written.
Is that intentional?

memcpy_toio() uses the same endianess for source and destination, while writel()
assumes that the destination is a little-endian register, and that could break
if the kernel is built to run as big-endian. I also see that sunxi_nfc_write_buf()
uses memcpy_toio() for writing the actual data, and you are not changing that.

If all hardware can do 32-bit accesses here and the size is guaranteed to be a
multiple of four bytes, you can probably improve performance by using a
__raw_writel() loop there. Using __raw_writel() in general is almost always
a bug, but here it actually makes sense. See also the powerpc implementation
of _memcpy_toio().

	Arnd
