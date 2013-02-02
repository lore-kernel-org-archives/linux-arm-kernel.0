From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 02 Feb 2013 16:09:55 +0100
Subject: [PATCH V2 4/4] DMA: PL330: Modify pl330 filter based on new
 generic dma dt bindings.
In-Reply-To: <CAAgF-Bf55eN2WOgU5nQa=nF76fHvBHR7NdmvoBpF-n4ke6rd1g@mail.gmail.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
 <201302011523.25771.arnd@arndb.de>
 <CAAgF-Bf55eN2WOgU5nQa=nF76fHvBHR7NdmvoBpF-n4ke6rd1g@mail.gmail.com>
Message-ID: <1692358.6BmDsJsb25@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 February 2013 08:00:54 Padma Venkat wrote:

> > The result of this looks good, but I fear that changing the filter function
> > like this wil break all drivers that currently use the plat-samsung/dma-ops.c
> > code. For migration purposes, I think the best way is to change
> > samsung_dmadev_request() to match the new filter_param format.
> >
> > After that is done, you can migrate all the drivers using samsung_dma_get_ops
> > over to the new dma_request_slave_channel interface without breaking
> > anything when only part of the series is applied.
> >
> >         Arnd
> 
> Please check the below link where I made the dma request compatible to
> both DT and non-DT
> 
> http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=e7ba5f1d0f6292e1b99c63cc4bb74c70232e9065
> http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=b5be04d35dbb2e00ab27a97bfd26e17019e857ef
> 
> Please let me know if any changes required.
> 

Those two changes by themselves still look ok, I think but you
still break the non-DT case in this 4/4 patch by changing the
pl330_filter function in an incompatible way. You will still
have to either change the filter_param argument in the
samsung_dmadev_request() function, or provide separate filter
functions, one to be used by samsung_dmadev_request and
one for the pl330_xlate function.

In the long run, I think it would be better to move the slave
drivers away from the samsung_dma wrappers and use
dma_request_slave_channel directly, but that is an independent
discussion.

	Arnd
