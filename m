From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Jun 2017 16:38:48 +0800
Subject: [linux-sunxi] Re: [PATCH v13 05/14] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into
 sun4i_codec_mixer_controls.
In-Reply-To: <20170628102520.29c50592@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
 <20170624062419.23778-6-dannym@scratchpost.org>
 <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
 <20170626192100.h5o366tawcnkqosx@flea.lan>
 <20170628102520.29c50592@scratchpost.org>
Message-ID: <CAGb2v66eUNbBwLXH8Sk8zQUTOQFdRYmyWytm3tfxBGa8CL_Bew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 4:25 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Hi,
>
>> > > -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
>> > > -       SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > > -                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
>> > > -};
>> > > -
>> > > -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
>> > > -       SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
>> > > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
>> > >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
>> >
>> > This changes the mixer control names exposed to userspace. While I think
>> > consolidating mixer controls is nice, giving the user a less cluttered
>> > view, I'm not sure about the changing a possible userspace ABI.
>> >
>> > Maxime, ALSA and ASoC people, any comments about this?
>
>>Yeah, breaking userspace is definitely not ok.
>
> Okay.  I can restore DAC Playback Switch as two different controls with the same
> names as before.
>
> Is the mixer itself (SND_SOC_DAPM_MIXER) - not talking about its controls -
> exposed to userspace?

Other than debugfs, no it is not.

> Because if not, I can still merge the left mixer and right mixer and just fix up
> the control names for DAC Playback Switch to be the same as before, something
> like this:
>
> static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
>         SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch", // !!!
>                         SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
>         SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch", // !!!
>                         SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
>         SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
>                         SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
>         SOC_DAPM_DOUBLE("Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LLNS,
>                         SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
>         SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LFMS,
>                         SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
>         SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_MIC1LS,
>                         SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
>         SOC_DAPM_DOUBLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_MIC2LS,
>                         SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
> };
>
> static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
> ...
>         SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
>                            sun4i_codec_mixer_controls,
>                            ARRAY_SIZE(sun4i_codec_mixer_controls)), // !!!
>         SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
>                            sun4i_codec_mixer_controls,
>                            ARRAY_SIZE(sun4i_codec_mixer_controls)), // !!!
> };
>
> Would this be a good way?

I think that would work. We would need to verify that the DAPM routing
graph for the existing single channel controls work as intended though.

ChenYu
