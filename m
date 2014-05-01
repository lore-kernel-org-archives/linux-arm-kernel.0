From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 May 2014 15:36:05 +0200
Subject: [PATCH] arm64: mm: Create gigabyte kernel logical mappings where
 possible
In-Reply-To: <20140501085411.GA31607@linaro.org>
References: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
 <4217068.6LErVYxoHJ@wuerfel> <20140501085411.GA31607@linaro.org>
Message-ID: <4594528.Vh64ixABlG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 May 2014 09:54:12 Steve Capper wrote:
> On Wed, Apr 30, 2014 at 08:11:26PM +0200, Arnd Bergmann wrote:
> > On Wednesday 30 April 2014 12:36:22 Steve Capper wrote:
> > > We have the capability to map 1GB level 1 blocks when using a 4K
> > > granule.
> > > 
> > > This patch adjusts the create_mapping logic s.t. when mapping physical
> > > memory on boot, we attempt to use a 1GB block if both the VA and PA
> > > start and end are 1GB aligned. This both reduces the levels of lookup
> > > required to resolve a kernel logical address, as well as reduces TLB
> > > pressure on cores that support 1GB TLB entries.
> > > 
> > > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > > ---
> > > Hello,
> > > This patch has been tested on the FastModel for 4K and 64K pages.
> > > Also, this has been tested with Jungseok's 4 level patch.
> > > 
> > > I put in the explicit check for PAGE_SHIFT, as I am anticipating a
> > > three level 64KB configuration at some point.
> > > 
> > > With two level 64K, a PUD is equivalent to a PMD which is equivalent to
> > > a PGD, and these are all level 2 descriptors.
> > > 
> > > Under three level 64K, a PUD would be equivalent to a PGD which would
> > > be a level 1 descriptor thus may not be a block.
> > > 
> > > Comments/critique/testers welcome.
> > 
> > It seems like a great idea. I have to admit that I don't understand
> > the existing code, but what are the page sizes used here?
> 
> Actually, I think it was your idea ;-). I remember you talking about
> increasing the mapping size when 4-level page tables were being
> discussed. (I think I should have added a Reported-by, would be happy
> to if you want?).

I completely forgot we had talked about this.

> With a 64KB granule, we'll map 512MB blocks if possible, otherwise 64K.
> And with a 4KB granule, the original code will map 2MB blocks if
> possible, and 4KB otherwise.
> 
> The patch will make the 4KB granule case also map 1GB blocks if
> possible.

Ok.

> > In combination with the contiguous page hint, we should be able
> > to theoretically support 4KB/64KB/2M/32M/1G/16G TLBs in any
> > combination for boot-time mappings on a 4K page size kernel,
> > or 64KB/1M/512M/8G on a 64KB page size kernel.
> 
> A contiguous hint could be applied to these mappings. The logic would
> be a bit more complicated though when we consider different granules.
> For 4KB we chain together 16 entries, for 64KB we use 32. If/when we
> adopt a 16KB granule, we use 32 entries for a level 2 lookup and
> 128 entries for a level 3 lookup...
> 
> The largest TLB entry sizes that I am aware of in play are the block
> sizes (i.e. 2MB, 512MB, 1GB). So I don't think we'll get any benefit at
> the moment for adding the contiguous logic.

Is that an architecture limit, or specific to the Cortex-A53/A57
implementations?

	Arnd
