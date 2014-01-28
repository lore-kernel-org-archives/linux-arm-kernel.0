From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 11:17:57 +0000
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <4697306.PPWWh8UGTE@wuerfel>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <1390890471-14882-3-git-send-email-agross@codeaurora.org>
 <52E772DF.6000604@metafoo.de> <4697306.PPWWh8UGTE@wuerfel>
Message-ID: <20140128111756.GE15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:16:53AM +0100, Arnd Bergmann wrote:
> On Tuesday 28 January 2014 10:05:35 Lars-Peter Clausen wrote:
> > Why does the direction needs to be specified in specifier? I see two
> > options, either the direction per is fixed in hardware. In that case the DMA
> > controller node should describe which channel is which direction. Or the
> > direction is not fixed in hardware and can be changed at runtime in which
> > case it should be set on a per descriptor basis.
> 
> Normally the direction is implied by dmaengine_slave_config().

No.  The direction argument in there is deprecated - we've been talking
about removing it for some time.

DMA engine drivers should store all parameters of the configuration, and
then select the appropriate ones when preparing a transfer (which itself
involves a direction.)

Not doing this implies that if you have a half-duplex device, you have to
repeatedly issue a dmaengine_slave_config() call, a prepare call, and a
submit call to the DMA engine code for every segment you want to transfer.
We don't need that kind of DMA engine specific behaviour in DMA engine
users.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
