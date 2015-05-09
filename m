From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 11:25:01 +0100
Subject: [PATCH v3 0/13] dw_hdmi cleanups, audio preparation, helpers and ahb
 audio support
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Message-ID: <20150509102501.GO2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm sending this series again for comments, and to allow people to
update their code bases (for those who are using my AHB audio driver
on iMX6).

There have been very few changes from the previous posting, the
exception being the ELD helper in patch 10, which should be correctly
sorted now.

I would like to:
* queue the first six patches for David, so I'm asking for acks for these
* obtain agreement with the Rockchip guys on patches 7 and 8
* queue patches 9 to 11 inclusive as well (as these are cross-subsystem,
  I think we need to discuss how they are to be handled - there is other
  work in the pipelines from others depending on these changes.)  So acks
  for these would be nice too.

Here's the summary of the patches, same as last time:

The first four patches are a few cleanups to the dw_hdmi driver.

The next two patches introduce new interfaces to the dw_hdmi driver
to support AHB audio, including the errata found on iMX6 which
requires N to be programmed to zero when the audio FIFO is not full.
I'm expecting some discussion with these last two as we try to work
out how to deal with the two variants of audio support for this part
(AHB audio vs I2S audio).

The following three add various helpers to the DRM and ALSA subsystems
for audio support which is non-specific to the AHB audio driver.  For
DRM, this is a helper macro to obtain the pointer into the short audio
descriptors.  For ALSA, it's a set of helpers to restrict an audio PCM
device's capabilities according to the ELD, and to generate the IEC958
channel status data.  If these helpers are acceptable, we can convert
a number of drivers to them.

The ELD helper isn't quite finished, but should be sufficient for
initial testing.

The last two patches add support for the dw_hdmi audio.  This is an
ALSA driver rather than an ASoC driver as it's a pretty simple affair.
I couldn't find a suitable location in the sound/ subtree to place it,
so I've placed it next to the bridge - yes, we probably need to find
it a better home in the sound/ subtree, but it currently makes
use of dw_hdmi.h in the directory it lives.

 drivers/gpu/drm/bridge/Kconfig             |  11 +
 drivers/gpu/drm/bridge/Makefile            |   1 +
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 566 +++++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h |  14 +
 drivers/gpu/drm/bridge/dw_hdmi.c           | 321 +++++++++-------
 drivers/gpu/drm/bridge/dw_hdmi.h           |   3 +
 drivers/gpu/drm/imx/dw_hdmi-imx.c          |   5 +
 include/drm/bridge/dw_hdmi.h               |   7 +
 include/drm/drm_edid.h                     |  19 +
 include/sound/pcm_drm_eld.h                |   6 +
 include/sound/pcm_iec958.h                 |   9 +
 sound/core/Kconfig                         |   6 +
 sound/core/Makefile                        |   2 +
 sound/core/pcm_drm_eld.c                   |  99 +++++
 sound/core/pcm_iec958.c                    |  95 +++++
 15 files changed, 1036 insertions(+), 128 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
