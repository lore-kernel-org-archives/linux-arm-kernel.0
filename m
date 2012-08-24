From: ola.o.lilja@stericsson.com (Ola Lilja)
Date: Fri, 24 Aug 2012 15:05:17 +0200
Subject: FW: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe
 rather than as a device
In-Reply-To: <014401cd8165$99960c40$ccc224c0$@se>
References: <014401cd8165$99960c40$ccc224c0$@se>
Message-ID: <50377C0D.2060905@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 09:29 PM, Ola Lilja wrote:

> 
> 
>> -----Original Message-----
>> From: Lee Jones [mailto:lee.jones at linaro.org]
>> Sent: den 23 augusti 2012 16:59
>> To: Mark Brown
>> Cc: Ola Lilja; 'Linus Walleij'; roger.xr.nilsson at stericsson.com; linux-
>> arm-kernel at lists.infradead.org; alsa-devel at alsa-project.org
>> Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe
>> rather than as a device
>> 
>> On Thu, Aug 23, 2012 at 03:37:57PM +0100, Mark Brown wrote:
>> > On Thu, Aug 23, 2012 at 02:26:19PM +0100, Lee Jones wrote:
>> >
>> > > > I think Ola is suggesting probing the DMA driver from the machine
>> > > > which will also work though I'm not 100% sure if I'm parsing the
>> > > > above correctly.  The issue in DT terms is that if the DMA
>> > > > controller is shared with a bunch of other IPs then it should
>> have
>> > > > one node shared between them all and not a bunch of shim nodes
>> > > > inserted in the middle which only exists due to the way Linux
>> instantiates stuff.


I haven't followed everything in this discussion, but what I meant in an earlier
mail was that using the device for platform-DAI (MSP_I2S) also
as platform int the DAI-link struct is not anything I can see fit (as in the
patch Lee first submitted).
I can see a few acceptable solutions:
1) Use it as it is! (A virtual device for PCM is created in arch/arm and the
probe is invoked from the machine-driver).
2) Since the actual platform is the DMA-block, maybe there is some way of making
the device "non-virtual" by having some sub-device in the DMA-driver that is
instead triggered in the same way as in 1).
3) Move it to DT, but it seems that it is not possible when it is now a virtual
device.

Any of these three would be fine with me.

>> >
>> > > When you say 'machine', do you mean from arch/<arch>/mach-*? If so,
>> > > I'm keen for that not to happen.
>> >
>> > No, sound/soc/ux500/snowball.c or whatever.  At least that's my
>> guess.
>> 
>> Ah, I see. Maybe the mop500.c file then.
>> 
>> > > > They instantiate the PCM driver dynamically from the DAI when
>> it's
>> > > > probed which is pretty much what you're patch is doing.
>> >
>> > > So they do it in the same why I have with this patch? Do you know
>> > > why Ola might think this is a bad idea?
>> >
>> > I'm not 100% sure, I'm guessing it might be down to the fact that you
>> > end up with multiple PCM drivers.  We could avoid that with
>> > refcounting but nobody's really worried about it.
>> 
>> I think I'll wait for Ola to get back, as he's the expert on this
>> stuff.
>> 
>> I'll attempt to re-jig the patch-set, as this is a blocker atm.
>> 
>> --
>> Lee Jones
>> Linaro ST-Ericsson Landing Team Lead
>> Linaro.org ? Open source software for ARM SoCs Follow Linaro: Facebook
>> | Twitter | Blog
> 
