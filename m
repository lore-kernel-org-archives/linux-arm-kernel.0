From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Sep 2015 13:49:12 +0200
Subject: [PATCH v4] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
In-Reply-To: <20150914114113.4aa7ea03@bbrezillon>
References: <1442220063-7520-1-git-send-email-boris.brezillon@free-electrons.com>
 <1472478.qiY0UY0ao8@wuerfel> <20150914114113.4aa7ea03@bbrezillon>
Message-ID: <3809181.WuS0af6Yyz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 September 2015 11:41:13 Boris Brezillon wrote:
> Hi Arnd,
> 
> On Mon, 14 Sep 2015 10:59:02 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Monday 14 September 2015 10:41:03 Boris Brezillon wrote:
> > >                 /* Fill OOB data in */
> > > -               if (oob_required) {
> > > -                       tmp = 0xffffffff;
> > > -                       memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE, &tmp,
> > > -                                   4);
> > > -               } else {
> > > -                       memcpy_toio(nfc->regs + NFC_REG_USER_DATA_BASE,
> > > -                                   chip->oob_poi + offset - mtd->writesize,
> > > -                                   4);
> > > -               }
> > > +               writel(NFC_BUF_TO_USER_DATA(chip->oob_poi +
> > > +                                           layout->oobfree[i].offset),
> > > +                      nfc->regs + NFC_REG_USER_DATA_BASE);
> > 
> > This looks like you are changing the endianess of the data that gets written.
> > Is that intentional?
> 
> Hm, the real goal of this patch was to avoid accessing the
> NFC_REG_USER_DATA_BASE register using byte accessors (writeb()).
> The first version of this series was directly copying data from the
> buffer into a temporary u32 variable, thus forcing the data to be stored
> in little endian (tell me if I'm wrong), and then changing endianness
> using le32_to_cpu().
> Brian suggested to use __raw_writel() (as you seem to suggest too), but
> I was worried about the missing mem barrier in this function.
> That's why I made my own macro doing the little endian to CPU conversion
> manually, but still using the standard writel() accessor (which will
> do the conversion in reverse order).

D'oh, I totally missed your open-coded le32_to_cpu macro.
So your code does look correct to me, it's just a little inefficient
on big-endian machines because you end up swapping twice.

> Maybe I should use __raw_writel() and add an explicit memory barrier.

That would work, and avoid the double swapping, yes. Or you could
use writesl() with a length of one, which should have all the
necessary barriers but no byteswap.

I don't think you need a barrier on ARM here (no DMA that can interfere),
but it's better write the code architecture independent (as you did
above).

The memcpy_toio() is definitely overkill as it has a barrier after every
single byte, where you need at most one for this kind of driver.

> > memcpy_toio() uses the same endianess for source and destination, while writel()
> > assumes that the destination is a little-endian register, and that could break
> > if the kernel is built to run as big-endian. I also see that sunxi_nfc_write_buf()
> > uses memcpy_toio() for writing the actual data, and you are not changing that.
> 
> AFAIU the peripheral is always in little endian, and only the CPU can
> be switched to big endian, right?

Correct.

> Are you saying that memcpy_toio() uses writel? Because according to
> this implementation [2] it uses writeb, which should be safe (accessing
> the internal SRAM using byte accessors is authorized).

No, what I meant is that you are replacing some memcpy_toio() with
writel(), but don't replace some of the others that should/could also
be replaced.

As mentioned, I was under the impression that you changed the endianess
for the OOB data but did not change the endianess for the user data,
which would be inconsistent.

> > If all hardware can do 32-bit accesses here and the size is guaranteed to be a
> > multiple of four bytes, you can probably improve performance by using a
> > __raw_writel() loop there. Using __raw_writel() in general is almost always
> > a bug, but here it actually makes sense. See also the powerpc implementation
> > of _memcpy_toio().
> 
> AFAICT, buffer passed to ->write_bu() are not necessarily aligned on
> 32bits, so using writel here might require copying data in temporary
> buffers :-/.
> 
> Don't hesitate to point where I'm wrong ;-).

Brian or Dwmw2 should be able to know for sure. I think it's definitely
worth trying as the potential performance gains could be huge, if you
replace

	for (p = start; p < start + length; data++, p++) {
		writeb(*data, p);
		wmb();
	}

with

	for (p = start; p < start + length; data++, p+=4) {
		writel(*data, p);
	};
	wmb();

	Arnd
