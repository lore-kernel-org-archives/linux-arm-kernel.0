From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 22:15:21 +0100
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718210637.GW22506@sirena.org.uk>
References: <20130718134330.5aea00c5@skate>
 <20130718142009.GX24642@n2100.arm.linux.org.uk>
 <20130718173727.2cfa38d3@skate>
 <20130718210637.GW22506@sirena.org.uk>
Message-ID: <20130718211521.GX22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:06:37PM +0100, Mark Brown wrote:

> All those "Off" things mean that things are powered off which tends not
> to involve them making any noise...  Russell mentioned that he thought
> this was a lack of DAPM stuff however looking here it seems there are
> some DAPM widgets on your board?

And now I think about it further the fix here is essentially that we
require DAPM on any device that wants power management these days - DAIs
are now widget based so it's going to be much more sensible to just go
through and add the relevant output pins to relevant legacy drivers.

This means that for uda134x (which I think is what you're using here, I
have no context but that's what Russell mentioned?) someone needs to add
widgets corresponding to the names for the inputs and outputs (just make
up a name if there's just one of each and no datasheet) then link them
with some DAPM routes:

	{ "OUTPUT", NULL, "Playback" },
	{ "Capture", NULL, "INPUT" },

where INPUT and OUTPUT are the names of an input or output pin on the
device defined as DAPM widgets:

	SND_SOC_DAPM_INPUT("INPUT"),
	SND_SOC_DAPM_OUTPUT("OUTPUT"),

which I think is what Russell did.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/a6f5a8aa/attachment-0001.sig>
