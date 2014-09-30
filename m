From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 15:43:40 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140930123933.GA25395@peterchendt>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <3366285.QN2R3CQNzG@wuerfel> <20140930123933.GA25395@peterchendt>
Message-ID: <10249326.XCThPmSrfL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 20:39:34 Peter Chen wrote:
> Thanks, Arnd. I had not thought setting dma mask is so complicated, yes, it
> should check the return value, two things to confirm:
> 
> - dma_coerce_mask_and_coherent or dma_set_mask_and_coherent, the only difference
> of these two API is the first one do "dev->dma_mask = &dev->coherent_dma_mask;"
> The reason you suggest choosing dma_set_mask_and_coherent is you do not want
> assign dev->dma_mask?

No, that is just the current definition on ARM32 with CONFIG_ARCH_MULTIPLATFORM, and
that is going to change soon to be DT aware.
dma_set_mask_and_coherent() is supposed to check whether the platform can support
the respective mask and return an error if it cannot.

> - The second parameter for dma_set_mask_and_coherent is DMA_BIT_MASK(32), is it
> ok?
> 
> I just a little confused of what's the operation is "hardcoding the dma mask"?

dma_coerce_mask_and_coherent() will hardcode the dma mask and override whatever
the platform says is necessary.

	Arnd
