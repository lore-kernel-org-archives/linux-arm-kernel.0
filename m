From: mporter@ti.com (Matt Porter)
Date: Thu, 4 Oct 2012 06:28:19 -0400
Subject: [alsa-devel] [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <506D5D8A.7030902@gmail.com>
References: <506A9C65.5040309@ti.com>
 <20121002093753.GU4360@opensource.wolfsonmicro.com>
 <506AC303.9080906@gmail.com> <506ACACE.4030308@ti.com>
 <506AEF57.2000306@gmail.com> <20121002164116.GT5641@beef>
 <506B1B46.2070006@gmail.com> <506D552A.2000506@gmail.com>
 <E4D2ACDC-4749-4988-ADC5-277C187B0DC6@ti.com>
 <506D5D8A.7030902@gmail.com>
Message-ID: <20121004102819.GA11149@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 11:57:30AM +0200, Daniel Mack wrote:
> On 04.10.2012 11:38, Porter, Matt wrote:
> > 
> > On Oct 4, 2012, at 5:21 AM, Daniel Mack wrote:
> > 
> >>
> >>
> >> On 02.10.2012 18:50, Daniel Mack wrote:
> >>> On 02.10.2012 18:41, Matt Porter wrote:
> >>>> On Tue, Oct 02, 2012 at 03:42:47PM +0200, Daniel Mack wrote:
> >>>>> On 02.10.2012 13:06, Sekhar Nori wrote:
> >>>>>> On 10/2/2012 4:03 PM, Daniel Mack wrote:
> >>>>>>> On 02.10.2012 11:37, Mark Brown wrote:
> >>>>>>>> On Tue, Oct 02, 2012 at 10:48:53AM +0300, Peter Ujfalusi wrote:
> >>>>>>>>
> >>>>>>>>> I also agree that ifdef is not a good solution.
> >>>>>>>>> It is better to have this information passed as device_data and via DT it can
> >>>>>>>>> be decided based on the compatible property for the device.
> >>>>>>>>
> >>>>>>>> That's not really the problem here - the problem is that the APIs used
> >>>>>>>> to get the SRAM are DaVinci only so it's not possible to build on OMAP
> >>>>>>>> or other platforms.  The SRAM code needs to move to a standard API.
> >>>>>>>
> >>>>>>> What about following Matt Porter's idea and ignore the SRAM code
> >>>>>>> entirely and port the entire PCM code to generic dmaengine code first?
> >>>>>>> The EDMA driver needs to learn support for cyclic DMA for that, and I
> >>>>>>> might give that a try in near future.
> >>>>>>>
> >>>>>>> Later on, the SRAM ping-pong code can get added back using genalloc
> >>>>>>> functions, as Sekhar proposed. That needs to be done by someone who has
> >>>>>>> access to a Davinci board though, I only have a AM33xx/OMAP here.
> >>>>>>
> >>>>>> We cannot "get rid" of SRAM code and add it back "later". It is required
> >>>>>> for most DaVinci parts. The SRAM code can be converted to use genalloc
> >>>>>> (conversion should be straightforward and I can help test it) and the
> >>>>>> code that uses SRAM can probably keep using the private EDMA API till
> >>>>>> the dmaengine EDMA driver has cyclic DMA support. Matt has already
> >>>>>> posted patches to move private EDMA APIs to a common location. That
> >>>>>> should keep AM335x build from breaking. Is this something that is feasible?
> >>>>>
> >>>>> Yes - by "later" I just meant in a subsequent patch. But you're probably
> >>>>> right, we can also do that first.
> >>>>>
> >>>>> I'm looking at that right now and the problem seems that we don't have a
> >>>>> sane way to dynamically look up gen_pools independently of the actual
> >>>>> run-time platform. All users of gen_pools seem to know which platform
> >>>>> they run on and access a platform-specific pool. So I don't currently
> >>>>> see how we could implement multi-platform code, gen_pools are fine but
> >>>>> don't solve the problem here.
> >>>>>
> >>>>> Would it be an idea to add a char* member to gen_pools and a function
> >>>>> that can be used to dynamically look it up again? If a buffer with a
> >>>>> certain name exists, we can use it and install that ping-pong buffer,
> >>>>> otherwise we just don't. While that would be easy to do, it's a
> >>>>> tree-wide change.
> >>>>>
> >>>>> Is there a better way that I miss?
> >>>>
> >>>> At the high level there's two platform models we have to handle, the
> >>>> boot from board file !DT case, and then the boot from DT case. Since
> >>>> Davinci is just starting DT conversion, we mostly care about the !DT
> >>>> base in which the struct gen_pool * is passed in pdata to the ASoC
> >>>> driver. It is then selectable on a per-platform basis where the decision
> >>>> should be made.
> >>>>
> >>>> Given a separate discussion with Sekhar, we're only going to have one
> >>>> SRAM pool on any DaVinci part right now...this was only a question on
> >>>> L138 anyway. But regardless, the created gen_pool will be passed via
> >>>> pdata.
> >>>
> >>> I thought about this too, as mmp does it that way.
> >>>
> >>>> Since DT conversion is starting and we need to consider that now,
> >>>> the idea there is to use the DT-based generic sram driver [1] such that
> >>>> when we do boot from DT on Davinci, the genpool is provided via phandle
> >>>> and the pointer extracted with the OF helpers that are part of the
> >>>> series.
> >>>
> >>> A phandle is the cleanest way I think, yes.
> >>>
> >>>> That's pretty much it. I'm reworking the backend support as discussed
> >>>> with Sekhar wrt to my uio_pruss series. I can post a standalone series
> >>>> that just replaces sram_* with genalloc for davinci ASoC.
> >>>
> >>> As you can also test it, it would be easiest if you came up with a patch
> >>> for that, yes. I can have a look at the dma bits laters, once my OMAP
> >>> board finally works with the code as it currently stands. I'm still
> >>> fighting with the mcasp driver right now ...
> >>
> >> I quickly prepared two patches to change that, so that topic is out of
> >> the way. But I did only compile-test them on OMAP - could you check on
> >> your Davinci platform? Note that these apply on top of the patch in
> >> discussion here (which isn't applied to the asoc tree yet).
> > 
> > I put a series together yesterday, just ran out of time to post
> > last night after testing. I'm posting that now...it's on top of my
> > uio_pruss/genalloc series and only addresss switching davinci-pcm to
> > genalloc (and actually enabling ping-pon from sram).
> 
> Ok, I don't care which version makes it in after all :)

Ok :)

> > I'll take a look a your OMAP patches.
> 
> The patches I just sent out are only for Davinci and change the SRAM
> functions to genalloc in the mcasp driver. They work just fine on OMAP
> of course, as the code is disabled in there.

Ok, same thing as I did and just sent out. These are tested on AM180x
and hook up ping-pong buffering so that there's actually one user of
all this ping-pong code. It's been sitting idle for a long time.

I didn't see your patches come by yet but will take a look to see if
we need to combine.

-Matt
