From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 03 May 2016 21:43:20 +0200
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <20160503162938.GT6292@sirena.org.uk> (Mark Brown's message of
 "Tue, 3 May 2016 17:29:38 +0100")
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <20160503162938.GT6292@sirena.org.uk>
Message-ID: <87twiforl3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Apr 30, 2016 at 11:15:34PM +0200, Robert Jarzmik wrote:
>> AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link one
>> controller to 0 to 4 AC97 codecs.
>
>> The goal of this new implementation is to implement a device/driver
>> model for AC97, with an automatic scan of the bus and automatic
>> discovery of AC97 codec devices.
>
> I think this is basically what I was thinking of, yes.  One thing we'll
> need to do is work out how to handle systems that need some explicit
> action to start clocks for the bus clock, though they were never very
> common and it's entirely possible nobody cares any more so perhaps we
> just punt and see if anyone notices for now.
You probably mean the BITCLK clock.

What is a bit pesky about this clock is that it can either be mastered by
digital controller and the codec is a slave, or the other way around.

So we had either the BITCLK provided by :
 - the controller
   => this could be passed in ac97_digital_controller_register()
 - the codec
   => this is trouble, I don't really know how to handle this case

If the bus code has this clock, it can indeed prepare and enable it.

>> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
>> +				     struct device *dev);
>> +int ac97_digital_controller_unregister(const struct device *dev);
>
> Why "digital"?
I copy-pasted this from Audio Codec '97 Revision 2.3, where in several places
they call the controller a "digital controller".

Quoting chapter 1.4:
    The digital link that connects the AC ?97 Digital Controller to the AC ?97
    Codec, referred to as AC-link, is a bi- directional, 5-wire, serial time
    domain multiplexed (TDM) format interface. AC-link supports connections
    between a single Controller and up to 4 CODECs on a circuit board and/or
    riser card.

Now if you prefer "ac97_controller" or something like that, that's as you wish,
the name does not matter that much to me ;)

Cheers.

-- 
Robert
