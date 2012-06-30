From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 30 Jun 2012 17:22:51 +0300
Subject: [PATCH v10] MTD: LPC32xx MLC NAND driver
In-Reply-To: <4FEEF1D0.5060404@antcom.de>
References: <1340834129-15545-1-git-send-email-stigge@antcom.de>
 <1340973434.3070.168.camel@sauron.fi.intel.com>
 <4FEEF1D0.5060404@antcom.de>
Message-ID: <1341066171.2115.10.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-06-30 at 14:32 +0200, Roland Stigge wrote:
> Hi Artem!
> 
> Thanks for the notes!
> 
> On 29/06/12 14:37, Artem Bityutskiy wrote:
> > Successfully built configuration
> > "arm-lpc32xx_defconfig,arm,arm-unknown-linux-gnueabi-", results:
> > 
> > --- before_patching.log +++ after_patching.log @@ @@ 
> > +drivers/mtd/nand/lpc32xx_mlc.c: In function 'lpc32xx_nand_probe': 
> > +drivers/mtd/nand/lpc32xx_mlc.c:679:10: warning: variable 'sr' set
> > but not used [-Wunused-but-set-variable] 
> > +drivers/mtd/nand/lpc32xx_mlc.c:561:24: error: bad constant
> > expression [sparse]
> 
> This is because sparse doesn't understand this local variable:
> 
> uint8_t buf[mtd->writesize];

mtd->writesize is typically 2048KiB (or even larger, there are MLCs with
4 and 8 KiB NAND page size). You cannot allocate that much on the stack,
linux kernel stack size is very small - only 8KiB, and there are people
who use even 4KiB stacks. So this have to be fixed.

> The above construction is quite convenient for this case and I'd
> prefer this to allocating another buffer dynamically.

Yes, in userspaces it is, but unfortunately in the kernel we cannot
afford allocating that much on the stack.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120630/af484b3c/attachment.sig>
