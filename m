From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 10 Nov 2016 11:03:23 +0000
Subject: [PATCH RFC 2/7] ARM: S3C64XX: Add DMA slave maps for PL080 devices
In-Reply-To: <f53d533d-163f-31f3-4efb-0e39d201589d@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-4-git-send-email-s.nawrocki@samsung.com>
 <20161108144445.GD1575@localhost.localdomain>
 <CGME20161108145620epcas2p4b8e2ec5ffdd4bf04ab3bf0728b46e3f2@epcas2p4.samsung.com>
 <20161108145534.GE1575@localhost.localdomain>
 <f53d533d-163f-31f3-4efb-0e39d201589d@samsung.com>
Message-ID: <20161110110323.GG1575@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 04:53:40PM +0100, Sylwester Nawrocki wrote:
> On 11/08/2016 03:55 PM, Charles Keepax wrote:
> >>> diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
> >>> > > index 89c5a62..8c88680 100644
> >>> > > --- a/arch/arm/mach-s3c64xx/pl080.c
> >>> > > +++ b/arch/arm/mach-s3c64xx/pl080.c
> >> > <snip>
> >>> > > @@ -134,6 +153,8 @@ struct pl08x_platform_data s3c64xx_dma0_plat_data = {
> >>> > >  	.put_xfer_signal = pl08x_put_xfer_signal,
> >>> > >  	.slave_channels = s3c64xx_dma0_info,
> >>> > >  	.num_slave_channels = ARRAY_SIZE(s3c64xx_dma0_info),
> >>> > > +	.slave_map = s3c64xx_dma0_slave_map,
> >>> > > +	.slavecnt = ARRAY_SIZE(s3c64xx_dma0_slave_map),
> >>> > >  };
> >> > 
> >> > Here we add a .slavecnt but the pl08x_platform_data structure doesn't
> >> > contain that field. I can't see it on the branch you linked in
> >> > the cover letter either, is it added by a patch on another branch
> >> > I am missing?
> >> > 
> > Ah I think I see it should be .slave_map_len here.
> 
> Yeah, sorry, I fixed it after getting report from the kbuild test
> but have forgotten to push changes to the git tree.
> 
> I pushed now to branch for-v4.10/dma/pl080-s3c64xx-v2 with this
> issue fixed and added initialization of the filer function.

Apologies for the delay got somewhat swamped with internal stuff
yesterday. Yeah using that branch it looks good to me, the SPI and
I2S are both working fine. I can download code to the wm0010
which should be a good work out of the SPI and play audio
correctly so the I2S should be fine. So for the series:

Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>


I do still need to revert these two patches to get the I2S to
work properly:

commit d70e861a3154833467023123e218e9b1ba558809
ASoC: samsung: Remove SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag

commit acde50a7bf1fd6ae0baa4402f0a02c4b1bd4c990
ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE internal

But that is clearly an unrelated issue, which I haven't found
time to look into yet as we don't use this platform that often
these days.

Thanks,
Charles
