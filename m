From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 05 May 2016 21:06:44 +0200
Subject: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
In-Reply-To: <20160504090702.GV6292@sirena.org.uk> (Mark Brown's message of
 "Wed, 4 May 2016 10:07:02 +0100")
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk> <87y47roski.fsf@belgarion.home>
 <20160504090702.GV6292@sirena.org.uk>
Message-ID: <87pot0pbnf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Tue, May 03, 2016 at 09:22:05PM +0200, Robert Jarzmik wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:
>
>> >> Split out from the ac97_codec.h the ac97 generic registers, which can be
>> >> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
>> >> scan an ac97 AC-Link.
>
>> > I don't entirely see the value in this one but equally it does no harm.
>
>> Oh that's to have the defines AC97_VENDOR_ID1 and AC97_VENDOR_ID2, but without
>> including ac97_codec.h in sound/ac97/bus.c.
>
> I see that, I just don't know why that helps.
Ok, so let me explain.

As you already understood, AC97_VENDOR* is needed in bus.c for the
autoscanning. The remaining is the reason why I don't want to include
ac97_codec.h in bus.c, which follows.

In order to have a clean split between former ac97 bus implementation and this
new one, I didn't want to include any former ac97 includes, excepting in
sound/ac97/compat.c.

Amongst the thing I wanted to isolate :
 - didn't want the struct snd_ac97 in sound/ac97/* (except compat.c) to see not
   be "fooled" by a definition which would come with ac97_codec.h by "chance".
 - didn't want to have snd_a97_*() functions, as they rely on struct snd_ac97.
 - didn't want the struct snd_ac97_bus_ops, there is a new one
   => the main grudge I have is the void (*write)() and unsigned short (*read)()
   prototype which prevent from returning error codes such as -EIO, etc ...

Moreover, to have a smooth transition, my plan is :
 - have this new ac97 bus
 - provide any needed function in compat.c so that previous codecs, regmap,
   ... continue to work
 - port the ac97 "pci" codec to have a generic ac97 codec so that codecs can be
   shrinked from common ac97 code.
 - port the codecs ... several monthes of work, etc ...
 - once the port is done, remove compat.c

This transition will be easier if the new ac97 code is isolated as much as
possible from the former code while providing backward compatibility ... hence
this patch.

Cheers.

-- 
Robert
