From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jul 2011 12:03:22 +0200
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
Message-ID: <CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 6:17 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:

> 1) Striding, in one form or other, is supported by other DMACs as well.
> ? The number will only increase in future.
> ? Are we to add ?<VENDOR>_DMA_STRIDE_CONFIG for each case ?

If we are sure about this and striding will work in a similar way on all
then let's have the enum named DMA_STRIDE_CONFIG and move the
passed-in struct to <linux/dmaengine.h) then?

Would that be:

struct dma_stride_config {
    u32 read_bytes;
    u32 skip_bytes;
};

Or something more complex?

> 2) As Dan noted, client drivers are going to have ifdef hackery in
> order to be common
> ?to other SoCs.

Don't think so, why? This is a runtime config entirely, and I just illustrated
in mail to Dan how that can be handled by falling back to a sglist I believe?

We can *maybe* even put the fallback code into dmaengine, so that an
emulated sglist in place for the DMAengine is done automatically of the
DMA controller does not support striding.

> 3) TI may not have just one DMAC IP used in all the SoCs. So if you want
> ?vendor specific defines anyway, please atleast also add DMAC version to it.
> ?Something like
>> ? ? ? ?DMA_SLAVE_CONFIG,
>> ? ? ? ?FSLDMA_EXTERNAL_START,
>> + ? ? ? TI_DMA_v1_STRIDE_CONFIG,

Yep unless we make it generic DMA_STRIDE_CONFIG simply, this makes
a lot of sense.

Linus Walleij
