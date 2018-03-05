From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 05 Mar 2018 22:30:23 +0100
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
In-Reply-To: <20180302124050.GF6255@sirena.org.uk>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <63331816.68OamKINx1@jernej-laptop> <20180302124050.GF6255@sirena.org.uk>
Message-ID: <26212674.B0xcQEiVyd@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne petek, 02. marec 2018 ob 13:40:50 CET je Mark Brown napisal(a):
> On Thu, Mar 01, 2018 at 11:23:57PM +0100, Jernej ?krabec wrote:
> > I removed parts of the code from the sun4i codec driver and interestingly
> > it doesn't crash if I remove following lines:
> > 
> > ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> > if (ret) {
> > 
> > 	dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
> > 	goto err_assert_reset;
> > 
> > }
> > 
> > Is it possible that NULL pointer causes troubles somewhere down the line?
> 
> Shouldn't be, that's just the configuration which is optional and not
> what we're crashing trying to register, we can mostly configure things
> by querying the capabilities of the DMA controller via the dmaengine API
> these days.  You're removing all the DMA support there so cutting out a
> huge segment of the initialization of both this driver and the machine
> driver.  Other sunxi devices seem to be starting happily in -next so
> there's something system dependent here...

I enabled memory debugging and it seems that there is an issue caused by 
loading sun4i-codec driver and it is somehow connected to 
snd_dmaengine_pcm_unregister().

Here is relevant dmesg: https://pastebin.com/raw/80K9GPnB

Does this tell anything?

Best regards,
Jernej
