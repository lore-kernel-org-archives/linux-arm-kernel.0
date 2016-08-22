From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Aug 2016 11:34:09 +0530
Subject: [PATCH 1/3] dt/bindings: arm-pl330: add description of
 arm,pl330-periph-burst
In-Reply-To: <d4574737-f7b7-2726-373c-31cc81274a32@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
 <1470365602-32586-2-git-send-email-shawn.lin@rock-chips.com>
 <20160805033410.GJ9681@localhost>
 <ea3572fa-4bff-87db-d5ad-f406809f8296@rock-chips.com>
 <0df0ab4f-0032-6487-2c30-b1ccd7d9ae62@metafoo.de>
 <1d42542f-c43c-5c4b-01b7-ba0ca085004a@rock-chips.com>
 <55e596a0-4176-4277-40cc-1d26763a8be0@rock-chips.com>
 <20160819024540.GQ9681@localhost>
 <d4574737-f7b7-2726-373c-31cc81274a32@rock-chips.com>
Message-ID: <20160822060409.GG2890@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 09:00:58AM +0800, Shawn Lin wrote:
> Hi Vinod,
> 
> ? 2016/8/19 10:45, Vinod Koul ??:
> >On Wed, Aug 17, 2016 at 04:11:03PM +0800, Shawn Lin wrote:
> >>Hi, Vinod and Lars-Peter
> >>
> >>Ping.. Any better idea to share :)
> >>
> >>On 2016/8/9 17:12, Shawn Lin wrote:
> >>>Hi Lars-Peter,
> >>>
> >>>? 2016/8/9 16:39, Lars-Peter Clausen ??:
> >>>>On 08/05/2016 09:25 AM, Shawn Lin wrote:
> >>>>>Hi Vinod,
> >>>>>
> >>>>>? 2016/8/5 11:34, Vinod Koul ??:
> >>>>>>On Fri, Aug 05, 2016 at 10:53:20AM +0800, Shawn Lin wrote:
> >>>>>>>This patch adds the "arm,pl330-periph-burst" for arm-pl330 to
> >>>>>>>support busrt mode.
> >>>>>>
> >>>>>>why should this be DT property. Only reason I can think of if some hw
> >>>>>>versions support this and some won't.
> >>>>>
> >>>>>yes, if we want to support burst mode, both of the master(pl330) and
> >>>>>client(several peripherals) should implement it, otherwise it will
> >>>>>be broken when enabling.
> >>>>
> >>>>As you said, it is up to the consumer peripheral whether it supports
> >>>>BURST,
> >>>>SINGLE or both. So this is a per client property, but you specify this
> >>>>as a
> >>>>a global property on the producer side.
> >>>
> >>>Thanks for comment.
> >>>
> >>>yup, but what is the proper way to add it ? :)
> >>>
> >>>
> >>>a) If pl330 support BURST as well as all the peripherals, we could
> >>>enable it.
> >>>
> >>>b) If pl300 support BURST, but all the peripherals don't support it,
> >>>we could not enable it.
> >>>
> >>>c) If pl300 support BURST, but not all the peripherals support it,
> >>>we also could not enable it.
> >>>
> >>>the burst feature of peripheral IP may be vendor-specific, but the
> >>>common driver for this peripheral are used for many many vendors which
> >>>means we could not check all of this info. It's very likely to break
> >>>them... I couldn't figure out how many upstreamed peripheral drivers
> >>>who are using pl300 either.
> >>>
> >>>So this check should be done by all this vendors but we could make
> >>>sure we don't break them before they check a), b), c), right?
> >
> >Since support for BURST needs to be from peripheral too, we should have
> >that as a property for peripheral not for controller.
> >
> >The peripheral drivers can communicate the burst to be used to pl330
> >using src_maxburst/dst_maxburst in dma_slave_config. We can use this
> >value to indicate the DMA should be single (a value of 0) or burst with
> >"burst" value.
> 
> Thanks for sharing this.
> 
> But this is really a difficult trade-off decision to add this new
> property for pl330 only.
> 
> Burst mode was supported by Boojin Kim's patch by default(commit
> 848e9776fee42 ("dmaengine: pl330: support burst mode for dev-to-mem and
> mem-to-dev transmit")).  But we found it will break SoCFPGA or
> Exynos4412 reported by Dinh Nguyen and Bartlomiej Zolnierkiewicz[0].
> So finally Caesar Wang contributed a patch, commit 0a18f9b268 ("
> dmaengine: pl330: fix to support the burst mode") to fix it, but what
> it actually did is to use single burst for any case, namely some kind
> of regression for Boojin Kim's improvement.
> 
> So we can see these drivers which was broken by enabling burst mode
> had already set src_maxburst/dst_maxburst. It looks to me so unfortunate
> that the driver like 8250_dw.c was using so widely that we couldn't
> set scr/dst_maxburst as this is really vendor specific for whether it
> supports burst for 8250_dw or not..
> 
> So it is quite painful that we probably will get dozens of regression
> reports when enabling burst mode by default. But without this, we have
> been suffering from low performance quite a long time due to this
> roadblock.

well in that case I would suggest fixing client first. Make all users of
pl330 not to use burst mode and then enable them one by one after testing

> 
> Two possible paths to land this patch are:
> (1) Keep this property for pl330 only, so we have no chance to
> break others and we could make the platforms enjoy it if adding this
> property for their own dts.
> 
> (2) Figuer out all the broken platfroms if enabling burst and fix them
> one by one for the src/dst_maxburst(maybe by enabling burst mode and
> get regression reports). If we could not solve any one of them, then we
> have to give up all the effort we do, and let this pain keep on
> stalling people's expectation of better performance.
> 
> 
> I would appreciate it if you could share your thought more, as I
> really want more platforms benefit from it(at least don't break
> them)  :)
> 
> 
> [0] http://www.gossamer-threads.com/lists/linux/kernel/2374171
> 
> >
> 
> 
> -- 
> Best Regards
> Shawn Lin
> 

-- 
~Vinod
