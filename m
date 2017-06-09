From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Jun 2017 15:14:39 +0800
Subject: [PATCH v11 00/12] sun4i-codec: Add Line-In, FM-In, Mic 2, Capture
 Source, Differential Line-In
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <CAGb2v64SRQ43_3U_tRhz8FN9SsZuMC7k5pFw02dSxAUxd1-nug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 9, 2017 at 2:22 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> This patchset adds some mixer controls to sun4i-codec.
>
> It also adds a mux for the capture source and the PGA for the MIC2 preamp.
>
> Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
> of distinct controls in alsamixer.
>
> v11 changes compared to v10 are:
>  - Split up patchset.
>  - Fixed typo in Differential Line Capture Switch.
>  - Renamed "Non-Differential" value to "Stereo".
>  - Removed duplicate PA Volume mixer control.
>
> v10 changes compared to v9 are:
>  - Use SOC_DAPM_DOUBLE where possible and it makes sense in order to cut
>    down on the number of controls.
>
> v9 changes compared to v8 are:
>  - added Line Differential Capture Switch.
>  - split Capture Source into Left Capture Select, Right Capture Select.
>  - added Line Capture Volume.
>  - rename "sun4i_codec_widgets" to "sun4i_codec_controls" for
>    consistency with the struct field it's used in.
>  - rename "Line-In" to "Line".
>  - rename "Power Amplifier Playback Volume" to "Headphone Playback Volume".
>
> v8 changes compared to v7 are:
>  - fixed the routes for line and mic capturing.
>
> v7 changes compared to v6 are:
>  - preparation for different A20, A10 controls is now in an extra patch.
>  - all register definitions are now at the top.
>  - sun7i-specific things (A20-specific things) are now less
>    grouped-together.
>  - rename "Power Amplifier Volume" to "Power Amplifier Playback Volume".
>
> v6 changes compared to v5 are:
>  - Mic preamplifier special cases for A20 and A10 now are now not
>    icky: There are two different _widget arrays and the probe() function
>    now selects the right one to pass to snd_soc_register_codec() unmodified.
>  - sun7i-specific things (A20-specific things) are now grouped together.
>
> v5 changes compared to v4 are:
>  - Mic preamplifier controls have more common names now.
>  - Mic preamplifier scale has a 0 dB entry as well now, as documented in the
>    A20 user manual.
>  - Mic preamplifier has special cases for A20 and A10 now.
>  - Gain controls have "Gain" in the name now.
>
> v4 changes compared to v3 are:
>  - names of the input are not uppercase anymore.
>  - bit index constants are now named as in the A20 user manual v1.4.
>  - added Mic1-In, Mac2-In.
>  - added Mic1 and Mic2 Pre-Amplifiers.
>
> v3 changes compared to v2 are:
>  - added DAPM routes.
>
> v2 changes compared to v1 are:
>  - moved Line-In and FM-In playback switches to their respective
>    sun4i_codec_*_mixer_controls.
>
> v1 changes:
>  - added linein, fmin output volumes and switches.
>
> Danny Milosavljevic (12):
>   sun4i-codec: Add inputs: Mic2, Line Right, Line Left, FM Right, FM
>     Left.
>   sun4i-codec: Add Differential Line Capture Switch and its routes
>   sun4i-codec: Add Line Playback Volume, FM Playback Volume, Mic
>     Playback Volume, Capture Volume, Line Capture Volume.
>   sun4i-codec: Add Mic1 Capture Volume, Mic2 Capture Volume.
>   sun4i-codec: Move struct sun4i_codec_quirks further up.
>   sun4i-codec: Add support for extra controls to struct
>     sun4i_codec_quirks and use them.
>   sun4i-codec: Add extra controls to sun4i_codec_quirks,
>     sun7i_codec_quirks.
>   sun4i-codec: Merge sun4i_codec_left_mixer_controls and
>     sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls.
>   sun4i-codec: Add Line Playback Switch, FM Playback Switch, Mic1
>     Playback Switch, Mic2 Playback Switch.
>   sun4i-codec: Add Left Capture Select, Right Capture Select.
>   sun4i-codec: Add MIC2 Pre-Amplifier.
>   sun4i-codec: Add routes for playback switches, Mic2, Capture Select.

This is not really what I meant by splitting up the patches.

First of all, in some patches, you are adding pieces that don't have
any meaningful use without following patches. Then you neglect to mention
this (or anything meaningful) in your commit messages. Your commit message
should detail what you are doing, and why you're doing it. The latter is
even more important the the former. You are supposed to justify your
changes.

Instead, try doing one meaningful change at a time. One example would be:
add the Mic2 input, including the widget, mixer kcontrols, mic gain
kcontrols, and routes. That way, one can test each individual patch.

Check out the git history of sound/soc/sunxi/sun4i-codec.c and see what
I did for the A31.

ChenYu

>
>  sound/soc/sunxi/sun4i-codec.c | 283 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 259 insertions(+), 24 deletions(-)
>
