From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Sep 2016 21:25:28 +0800
Subject: [linux-sunxi] Re: [PATCH v9 2/2] Add mixer controls: Line-In,
 FM-In, Mic 2, Capture Source, Differential Line-In.
In-Reply-To: <20160901125608.72808fac@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
 <20160830054403.7878-3-dannym@scratchpost.org>
 <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
 <20160901125608.72808fac@scratchpost.org>
Message-ID: <CAGb2v67UYe_7Et5NfpJCHykT+JO4VokHtmgXeHTkUBpT+6pp2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 6:56 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Hi Chen-Yu,
>
>> I have a few patches that introduce SOC_DAPM_DOUBLE, so you can share a
>> control between left/right channels. IMHO it makes the userspace mixer
>> less confusing.
>
> I definitely agree that cutting down on the number of sliders would be good.
> I do a double-take every time I open alsamixer - and I *added* these
> sun4i widgets :)
>
> It would be good if your patch series was queued and I could use SOC_DAPM_DOUBLE
> in a future version of my patch.
>
> Can you post it?

I'll try to make some time.

> Since it changes user space-visible API whether I group the widgets or not we
> have to be careful about it. So far my patch has not been merged which is good
> for API stability I guess.
>
> I wondered about why there's a SOC_DOUBLE_TLV but no SOC_DAPM_DOUBLE before,
> so it's good to know there's no deep reason.

AFAIU DAPM can't handle multiple channels. SOC_DAPM_ENUM_DOUBLE being the
exception, as for enums both channels are controlled together, so you don't
run into the problem of having to figure out which channel to connect or
disconnect.

> That said, I'd have to remove the distinction between Left Mixer and Right
> Mixer then. Right now it does distinguish.
>
> Removing the distinction would remove noteworthy routes like
>
>         { "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
>
> (not a typo). Would that be OK?

The SOC_DAPM_DOUBLE controls are to be shared between the left/right widgets.

See: https://github.com/wens/linux/commit/ea8ce9e865635595c73bc8f7eecd711d7500f8b2

sun6i_codec_mixer_controls is shared by the "Left Mixer" and "Right Mixer"
widgets. (Not shown in the patch.)

So you would still have:

    { "Left Mixer", "DAC Playback Switch", "Left DAC" },
    { "Right Mixer", "DAC Playback Switch", "Right DAC" },

This is what the DAPM diagram looks like on my A31:

    https://wens.tw/dapm.pdf

The routes are not exported to userspace, not counting debugfs.
Only the controls are.


Hope this explains things.

Regards
ChenYu


> Well, let's see how it will work out.
>
> In the mean time I added the second regmap and the quirks and will post another
> patch series for comments.
>
> Cheers,
>    Danny
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
