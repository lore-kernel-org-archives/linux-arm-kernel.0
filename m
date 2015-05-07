From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 07 May 2015 13:11:16 +0200
Subject: [alsa-devel] [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <20150507104102.GA2067@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk> <s5ha8ymy3e2.wl-tiwai@suse.de>
 <20150405162034.GH13898@n2100.arm.linux.org.uk>
 <s5h4mouy14a.wl-tiwai@suse.de>
 <20150405172608.GA12732@n2100.arm.linux.org.uk> <554A493C.5080106@iki.fi>
 <20150507104102.GA2067@n2100.arm.linux.org.uk>
Message-ID: <554B4854.7090209@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2015 12:41 PM, Russell King - ARM Linux wrote:
[...]
>>> What I'm concerned about is that when the ALSA parameter refining
>>> starts, we start with (eg) 2-8 channels, 32-192kHz.  Given that,
>>> if we invoke the channel restriction before the rate restriction,
>>> we would end up limiting to 2 channel at 32-192kHz.  If we apply
>>> the restrictions in the opposite order, we'd restrict to 6
>>> channel, 32-48kHz.  Neither are obviously correct in this
>>> circumstance, and I don't really see a way to solve it given my
>>> understanding of the way ALSA's parameter refinement works.
>>>
>>> I suspect this is why most HDMI drivers are implemented such that
>>> they take the maximum capabilities over all SADs, which would end
>>> up restricting audio in the above case to: up to 6 channels, at
>>> 32, 44.1, 48, 96 and 192kHz, even though 6 channel @ 192kHz isn't
>>> hasn't been indicated as supported.
>>>
>>> Most of this is speculation though, based off what is in the
>>> documentation.  As I say, I don't have enough real-world examples
>>> to get a feel for what manufacturers _actually_ do to give a hint
>>> as to how the documentation should be interpreted.
>
> ... so this is probably less than speculation.
>
> So, ALSA gurus, how do we handle this?  How do we arrange the parameter
> resolution such that ALSA can permit _either_ 2 channels at 192kHz or 6
> channels at 48kHz, but not 6 channels at 192kHz?  Right now, I don't
> see how that's possible.

That's pretty straight forward and can be done using custom rules linking 
the number of channels to the sample rate. Have a look at 
snd_ac97_pcm_double_rate_rules() this is pretty much the same constraint.

- Lars
