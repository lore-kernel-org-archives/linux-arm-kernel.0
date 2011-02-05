From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Feb 2011 20:36:00 +0000
Subject: [PATCH 0/5] mmc: add double buffering for mmc block requests
In-Reply-To: <20110205170255.GG29411@n2100.arm.linux.org.uk>
References: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
	<20110205170255.GG29411@n2100.arm.linux.org.uk>
Message-ID: <20110205203600.GA31760@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 05:02:55PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 12, 2011 at 07:13:58PM +0100, Per Forlin wrote:
> > Add support to prepare one MMC request while another is active on
> > the host. This is done by making the issue_rw_rq() asynchronous.
> > The increase in throughput is proportional to the time it takes to
> > prepare a request and how fast the memory is. The faster the MMC/SD is
> > the more significant the prepare request time becomes. Measurements on U5500
> > and U8500 on eMMC shows significant performance gain for DMA on MMC for large
> > reads. In the PIO case there is some gain in performance for large reads too.
> > There seems to be no or small performance gain for write, don't have a good
> > explanation for this yet.
> 
> It might be worth seeing what effect the following patch has.  This
> moves the dsb out of the cache operations into a separate function,
> so we only do one dsb per DMA mapping/unmapping operation.  That's
> particularly significant for the scattergather code.
> 
> I don't remember the reason why this was dropped as a candidate for
> merging - could that be because the dsb needs to be before the outer
> cache maintainence?  Adding Catalin for comment on that.

FWIW, trying this with MMC on OMAP4, I see no measurable difference in
performance nor CPU usage.
