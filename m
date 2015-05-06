From: anssi.hannula@iki.fi (Anssi Hannula)
Date: Wed, 06 May 2015 20:02:52 +0300
Subject: [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <20150405172608.GA12732@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk> <s5ha8ymy3e2.wl-tiwai@suse.de>
 <20150405162034.GH13898@n2100.arm.linux.org.uk>
 <s5h4mouy14a.wl-tiwai@suse.de>
 <20150405172608.GA12732@n2100.arm.linux.org.uk>
Message-ID: <554A493C.5080106@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

05.04.2015, 20:26, Russell King - ARM Linux kirjoitti:
> On Sun, Apr 05, 2015 at 06:46:13PM +0200, Takashi Iwai wrote:
>>
>> One another question: don't we need to deal with the sample bits in
>> sad[2]?
> 
> It should, but I'm very wary about doing that without seeing more
> examples of real SADs.  Right now, all my examples only support
> one SAD with either 2 channel or 6 channel audio at the standard
> (basic) 32, 44.1 and 48kHz rates.
> 
> The HDMI / CEA specs are very loose in their wording about the
> short audio descriptors.  I've no idea whether a sink can provide
> (for example) descriptors such as:
> 
> 	LPCM, 6 channel 32, 44.1, 48kHz
> 	LPCM, 2 channel, 32, 44.1, 48, 96, 192kHz
> 
> or whether have to describe that as a single descriptor.  I only
> have two TVs to test with here.

For the record, yes, multiple LPCM SADs are relatively common, and I
think I've seen some that offered more rates on a stereo SAD than on a
multichannel SAD (like in your example).


> What I'm concerned about is that when the ALSA parameter refining
> starts, we start with (eg) 2-8 channels, 32-192kHz.  Given that,
> if we invoke the channel restriction before the rate restriction,
> we would end up limiting to 2 channel at 32-192kHz.  If we apply
> the restrictions in the opposite order, we'd restrict to 6
> channel, 32-48kHz.  Neither are obviously correct in this
> circumstance, and I don't really see a way to solve it given my
> understanding of the way ALSA's parameter refinement works.
> 
> I suspect this is why most HDMI drivers are implemented such that
> they take the maximum capabilities over all SADs, which would end
> up restricting audio in the above case to: up to 6 channels, at
> 32, 44.1, 48, 96 and 192kHz, even though 6 channel @ 192kHz isn't
> hasn't been indicated as supported.
> 
> Most of this is speculation though, based off what is in the
> documentation.  As I say, I don't have enough real-world examples
> to get a feel for what manufacturers _actually_ do to give a hint
> as to how the documentation should be interpreted.
> 
> So, maybe I should just copy what everyone else does and take the
> maximum of all descriptors...
> 


-- 
Anssi Hannula
