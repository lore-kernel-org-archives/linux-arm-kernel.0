From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 7 Aug 2015 09:56:58 +0800
Subject: [PATCH v3 3/8] soc: Mediatek: Add SCPSYS CPU power domain driver
In-Reply-To: <20150806100311.GP18700@pengutronix.de>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
 <1438696464-59858-4-git-send-email-scott.shu@mediatek.com>
 <20150805085034.GG18700@pengutronix.de>
 <1438829942.9435.24.camel@mtkswgap22>
 <20150806100311.GP18700@pengutronix.de>
Message-ID: <1438912618.1900.31.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-08-06 at 12:03 +0200, Sascha Hauer wrote:
> On Thu, Aug 06, 2015 at 10:59:02AM +0800, Scott Shu wrote:
> > On Wed, 2015-08-05 at 10:50 +0200, Sascha Hauer wrote:
> > > don't do this then it indeed doesn't make much sense to put it into the
> > > same file.
> > > 
> > > From what I see we would need to change the prototype to something like
> > > 
> > > static int __scpsys_power_on(struct scp_domain_data *)
> > > 
> > > (maybe with some additional base addresses and stuff)
> > > 
> > > struct scp_domain_data would additionally need sram_isoint_b and sram_ckiso
> > > members.
> > > 
> > > Sascha
> > > 
> > Hi Sascha,
> >    The CPU power sequence is quite different with the others, as
> > described below.
> > 
> > * Non-CPU
> >    1) Set PWR_ON_BIT, PWR_ON_2ND_BIT
> >    2) Wait PWR_ACK
> >    3) Clear PWR_CLK_DIS_BIT
> >    4) Clear PWR_ISO_BIT
> >    5) Set PWR_RST_B_BIT
> >    6) Clear SRAM_PDN
> >    7) Wait SRAM_PDN_ACK
> > * CPU
> >    1) Set PWR_ON_BIT, PWR_ON_2ND_BIT
> >    2) Wait PWR_ACK
> >    3) Clear PWR_ISO_BIT
> >    4) Clear L1_PDN to power on L1
> >    5) Wait L1_PDN_ACK
> >    6) Set SRAM_ISOINT_B
> >    7) Clear SRAM_CKISO
> >    8) Clear PWR_CLK_DIS
> >    9) Set PWR_RST_B
> > For multi-cluster SoC, the cluster power sequence is also different.
> > 
> > Please think if this is a good idea if we integrate the CPU support into
> > the scpsys_power_on()? Based on the readability and compatible
> > considerations, we provide this patch.
> 
> Maybe it's best if you go back to the v1 layout and put your scpsys code
> to arch/arm/mach-mediatek/. While I think it's possible to share some
> more code I am not sure anymore if this buys us something. We'll know in
> the future.
> 
> Sascha
> 
> 
Thanks Sascha. If you agree, we prefer to keep v3 layout. It's good to
put all scpsys related code and definitions in the same place (your
driver) and limit the CPU MTCMOS code are all located in button half of
the file. We may also change the function name, for example, rename
spm_cpu_mtcmos_on/off to scpsys_cpu_power_on/off, to make a better
overall sense. 

Scott
