From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:09:39 +0200
Subject: [PATCH 16/32] dmaengine: ste_dma40: Remove unnecessary call to
 d40_phy_cfg()
In-Reply-To: <1366279934-30761-17-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQpiEZ4etyE=mveH8HFughVe_oa81P3QEWWJHPtrxn0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> All configuration left in d40_phy_cfg() is runtime configurable and
> there is already a call into it from d40_runtime_config(), so let's
> rely on that.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

NAK. Have you really tested this with memcpy()?

The runtime config function is *not* called when doing memcpy
DMA, still the channels used for memcpy need to be configured
obviously. Now you're assuming that every time anyone is using
a DMA channel they will first allocate it, then call the runtime
config. This is not true.

Runtime config is only used when doing dev->mem and
mem->dev DMA.

You may just as well compile in the test program that is there right
in the kernel and run it ... it's good! (DMA Test Client in
menuconfig under drivers/dma engine support...)

There was this other patch not taking the memcpy channels
into the array that I think will also cause a crash when doing
memcpy so I'm pretty sure you're not testing this.

When I test these patches I will run it, and just report
that memcpy doesn't work if it doesn't and then you'll
have to figure it out anyway, so enjoy...

Yours,
Linus Walleij
