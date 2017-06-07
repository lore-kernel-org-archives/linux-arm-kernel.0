From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Wed,  7 Jun 2017 09:27:17 +0200
Subject: [PATCH v10] sun4i-codec: Add Line-In, FM-In, Mic 2, Capture Source,
 Differential Line-In
Message-ID: <20170607072718.18017-1-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for some mixer controls to sun4i-codec:
 - Line-In
 - FM-In
 - Mic 2
 - Capture Source
 - Differential Line-In

It also adds a mux for the capture source and the PGA for the MIC2 preamp.

Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
of distinct controls in alsamixer.

v10 changes compared to v9 are:
 - Use SOC_DAPM_DOUBLE where possible and it makes sense in order to cut
   down on the number of controls.

v9 changes compared to v8 are:
 - added Line Differential Capture Switch.
 - split Capture Source into Left Capture Select, Right Capture Select.
 - added Line Capture Volume.
 - rename "sun4i_codec_widgets" to "sun4i_codec_controls" for 
   consistency with the struct field it's used in.
 - rename "Line-In" to "Line".
 - rename "Power Amplifier Playback Volume" to "Headphone Playback Volume".

v8 changes compared to v7 are:
 - fixed the routes for line and mic capturing.

v7 changes compared to v6 are:
 - preparation for different A20, A10 controls is now in an extra patch.
 - all register definitions are now at the top.
 - sun7i-specific things (A20-specific things) are now less grouped-together.
 - rename "Power Amplifier Volume" to "Power Amplifier Playback Volume".

v6 changes compared to v5 are:
 - Mic preamplifier special cases for A20 and A10 now are now not icky:
   There are two different _widget arrays and the probe() function now 
   selects the right one to pass to snd_soc_register_codec() unmodified.
 - sun7i-specific things (A20-specific things) are now grouped together.

v5 changes compared to v4 are:
 - Mic preamplifier controls have more common names now.
 - Mic preamplifier scale has a 0 dB entry as well now, as documented in the 
   A20 user manual.
 - Mic preamplifier has special cases for A20 and A10 now.
 - Gain controls have "Gain" in the name now.

v4 changes compared to v3 are:
 - names of the input are not uppercase anymore.
 - bit index constants are now named as in the A20 user manual v1.4.
 - added Mic1-In, Mac2-In.
 - added Mic1 and Mic2 Pre-Amplifiers.

v3 changes compared to v2 are:
 - added DAPM routes.

v2 changes compared to v1 are:
 - moved Line-In and FM-In playback switches to their respective 
   sun4i_codec_*_mixer_controls.

v1 changes:
 - added linein, fmin output volumes and switches.

Danny Milosavljevic (1):
  sun4i-codec: Add mixer controls: Line-In, FM-In, Mic  2, Capture
    Source, Differential Line-In.

 sound/soc/sunxi/sun4i-codec.c | 296 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 269 insertions(+), 27 deletions(-)

-- 
2.1.4
