From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Aug 2013 20:21:37 +0100
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
Message-ID: <20130804192136.GK23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only a RFC at present due to the need to test on Kirkwood and
fix at least one bug in ASoC core code.

I can't say that this stuff is fully tested, because I don't have any
Kirkwood platforms, but I do have one Dove platform, which as I've
said in the past doesn't run mainline.  I don't run DT on it, so these
patches also don't contain anything DT related.

However, this patch set is aimed at sorting out the SPDIF on Dove and
Kirkwood, which the Dove-based Cubox uses.

The first patch in the series I've already sent, and I think Mark may
have already picked up.  The second is my implementation of what I
think Mark committed to use the devm_* APIs for the external clock.

Patches 3 and 4 fix problems which I've found with the ASoC core code,
which prevent these patches from working correctly.  Patch 3 I've
already discussed with Mark over the weekend, and I think that's
pretty much settled, but patch 4 is a definite hack.

Patch 4 addresses an issue where we end up registering the CPU DAIs
stream widgets twice - once against the codec DAPM context and again
against the platform DAPM context.  When these are registered, pointers
to these widgets are saved into the CPU DAI structure, so one set of
these widgets gets overwritten by the other set.  The set which wins
(normally the ones in the CPU DAPM context) ends up being the set
which are made active.  However, the platform ones remain on the DAI
list, and these can end up being bound to by routes.  ASoC people
need to fix this problem as a pre-requisit to the following patches
working.

Patches 5 and 6 are just cleanups - I decided it was easier to do my
own version of merging the I2S and DMA files rather than using Jean-F's
patch (sorry, I just wanted something that worked...)

Patch 7 is based on some changes in Rabeeh's kernel - I will have a
following patch at some point to adjust these parameters to something
a little saner.  This just gets mainline closer to the tree which I
can test.

Patch 8 adds the I2S widgets to kirkwood-i2s and uses them.  With this
patch applied, kirkwood-i2s will be silent unless at least one of the
output widgets is "powered up" - in the case of this patch, that's the
"i2sdo" widget - naming following what's in the functional spec.

Patch 9 and 10 add the DAPM routes to connect the I2S inputs/outputs
to the codec streams, restoring audio output on these platforms.  As
I don't have these platforms, this should be tested by someone who has.

Patch 11, again, discussed with Mark, this adds an always enabled output
pin for the SPDIF transceiver, so that the output is powered up by DAPM.
Without this, the SPDIF output stream goes into "active" mode during
playback, but is never powered up.  This results in any connected
source widgets also not being powered up.

Patch 12 adds the SPDIF output widget to kirkwood-i2s, called "spdifdo",
again a name derived from the functional spec.  The actual pin is called
"AU_SPDIFDO".

Patch 13 adds the IEC958 channel status data to patch 12, allowing the
channel status to be set by applications using an appropriate ALSA
library configuration file via the standard methods.

What I haven't included is the board file (like the openrd and t5325
ones already present) for SPDIF support on Dove, as that's based on the
pre-DT setups, and I'm not sure anyone in mainline is interested in
that.  So the above provides the components necessary, hopefully someone
with ASoC & DT knowledge can bind these components together via
appropriate DT bindings.  For reference, the DAI link looks like this:

                .name = "S/PDIF1",
                .stream_name = "IEC958 Playback",
                .platform_name = "mvebu-audio.1",
                .cpu_dai_name = "mvebu-audio.1",
                .codec_dai_name = "dit-hifi",
                .codec_name = "spdif-dit",

and the required route:

static const struct snd_soc_dapm_route routes[] = {
        { "Playback", NULL, "spdifdo" },
};
