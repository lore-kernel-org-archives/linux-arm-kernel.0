From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Apr 2013 14:20:25 +0100
Subject: [PATCH 04/32] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <CACRpkdbV8yEK0470q_-DWv6Q0hAG2wGntXFi5kaLUMgm9b=e-Q@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
 <20130425090612.GC4623@gmail.com>
 <CACRpkdbV8yEK0470q_-DWv6Q0hAG2wGntXFi5kaLUMgm9b=e-Q@mail.gmail.com>
Message-ID: <20130425132025.GM4623@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 25, 2013 at 11:06 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> >> Are we now sacrificing that ability on the altar of simplification?
> >>
> >> I actually think not, but that we should do periph-to-periph transfers
> >> in some other way, and that the .dir attribute should go away from
> >> the struct stedma40_chan_cfg as well but I'm not entirely sure.
> >> Someone else?
> >
> > Although the DMA40 device supports device-to-device transfers, Linux
> > does not, so this subject is moot AFAICT.
> 
> So while there is no active usecase, Linux surely has the ambition to do
> that as can be seen in:
> 
> /**
>  * enum dma_transfer_direction - dma transfer mode and direction indicator
>  * @DMA_MEM_TO_MEM: Async/Memcpy mode
>  * @DMA_MEM_TO_DEV: Slave mode & From Memory to Device
>  * @DMA_DEV_TO_MEM: Slave mode & From Device to Memory
>  * @DMA_DEV_TO_DEV: Slave mode & From Device to Device
>  */
> enum dma_transfer_direction {
>         DMA_MEM_TO_MEM,
>         DMA_MEM_TO_DEV,
>         DMA_DEV_TO_MEM,
>         DMA_DEV_TO_DEV,
>         DMA_TRANS_NONE,
> };
> 
> I think we need a handshake with Vinod on this.

Sure. He is CC'ed.

> >> If you're doing this change, and after this RX and TX has no semantical
> >> meaning for these lists, join these two config lists
> >> into one.
> >
> > I agree. See patch: ARM: ux500: Strip out duplicate USB DMA configuration
> 
> Please squash the applicable portions into this patch then, I don't
> particularly like fix-later patchstack patterns, it makes series hard to
> review.

Okay.

