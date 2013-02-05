From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 11:13:22 +0000
Subject: [PATCH] ARM: SAMSUNG: dma: Remove unnecessary code
In-Reply-To: <CAAgF-BfaYo7FoYyFHo1eW-bUGOYdvcfskf7_7UhmCOzASoreYg@mail.gmail.com>
References: <1359967675-624-1-git-send-email-padma.v@samsung.com>
 <201302041743.55029.arnd@arndb.de>
 <CAAgF-BfaYo7FoYyFHo1eW-bUGOYdvcfskf7_7UhmCOzASoreYg@mail.gmail.com>
Message-ID: <201302051113.22720.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013, Padma Venkat wrote:
> On Mon, Feb 4, 2013 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 04 February 2013, Padmavathi Venna wrote:
> >> diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
> >> index 71d58dd..ec0d731 100644
> >> --- a/arch/arm/plat-samsung/dma-ops.c
> >> +++ b/arch/arm/plat-samsung/dma-ops.c
> >> @@ -23,23 +23,15 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
> >>                               struct device *dev, char *ch_name)
> >>  {
> >>       dma_cap_mask_t mask;
> >> -     void *filter_param;
> >>
> >>       dma_cap_zero(mask);
> >>       dma_cap_set(param->cap, mask);
> >>
> >> -     /*
> >> -      * If a dma channel property of a device node from device tree is
> >> -      * specified, use that as the fliter parameter.
> >> -      */
> >> -     filter_param = (dma_ch == DMACH_DT_PROP) ?
> >> -             (void *)param->dt_dmach_prop : (void *)dma_ch;
> >> -
> >>       if (dev->of_node)
> >>               return (unsigned)dma_request_slave_channel(dev, ch_name);
> >>       else
> >>               return (unsigned)dma_request_channel(mask, pl330_filter,
> >> -                                                     filter_param);
> >> +                                                     (void *)dma_ch);
> >>  }
> >
> > This still looks wrong to me, because the pl330_filter function now tkes
> > a struct dma_pl330_filter_args pointer argument, not dma_ch name.
> 
> Below is my understanding about generic dma and our discussion on
> previous versions of my patches.
> 
> I can?t pass single dma channel number(may be not dma_ch name in your
> comment above) as void* argument to pl330_filter.  Because I also need
> to compare against the dma controller device node, as my requested
> channel can belong to any of the available dma controller on SoC.  So
> I either need to pass pointer to dma_spec as void* argument which
> holds the dma controller node and required channel number or I can
> pass pointer to dma_pl330_filter_args as per your dw_dmac patches.

Right.

> If I pass pointer to dma_spec I can have a check like below in my
> filter function
> return ((chan->private == dma_spec->np) && (chan->chan_id == dma_spec->args[0]))
> 
> Or if I pass dma_pl330_filter_args I can have a check like below.
> return ((chan->device == &fargs->pdmac->ddma) && (chan->chan_id ==
> fargs->chan_id));
> 
> I modified  the pl330_filter function based on your dw_dmac patches.
> Indeed I don?t need to pass pointer to pdmac object as 3rd arg in
> of_dma_controller_register .  Even I pass NULL here works for me.
> Can I pass NULL here as the third argument in of_dma_controller_register?

These are all not the issues I am referring to in my comment above.
I think it works either way, even if you pass NULL to
of_dma_controller_register, although using it for the pdmac object
seems cleaner to me.

> Please clarify me which is best way of doing this and correct me if my
> understanding is wrong.

My point was that in the samsung_dmadev_request quoted above, you
refer to the same pl330_filter filter function, but the argument there
is a pointer to 'enum dma_ch', which is not compatible with any of
the methods you list, neither the dma_pl330_filter_args nor the
raw property.

Also, if you change the calling conventions for the pl330_filter
function, you should change both the caller and the function in the
same patch.

	Arnd
