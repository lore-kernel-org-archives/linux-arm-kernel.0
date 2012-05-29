From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 29 May 2012 13:14:43 +0800
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120525094231.GC24149@n2100.arm.linux.org.uk>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
Message-ID: <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 5:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 25, 2012 at 04:47:20PM +0800, zhangfei gao wrote:
>> Do you mean at open time, like snd_dmaengine_pcm_open.
>> The channel resource is limited and better get dynamically.
>> As a ?result the pcm_new and preallocate already called before.
>
> This is where dealing with slave DMA channels in a virtualized setup
> becomes a far better solution than trying to assign a particular
> physical channel at request time.
>
> What we may wish to think about is having a way for slave drivers to
> assert to DMA engine the priority of a channel, which they can change
> dynamically according to what they're doing. ?Eg, an ALSA driver would
> leave the channel low priority while it's not expecting to be used, but
> as soon as we see the prepare call, set it to high priority.
>
> The DMA engine driver could use that to decide to assign a physical
> channel to the virtual channel, so that DMA can start as soon as
> possible even with other activity on the DMA engine.
>
> However, I've yet to see any setup where the number of physical DMA
> channels available exceeds the number of actual _simultaneous_ users.
> Even with the five channels on SA11x0 shared between 12? peripherals,
> with my DMA engine driver I've only seen one or two physical channels
> being used simultaneously.
>

When debugging with putting snd_dmaengine_pcm_open to probe or
pcm_new, there is issue.
snd_dmaengine_pcm_open ->
snd_pcm_hw_constraint_integer(substream->runtime,
                                            SNDRV_PCM_HW_PARAM_PERIODS);
The runtime is only exist at runtime.
So if using soc-dmaengine, I am afraid the snd_dmaengine_pcm_open has
to be put in open instead of probe.

Thanks
