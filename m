From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 23 Mar 2016 18:26:00 +0100
Subject: dmaengine pl08x dt crash
In-Reply-To: <20160323163517.GA9563@sig21.net>
References: <20160323154049.GA2170@sig21.net>
 <CACRpkdZ3ecJPcUfv7TTPhTT+rMtAC+b1=HfE3cH0OR=swvNi6w@mail.gmail.com>
 <20160323162309.GA9472@sig21.net> <20160323163517.GA9563@sig21.net>
Message-ID: <20160323172600.GA16903@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:35:17PM +0100, Johannes Stezenbach wrote:
> On Wed, Mar 23, 2016 at 05:23:09PM +0100, Johannes Stezenbach wrote:
> > On Wed, Mar 23, 2016 at 05:12:13PM +0100, Linus Walleij wrote:
> > > https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-nomadik.git/log/?h=pl08x-dma
> > > 
> > > dma: pl08x: support fixed signal assignment
> 
> This method of using vendor_data for the fixed_signals flag
> doesn't help me much, as my IP is a plain ARM pl081.
> 
> I'm also not sure how it would help, since pl08x_of_probe()
> is only called for !pl08x->pd (no platform_data) and thus
> pl08x_dma_init_virtual_channels() sees 0 channels.
> And with platform_data the driver worked fine with fixed channels.
> 
> > > dma: pl08x: allocate OF slave channel data at probe time
> 
> This looks ore promising, I'm checking it.

Now I see the need for the first patch, but I wonder
why not just amend the second one with this instead:

@@ -1916,6 +1916,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,

                if (slave) {
                        chan->cd = &pl08x->pd->slave_channels[i];
+                       chan->signal = i;
                        pl08x_dma_slave_init(chan);
                } else {
                        chan->cd = &pl08x->pd->memcpy_channel;

(The assignment of chan->name = chan->cd->bus_id is
already done by pl08x_dma_slave_init().)

If the platform is using a mux then pd->get_xfer_signal()
would replace the signal, so this initialization wouldn't
do any harm, right?

Also, I wonder if "#define PL08X_DMA_SIGNALS 32" is an issue
with pl081 which only has 16 signals?  But I guess not since
nothing would request them.


Johannes
