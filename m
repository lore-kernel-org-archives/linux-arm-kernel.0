From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 6 Sep 2011 08:15:11 +0200
Subject: [PATCH] at91: add Atmel ISI and ov2640 support on m10/g45 board.
In-Reply-To: <4C79549CB6F772498162A641D92D532802A0995F@penmb01.corp.atmel.com>
References: <1314960609-23396-1-git-send-email-josh.wu@atmel.com>
	<20110902182137.GL20128@game.jcrosoft.org>
	<4C79549CB6F772498162A641D92D532802A0995F@penmb01.corp.atmel.com>
Message-ID: <20110906061511.GD677@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:55 Mon 05 Sep     , Wu, Josh wrote:
> 
> 
> On 09/03/2011 2:22 AM Jean-Christophe PLAGNIOL-VILLARD wrote: 
> 
> >>  
> >>  #include <asm/setup.h>
> >>  #include <asm/mach-types.h>
> >> @@ -194,6 +197,95 @@ static void __init ek_add_device_nand(void)
> >>  	at91_add_device_nand(&ek_nand_data);
> >>  }
> >>  
> >> +/*
> >> + *  ISI
> >> + */
> >> +#if defined(CONFIG_VIDEO_ATMEL_ISI) || defined(CONFIG_VIDEO_ATMEL_ISI_MODULE)
> >> +static struct isi_platform_data __initdata isi_data = {
> >> +	.frate		= ISI_CFG1_FRATE_CAPTURE_ALL,
> >> +	.has_emb_sync	= 0,
> >> +	.emb_crc_sync = 0,
> >> +	.hsync_act_low = 0,
> >> +	.vsync_act_low = 0,
> >> +	.pclk_act_falling = 0,
> >> +	/* to use codec and preview path simultaneously */
> >> +	.isi_full_mode = 1,
> >> +	.data_width_flags = ISI_DATAWIDTH_8 | ISI_DATAWIDTH_10,
> >> +};
> >> +
> >> +static void __init isi_set_clk(void)
> >> +{
> >> +	struct clk *pck1;
> >> +	struct clk *plla;
> >> +
> >> +	pck1 = clk_get(NULL, "pck1");
> >> +	plla = clk_get(NULL, "plla");
> >> +
> >> +	clk_set_parent(pck1, plla);
> >> +	clk_set_rate(pck1, 25000000);
> >> +	clk_enable(pck1);
> 
> > you must not enable the clock always
> 
> > you must enable it just when you need it
> 
> > and manage the clock at the board level really so so
> 
> I see, I will move such clock code to atmel_isi.c driver and add clock name, clock frequence to isi_platform_data structure in next version.
no you miss the idea bind the clkdev

you manage the clock at soc level and then only if it's mandatory at board
level

for the clock rate you pass it to the driver

and let the driver manage when it want to enable/disable the clock

the driver need to have a abtraction of the clock constraint and just request
it and use it

Best Regards,
J.
