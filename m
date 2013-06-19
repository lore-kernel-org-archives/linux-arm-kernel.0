From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 19 Jun 2013 20:26:12 +0200
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <20130619174047.GB1403@sirena.org.uk>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk>
Message-ID: <3697657.tZFV7pR81Q@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 of June 2013 18:40:47 Mark Brown wrote:
> On Sun, Jun 16, 2013 at 10:54:07PM +0200, Tomasz Figa wrote:
> > One of the biggest roadblocks on the way of S3C64xx to DeviceTree
> > support is its DMA driver, which is completely platform-specific and
> > provides private API (s3c-dma), not even saying that its design is
> > completely against multiplatform-awareness.
> 
> I tried to test this on my s3c64xx based system but it gave me a kernel
> that didn't boot far enough to give console output (there's some early
> init stuff that uses SPI...).  That said, I needed:
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 210a893..0f49707 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -313,7 +313,7 @@ static int pl08x_request_mux(struct pl08x_dma_chan
> *plchan) int ret;
> 
>  	if (plchan->mux_use++ == 0 && pd->get_signal) {
> -		ret = pd->get_signal(plchan->cd);
> +		ret = (pd->get_signal)(plchan->cd);

Hmm, that's strange. The former is a completely valid piece of code...

>  		if (ret < 0) {
>  			plchan->mux_use = 0;
>  			return ret;
> 
> to get it to build which makes me suspect the compiler a bit as well...
> the system has audio, SPI and MMC enabled.
> 
> I was applying this to -next, are there any other dependencies I need or
> anything?

Hmm, I've been testing this on top of my common clock framework and device 
tree patches, but I don't think this had any effect. Did you add necessary 
clkdev lookups to the clock driver?

In Samsung CCF alias notation it looks like this:

+       ALIAS(HCLK_DMA1, "dma-pl080s.1", "apb_pclk"),
+       ALIAS(HCLK_DMA0, "dma-pl080s.0", "apb_pclk"),

Not sure how hard it will be to add such lookups to the old clock driver, 
though.

I will test this applied directly on top of current linux-next when I find 
some time, but for now you might check out my v3.11-devel branch on my 
github:

https://github.com/tom3q/linux.git

Best regards,
Tomasz
