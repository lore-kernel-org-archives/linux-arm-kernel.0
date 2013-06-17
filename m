From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 21:38:10 +0200
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <CACRpkdbS3YvwSjpMQbJvSNty=sBrx20vUHKYG44OaWowcN6b0g@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdbS3YvwSjpMQbJvSNty=sBrx20vUHKYG44OaWowcN6b0g@mail.gmail.com>
Message-ID: <7386771.s52fBU89jU@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 16:06:25 Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > One of the biggest roadblocks on the way of S3C64xx to DeviceTree
> > support is its DMA driver, which is completely platform-specific and
> > provides private API (s3c-dma), not even saying that its design is
> > completely against multiplatform-awareness.
> > 
> > The DMA controller present on this SoC series is a custom variant
> > of ARM PrimeCell PL080 modified by Samsung to add some extra features.
> > 
> > It is mostly compatible with original PL080, except:
> >  - CH_CONTROL2 register is added between CH_CONTROL and CH_CONFIG,
> >  - offset of CH_CONFIG register is different,
> >  - transfer size field is moved from CH_CONTROL to CH_CONTROL2,
> >  - transfer size field is extended to 24 bits, allowing much bigger
> >  
> >      single transfer,
> >  
> >  - LLI consists of one more word, to account for CH_CONTROL2 register.
> > 
> > Since all the rest is fully compatible with standard PL080 there is no
> > point in having separate driver just for this single variant, so I
> > decided to look into adding support for it to the amba-pl08x driver.
> > 
> > There was already some attempt to achieve this before, but this was
> > before Russel's big rework of the driver to use virtual channels,
> > making the old patches being not much of use.
> > 
> > This RFC series is a proof of concept that I managed to make during
> > last days of hacking. Except one patch adding clkdev lookup to clock
> > driver (which is being replaced with a CCF-compliant driver ATM),
> > this is enough to get memcpy and slave transfers to work on S3C64xx.
> > 
> > I have tested this on Mini6410 and SMDK6410 boards using dmatest for
> > memcpy and Samsung I2S with madplay/aplay for slave transfers.
> > Unfortunately I do not have access to other platforms with PL08x so
> > I could not test for any regressions introduced on them.
> > 
> > Credits for two patches go to Alban Bedel, who made a series fixing
> > this driver to make it usable with audio drivers. I rebased his
> > patches on top of mine and corrected coding style a bit.
> > 
> > OK, that's all. Any comments are welcome. Feel free to start throwing
> > eggs and tomatoes if you find this awful, but I won't be upset if I
> > get some Tested-by or Acked-by as well. ;)
> 
> I've waited for a long time for this to happen, thank you very much for
> doing this.

You're welcome. Thanks for your review.

Best regards,
Tomasz
