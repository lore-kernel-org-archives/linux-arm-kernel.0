From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jul 2013 22:23:50 +0100
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718211521.GX22506@sirena.org.uk>
References: <20130718134330.5aea00c5@skate>
 <20130718142009.GX24642@n2100.arm.linux.org.uk>
 <20130718173727.2cfa38d3@skate> <20130718210637.GW22506@sirena.org.uk>
 <20130718211521.GX22506@sirena.org.uk>
Message-ID: <20130718212350.GC24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:15:21PM +0100, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 10:06:37PM +0100, Mark Brown wrote:
> 
> > All those "Off" things mean that things are powered off which tends not
> > to involve them making any noise...  Russell mentioned that he thought
> > this was a lack of DAPM stuff however looking here it seems there are
> > some DAPM widgets on your board?
> 
> And now I think about it further the fix here is essentially that we
> require DAPM on any device that wants power management these days - DAIs
> are now widget based so it's going to be much more sensible to just go
> through and add the relevant output pins to relevant legacy drivers.
> 
> This means that for uda134x (which I think is what you're using here, I

No, this report is against ALC5623, which does appear to have widgets.
I was remarking that this looks like the same kind of issue I had with
UDA134x.

Note that the report indicates that the bias setting remains off while
playing, and ALC5623 does this:

        case SND_SOC_BIAS_OFF:
                /* everything off, dac mute, inactive */
                snd_soc_write(codec, ALC5623_PWR_MANAG_ADD2, 0);
                snd_soc_write(codec, ALC5623_PWR_MANAG_ADD3, 0);
                snd_soc_write(codec, ALC5623_PWR_MANAG_ADD1, 0);

So if everything on the codec is powered down, it's not surprising that
there is no audio output.
