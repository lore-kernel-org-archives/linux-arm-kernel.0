From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Mar 2016 22:42:02 +0100
Subject: dmaengine pl08x dt crash
In-Reply-To: <20160323172600.GA16903@sig21.net>
References: <20160323154049.GA2170@sig21.net>
 <CACRpkdZ3ecJPcUfv7TTPhTT+rMtAC+b1=HfE3cH0OR=swvNi6w@mail.gmail.com>
 <20160323162309.GA9472@sig21.net> <20160323163517.GA9563@sig21.net>
 <20160323172600.GA16903@sig21.net>
Message-ID: <CACRpkdb+dH5+vK8CTxk-BZ-xc_Y9+C_C7hLVBVcvsZ6NC9AG_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 6:26 PM, Johannes Stezenbach <js@sig21.net> wrote:

> Now I see the need for the first patch, but I wonder
> why not just amend the second one with this instead:
>
> @@ -1916,6 +1916,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
>
>                 if (slave) {
>                         chan->cd = &pl08x->pd->slave_channels[i];
> +                       chan->signal = i;
>                         pl08x_dma_slave_init(chan);
>                 } else {
>                         chan->cd = &pl08x->pd->memcpy_channel;
>
> (The assignment of chan->name = chan->cd->bus_id is
> already done by pl08x_dma_slave_init().)
>
> If the platform is using a mux then pd->get_xfer_signal()
> would replace the signal, so this initialization wouldn't
> do any harm, right?

I agress that seems simpler. I'll squash it like so and send it out
so we get some rotation on this patch set.

> Also, I wonder if "#define PL08X_DMA_SIGNALS 32" is an issue
> with pl081 which only has 16 signals?  But I guess not since
> nothing would request them.

PL080 also just has 16 channels. But the extended version on
the Nomadik uses all 32 bits in the register. The assumption is
simply that one 32bit register will house all signals.

Yours,
Linus Walleij
