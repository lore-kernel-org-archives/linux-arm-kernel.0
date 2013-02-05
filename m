From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 23:51:26 +0000
Subject: [PATCH] ARM: SAMSUNG: dma: Remove unnecessary code
In-Reply-To: <CAAgF-Bf4Jhv1AKFdkNMHtrPojHgt2a2L2bg=dJvfsEq=cmbFkg@mail.gmail.com>
References: <1359967675-624-1-git-send-email-padma.v@samsung.com>
 <201302051113.22720.arnd@arndb.de>
 <CAAgF-Bf4Jhv1AKFdkNMHtrPojHgt2a2L2bg=dJvfsEq=cmbFkg@mail.gmail.com>
Message-ID: <201302052351.26643.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013, Padma Venkat wrote:
> In none of my patches I have changed the pl330_filter args.  This
> function always takes the same argument void*. In non-DT case 'enum
> dma_ch' was typecasted to void* and in DT case I am passing a pointer
> to dma_pl330_filter_args and in pl330_filter function they are
> converted back. In both cases it finally comes down to
> dma_request_channel which takes them as void* which in turn calls the
> pl330_filter.
> 
> I think this is what you are pointing to. Please let me know if I am
> still wrong :( .

I think I see the misunderstanding now. The pl330_filter function
you have actually interprets the void* argument differently, based
on whether the pl330 device was instantiated from device tree or not.
I failed to see this, and you are probably right that this works
correctly.

It is however a rather unusual interface, and it would be safer and
easier to understand if you used separate filter functions for
the two cases, like this:

bool pl330_filter(struct dma_chan *chan, void *param)
{
        u8 *peri_id;

        if (chan->device->dev->driver != &pl330_driver.drv)
                return false;

        peri_id = chan->private;
        return *peri_id == (unsigned)param;
}
EXPORT_SYMBOL(pl330_filter);

static bool pl330_dt_filter(struct dma_chan *chan, void *param)
{
        struct dma_pl330_filter_args *fargs = param;

        if (chan->device != &fargs->pdmac->ddma)
                return false;

        return (chan->chan_id == fargs->chan_id);
}

So this is not a correctness issue, but more one of readability. I would
assume however that if I was misunderstanding the code, the next person
also wouldn't know what is going on here if you have one filter function
that performs two completely different tasks.

	Arnd
