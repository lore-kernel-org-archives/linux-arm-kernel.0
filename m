From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Mar 2015 20:39:11 +0100
Subject: [RFC 0/11] dw_hdmi cleanups, audio preparation, helpers and ahb
 audio support
Message-ID: <20150330193911.GM24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm sending this series for comments, and to allow people to update
their code bases (for those who are using my AHB audio driver on
iMX6).  This is really several series, and I'm not expecting this
to be ready for the upcoming merge window.  That said, if anyone
wants to say that they're happy with some of the initial four patches,
I'm happy to queue those for David, if he's willing to take them.

This series applies on top of my previous series, which finished with
the patch "drm: bridge/dw_hdmi: adjust n/cts setting order".

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
 drivers/gpu/drm/bridge/dw_hdmi.c           | 250 ++++++++-----
 drivers/gpu/drm/bridge/dw_hdmi.h           |   3 +
 include/drm/bridge/dw_hdmi.h               |   7 +
 include/drm/drm_edid.h                     |  19 +
 include/sound/pcm_drm_eld.h                |   6 +
 include/sound/pcm_iec958.h                 |   9 +
 sound/core/Kconfig                         |   6 +
 sound/core/Makefile                        |   3 +
 sound/core/pcm_drm_eld.c                   |  91 +++++
 sound/core/pcm_iec958.c                    |  70 ++++
 14 files changed, 964 insertions(+), 92 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
