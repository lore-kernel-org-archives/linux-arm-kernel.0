From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 19 Jun 2013 20:23:19 +0200
Subject: [RFC PATCH 11/11] ARM: s3c64xx: Add support for DMA using generic
 amba-pl08x driver
In-Reply-To: <CACRpkdbQ7+FDJh235vERbCcQcnW1Mzar9r5jgLaXAT5n6CiCFQ@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-12-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdbQ7+FDJh235vERbCcQcnW1Mzar9r5jgLaXAT5n6CiCFQ@mail.gmail.com>
Message-ID: <91444857.CpeBVZzDHZ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 16:04:47 Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > This patch adds all required platform-specific data and initialization
> > code to support the generic amba-pl08x driver on S3C64xx SoCs.
> > 
> > Also some compatibility definitions are added to make the transition
> > from legacy API to DMA engine easier. The biggest hack here is
> > passing const char * pointers through DMA resource, casted to
> > unsigned long, but this is how Samsung DMA wrappers (used to support
> > both s3c-dma and DMA engine in drivers) is designed.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Patch looks like an OK stepping stone.
> 
> > +static AMBA_AHB_DEVICE(s3c64xx_dma0, "dma-pl080s.0", 0x0a141080,
> > +                       0x75000000, {IRQ_DMA0},
> > &s3c64xx_dma0_plat_data);
> (...)
> 
> > +static AMBA_AHB_DEVICE(s3c64xx_dma1, "dma-pl080s.1", 0x0a141080,
> > +                       0x75100000, {IRQ_DMA1},
> > &s3c64xx_dma1_plat_data);
> Ah, does this mean the device does not have any AMBA PrimeCell ID
> contents?

Hmm, not really. The ID here is what I copied from PrimeCell ID registers 
and the method of registration is taken from S5PV210. If I remove the 
override, it will read the same value from registers.

> Then use the ID 0x00053080 instead of 0x0a141080
> 
> 0x53 is "S" for Samsung. Variant 0.

Well, that's kind of solution to make sure that it won't conflict with any 
future variant manufactured by ARM, I guess.

Best regards,
Tomasz
