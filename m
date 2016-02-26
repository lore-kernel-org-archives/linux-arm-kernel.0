From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Feb 2016 22:04:15 +0100
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <20160226023021.GH18327@sirena.org.uk> (Mark Brown's message of
 "Fri, 26 Feb 2016 11:30:21 +0900")
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk> <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk> <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk> <878u2fxbp9.fsf@belgarion.home>
 <20160221014920.GK18327@sirena.org.uk> <87povkuuf6.fsf@belgarion.home>
 <20160226023021.GH18327@sirena.org.uk>
Message-ID: <87k2lruqsw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Fri, Feb 26, 2016 at 02:33:49AM +0100, Robert Jarzmik wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > It will not be called, the generic AC'97 code will be used.
>
>> Ok, if it's not called no code in sound/soc/codecs/wm9713.c will be used, right
>> ?
>> In that case wm9713_set_dai_clkdiv() will never be used, nor will the
>> wm9713_audio_map or wm9713_dapm_widgets be created, which will break all
>> userspace programs relying on these mixers and DAPM routes.
>
>> Or am I missing something ?
>
> No, you're not missing anything - that'll be what happens.  If you need
> to preserve the userspace ABI on your board you'd need a much bigger
> (but very welcome) refactoring of the AC'97 code to be less hacky and
> use the device model more directly, or at least define a generic AC'97
> binding somehow.  All the AC'97 support has never really been properly
> moved over to the device model and unfortunately nobody's yet cared
> about it for device tree except in the simple cases supported by the
> generic AC'97 code.  I appreciate that this isn't very helpful, it's
> an unfortunate consequence of DT as an ABI.
>
> We probably want to end up with something like what the Intel folks have
> been doing recently for HDA to get that working within ASoC.

Ok, let me think about it and propose something, an approach.

I must admit I like the structure I saw in drivers/amba/bus.c, ie. to have
something like :
 - a bus driver core (sound/ac97/bus.c ?)
   Split between this and sound/pci/ac97_codec.c I don't know yet.
   => an instance of this bus will be instanciated from each snd_ac97_bus() call
      just as now
   => bus_register(&ac97_bustype)
   => ac97_bus_probe/remove(), match/uevent/dev_attrs
   => ac97_driver_register(struct ac97_driver *drv)

 - a ac97 driver structure (struct ac97_driver) with :
   => u32 vendor_id (vendor_id = lambda(vendor_id1, vendor_id2))
   => u32 vendor_id_mask (mask of bits to match)
   ...

 - each ac97 controller will call snd_ac97_bus().
   In my case, that's sound/arm/pxa2xx-ac97.c or sound/soc/pxa2xx-ac97.c,
   whatever.

 - each ac97 codec will subscribe to the bus
   ac97_driver_register(struct ac97_driver *drv, u32 vendor_id, u32 vendor_mask)
   For example wm9713.c will call :
     ac97_driver_register(drv, AC97_VENDOR(0x...., 0x....), 0xffffffff);

Well, if I'm totally mistaken, tell me. If not it will take me a bit of time to
write is down properly in a Documentation/ file.

Cheers.

-- 
Robert