> >> (...)
> >> > diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
> >> >  static u32 d40_chan_has_events(struct d40_chan *d40c)
> >> > @@ -1744,8 +1740,6 @@ static int d40_validate_conf(struct d40_chan *d40c,
> >> >                              struct stedma40_chan_cfg *conf)
> >> >  {
> >> >         int res = 0;
> >> > -       u32 dst_event_group = D40_TYPE_TO_GROUP(conf->dst_dev_type);
> >> > -       u32 src_event_group = D40_TYPE_TO_GROUP(conf->src_dev_type);
> >>
> >> Please explain why this is not important to check anymore, I'm not
> >> following.
> >>
> >> >         if (conf->dir == STEDMA40_MEM_TO_PERIPH &&
> >> > -           dst_event_group == STEDMA40_DEV_DST_MEMORY) {
> >> > -               chan_err(d40c, "Invalid dst\n");
> >> > +           d40c->base->plat_data->dev_tx[conf->dev_type] == 0 &&
> >> > +           d40c->runtime_addr == 0) {
> >> > +               chan_err(d40c, "Invalid TX channel address (%d)\n",
> >> > +                        conf->dev_type);
> >>
> >> Like here. We are checking for inconsistency between group
> >> and channel direction, why is it no longer important to check this?
> >
> > I'm not entirely sure how this ever worked:
> >
> >   #define D40_TYPE_TO_GROUP(type) (type / 16)
> >   #define STEDMA40_DEV_DST_MEMORY (-1)
> >
> >   (dev_type / 16) == -1
> >
> > What number would dev_type have to be for this to be true? -16?
> 
> No, since it's u32 it cannot really represent negative numbers.
> 
> This is equivalent:
> #define D40_TYPE_TO_GROUP(type) (type >> 4)
> 
> As -1 is 0xffffffff in u32 it will compare at best
> 0x0fffffff to 0xfffffff. And that is non-attainable.
> 
> So the line checking event group for == DTEDMA40_DEV_DST_MEMORY
> should be  removed in a separate patch prior to this one, with
> something like the above as commit message.
> 
> We cannot really mix that cleanup into this patch...

I'm happy to do that.

> >> >         if (conf->dir == STEDMA40_PERIPH_TO_MEM &&
> >> > -           src_event_group == STEDMA40_DEV_SRC_MEMORY) {
> >> > -               chan_err(d40c, "Invalid src\n");
> >> > -               res = -EINVAL;
> >> > -       }
> >
> > As above.
> 
> And same comment.
> 
> >> > -       if (conf->dir == STEDMA40_PERIPH_TO_PERIPH &&
> >> > -           (src_event_group != dst_event_group)) {
> >> > -               chan_err(d40c, "Invalid event group\n");
> >> > +           d40c->base->plat_data->dev_rx[conf->dev_type] == 0 &&
> >> > +           d40c->runtime_addr == 0) {
> >> > +               chan_err(d40c, "Invalid RX channel address (%d)\n",
> >> > +                        conf->dev_type);
> >>
> >> Same here.
> >
> > I stopped all 'dev_src/dev_dest' comparisons, as there is only 'dev' now.
> 
> It is checking for:
> conf->dir == STEDMA40_PERIPH_TO_PERIPH
> 
> As we may want to support DEV_TO_DEV at some point.
> 
> Then no longer, and that is not related to $SUBJECT.

That's not why I'm removing it. The statement can never be true due to
the fact that the second evaluation (src_event_group != dst_event_group)
can never be true, which is a direct effect of 'THIS_PATCH'.

> >> (...)
> >> > @@ -2062,7 +2035,7 @@ static int d40_free_dma(struct d40_chan *d40c)
> >> >  {
> >> >
> >> >         int res = 0;
> >> > -       u32 event;
> >> > +       u32 event = D40_TYPE_TO_EVENT(d40c->dma_cfg.dev_type);
> >> >         struct d40_phy_res *phy = d40c->phy_chan;
> >> >         bool is_src;
> >> >
> >> > @@ -2081,13 +2054,11 @@ static int d40_free_dma(struct d40_chan *d40c)
> >> >         }
> >> >
> >> >         if (d40c->dma_cfg.dir == STEDMA40_MEM_TO_PERIPH ||
> >> > -           d40c->dma_cfg.dir == STEDMA40_MEM_TO_MEM) {
> >> > -               event = D40_TYPE_TO_EVENT(d40c->dma_cfg.dst_dev_type);
> >> > +           d40c->dma_cfg.dir == STEDMA40_MEM_TO_MEM)
> >>
> >> Why did you just stop checking dma_cfg.dir for == STEDMA40_MEM_TO_MEM
> >> above?
> >
> > That's not what this is doing. STEDMA40_MEM_TO_MEM is still there.
> >
> >> And why is dma_cfg.dir suddenly hardcoded to MEM_TO_MEM??
> >
> > It's not. Look again. :)
> 
> Argh I misread == MEM_TO_MEM for = MEM_TO_MEM ...
> comparison to assignment. Sorry.
> 
> >> This seems like a totally unrelated change and should it be done
> >> it need to be a separate patch with a separate explanation
> >> AFAICT.
> >>
> >> This seems to happen in some other places too,
> >
> > If you could point those out, I'll re-evaluate, or explain.
> 
> I'm after that the change to omit checks for some impossible
> type/group configs need to be a separate patch.
> 
> >> and I find it
> >> very hard to follow the changes here ... can you please consider
> >> splitting the changes to groups and types semantics into a separate
> >> patch?
> >
> > Can you read the patch again and reconsider please?
> 
> Yes and now I am even more convinced that the patch needs
> to be split.
> 
> Yours,
> Linus Walleij

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
