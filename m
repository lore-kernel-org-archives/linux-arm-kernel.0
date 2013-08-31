From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 13:34:59 +0100
Subject: [PATCH 00/14] SPDIF support
Message-ID: <20130831123458.GF6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is my latest set of patches to get SPDIF working on the Dove Cubox
platform.  As per the last time, I've left out the "card" part of this,
because that is only useful for non-DT setups, which aren't supported in
mainline.

The first seven patches have already been applied by Mark, and are
included here for completeness by anyone who wishes to test this series.

There is very little change between this and the previous set of patches.

The HACK patch is gone, as I've found out through much digging and
experimentation with DAPM (inspite of the complete lack of assistance
from ASoC developers) how to use the stream widgets without the widget
overwriting bug getting in the way.

The CPU DAI widgets are attached to the CPU DAI context, and their
access to the driver private data updated accordingly.  Why attaching
them to the CPU DAI context previously didn't work, I'm not entirely
sure, but that certainly previously failed in testing (it may have been
due to the duplicated DAI routes and/or the lack of output pin on the
SPDIF tranceiver.)

I've added three patches: one to add IEC958 channel status setting,
another to prefer the external clock over the internal clock, and
removal of the IEC958 subframe support (see the commit message for
that patch why this can not be supported.)

This is a non-DPCM driver, and is the absolute minimum solution which
can provide correct hardware behaviour while still being conformant
with single zImage kernels and not causing any known regressions.

The same conditions apply as per my previous posting - the DAI link
needs to be setup and the associated DAPM routes to tell the CPU DAI
which outputs are in use, like this:

DAI link:
                .name = "S/PDIF1",
                .stream_name = "IEC958 Playback",
                .platform_name = "mvebu-audio.1",
                .cpu_dai_name = "mvebu-audio.1",
                .codec_dai_name = "dit-hifi",
                .codec_name = "spdif-dit",

static const struct snd_soc_dapm_route routes[] = {
        { "Playback", NULL, "spdifdo" },
};

When DPCM is eventually implemented, the DAPM route remains, the DAI link
becomes two, as previously illustrated in other discussions.

Full diffstat for this series:

 arch/arm/mach-dove/common.c          |    4 +-
 arch/arm/mach-kirkwood/common.c      |   24 ++---
 sound/soc/codecs/spdif_transciever.c |   15 +++-
 sound/soc/kirkwood/Kconfig           |    5 -
 sound/soc/kirkwood/Makefile          |    4 +-
 sound/soc/kirkwood/kirkwood-dma.c    |  114 ++++--------------
 sound/soc/kirkwood/kirkwood-i2s.c    |  213 +++++++++++++++++++++++++++++-----
 sound/soc/kirkwood/kirkwood-openrd.c |   12 ++-
 sound/soc/kirkwood/kirkwood-t5325.c  |    8 +-
 sound/soc/kirkwood/kirkwood.h        |   45 +++++++-
 sound/soc/soc-dapm.c                 |    2 +-
 11 files changed, 295 insertions(+), 151 deletions(-)

Diffstat for the patches remaining for mainline:

 sound/soc/kirkwood/kirkwood-dma.c    |    4 +-
 sound/soc/kirkwood/kirkwood-i2s.c    |  170 +++++++++++++++++++++++++++++++---
 sound/soc/kirkwood/kirkwood-openrd.c |    8 ++
 sound/soc/kirkwood/kirkwood-t5325.c  |    4 +
 sound/soc/kirkwood/kirkwood.h        |   34 +++++++
 5 files changed, 205 insertions(+), 15 deletions(-)
