From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 12 May 2016 11:10:20 +0530
Subject: [PATCH 04/18] dmaengine: st_fdma: Add xp70 firmware loading
 mechanism.
In-Reply-To: <20160511075740.GB25540@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-5-git-send-email-peter.griffin@linaro.org>
 <20160426170048.GS2274@localhost>
 <20160511075740.GB25540@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20160512054020.GW2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 08:57:40AM +0100, Peter Griffin wrote:
> > Above two seem to be generic code and should be moved to core, this way
> > other drivers using ELF firmware binaries can reuse...
> 
> Do you mean add to dmaengine.c?

Nope this is not specfic to dmaengine. Perhaps drivers/base/..

> Certainly st_fdma_elf_sanity_check is fairly generic. st_fdma_elf_load_segments
> is less so, especially st_fdma_seg_to_mem().
> 
> > 
> > > @@ -738,6 +925,15 @@ static int st_fdma_slave_config(struct dma_chan *chan,
> > >  				struct dma_slave_config *slave_cfg)
> > >  {
> > >  	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> > > +	int ret;
> > > +
> > > +	if (!atomic_read(&fchan->fdev->fw_loaded)) {
> > > +		ret = st_fdma_get_fw(fchan->fdev);
> > 
> > this seems quite an odd place to load firmware, can you explain why
> > 
> 
> Good question :) I've been round the houses a bit on the firmware loading.
> 
> I will try and document here what I've tried and the different advantages /
> disadvantages I've encountered.

Per Linus, driver should load firmware on first open. So either you should
do it while channel allocation or first descriptor allocation.

> 
> In V3 patches, I used the device_config() hook. This can sleep (I think..it isn't
> documented here [1]). This hook happens very close to the dma starting and the
> rootfs / firmware is likely to be present. However I've sinced learnt that it
> doesn't get  called in the memcpy case so is not a sufficient solution.
> 
> In part putting it here was to try and get firmware loading out of probe() based
> on your feedback to v1 [2].
> 
> In V1 patches: - I was using request_firmware_nowait() in probe() in conjunction with
> the CONFIG_FW_LOADER_USER_HELPER kernel option. I've since also learnt that this
> kernel option is deprecated and shouldn't be used.

I think nowait version is better. Why do you need
CONFIG_FW_LOADER_USER_HELPER?

> Your feedback in v1 was to move firmware loading to device open [2]. However
> what classes is  device open in the dmaengine context is not obvious.

channel allocation or descriptor allocation

> 
> ===
> 
> device_alloc_chan_resources() hook
> 
> This is probably the hook closest to a device open in dmaengine context.
> This hook can sleep so request_firmware can be called. However if all drivers
> are built-in firmware loading still fails as ALSA drivers calls
> devm_snd_dmaengine_pcm_register() which requests dma channels during *its* probe().
> This happens way before the rootfs is present and thus firmware loading still
> fails, and is still being done indirectly from a probe() anyway.
> 
> I had some discussion with Mark and Arnd on IRC, about the possibility of ALSA
> not rquesting DMA channels during their probe(). Marks opinion I believe was
> this wasn't a good solution as ALSA would be presenting devices to userspace 
> that potentially don't exist & can't work.

Hmmm, there are two parts, one is requesting the firmware and second is the
loading part.

Since descriptor allocation is atomic in nature, I think we should load the
firmware using nowait version and if you can atomically copy then do so at
first descriptor allocation. If not then you should copy in nowait handler

> ===
> 
> *_prep_*() hooks
> 
> + Always get called before a DMA is started
> 
> - *prep* hooks can be called from atomic context so can't sleep [1] and can't use
>   request_firmware().
> - I tried using request_firmwqare_nowait() with GFP_ATOMIC flag firmware. This
>   half works but firmware loading doesn't complete before the DMA is started which
>   means it often fails on the first DMA attempt.
> 
>  ===
> 
> Suggested solution for v4 patches: -
> 
> Both Arnd, Mark and Lee initial suggestion on irc was that if the device is useless
> without firmware, and the firmware isn't available then the driver should call
> request_firmware() in probe() and -EPROBE_DEFER if not available.
> 
> This solution works well, in both the built-in and modules case. As the deffered
> fdma driver re-probes after the rootfs has been mounted when the firmware is
> available. The other ALSA depedencies then also re-probe and everything works
> nicely (and you can be assured that the devices will actually work at this point).
> 
> This fdma driver and the ALSA ones will be enabled in multi_v7_defconfig as modules,
> so it is only likely to be used as a module. However using -EPROBE_DEFER
> mechanism, has the nice quality that if it is compiled as built-in you still end
> up with a working system (albeit with a longer boot time).

I think that makes sense, relying on deferred probing seems a better way to
manage

> 
> Failing that the only other solution I can see is extending the dmaengine API to
> provide another hook which can sleep, and must be called before a DMA
> transation is started. Note that firmware isn't actually *required* until we
> start the dma transaction, but the device is useless without this firmware. In fact
> its "registers" are really just offsets into its DMEM so in theory even the
> registers are totally firmware dependent.
> 
> Also I notice the only other dmaengine driver imx-sdma.c using firmware calls
> request_firmware_nowait from its probe().
> 
> Are you happy with my proposed solutiion for v4? If not how would you like me to
> implement this?
> 
> regards,
> 
> Peter.
> 
> [1] https://www.kernel.org/doc/Documentation/dmaengine/provider.txt
> 
> [2] https://lkml.org/lkml/2015/10/13/278
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
