From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 09:29:30 +0200
Subject: [PATCH 14/15] ARM: pxa: change SSP devices allocation
In-Reply-To: <87zi2i2ljy.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr>
 <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
 <87lge4485x.fsf@belgarion.home>
 <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
 <87zi2i2ljy.fsf@belgarion.home>
Message-ID: <CAK8P3a0xJnVfXfUtP+JXGNgc2-LuHUmZCMq-SnEQw3wu3azemA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 8:51 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> I'm still unable to follow through that code, but I understand now that
>> the device you pass to dma_request_slave_channel() is not the one
>> we'd like it to be here.
>>
>> Where exactly does that call to dma_request_chan() happen? Is this
>> the one in dmaengine_pcm_new()? Could we perhaps put a
>> pointer to the SSP device into snd_dmaengine_dai_dma_data?
> This is a sample stack I captured with an added WARN_ON(1), triggered by a
> userland "aplay Sultans_Of_Swing.wav" :)
>
> [  299.216743] [<c0012e80>] (unwind_backtrace) from [<c000f55c>] (show_stack+0x20/0x24)
> [  299.223986] [<c000f55c>] (show_stack) from [<c0529d68>] (dump_stack+0x20/0x28)
> [  299.231321] [<c0529d68>] (dump_stack) from [<c001de34>] (__warn+0xf0/0x11c)
> [  299.238183] [<c001de34>] (__warn) from [<c001df94>] (warn_slowpath_null+0x4c/0x58)
> [  299.245234] [<c001df94>] (warn_slowpath_null) from [<c02a2d38>] (dma_request_chan+0x40/0x228)
> [  299.252550] [<c02a2d38>] (dma_request_chan) from [<c02a2f38>] (dma_request_slave_channel+0x18/0x24)
> [  299.259855] [<c02a2f38>] (dma_request_slave_channel) from [<c03f76f0>] (__pxa2xx_pcm_open+0xf4/0x110)
> [  299.266789] [<c03f76f0>] (__pxa2xx_pcm_open) from [<c0409ed0>] (soc_pcm_open+0xf8/0x9c8)
> [  299.273932] [<c0409ed0>] (soc_pcm_open) from [<c03db9d4>] (snd_pcm_open_substream+0x9c/0x134)

Ok, so it seems we currently have a special case here that is only used by
pxa/mmp and omap, and you can simply open-code that by calling
dma_request_chan() from the pxa-specific __pxa2xx_pcm_open()
with any device pointer you like, it doesn't have to be the main audio
device.

I don't know exactly how the probing works, but I'd assume that we have
the correct device pointers in pxa2xx_ac97_dev_probe() and
asoc_ssp_probe(), or maybe in pxa2xx_ac97_*_startup() and
pxa_ssp_startup().

      Arnd
