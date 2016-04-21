From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Thu, 21 Apr 2016 10:55:16 +0200
Subject: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line and Mic inputs
In-Reply-To: <20160321175436.GD30977@lukather>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
 <20160315105802.GN2566@sirena.org.uk>
 <20160319171336.6e16eb5a@scratchpost.org>
 <20160321175436.GD30977@lukather>
Message-ID: <20160421105516.7e787c90@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, 21 Mar 2016 18:54:36 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> As I recall it, we were mostly discussing the how to deal with the ADC
> muxer that muxes both left and right at the same time (so shared
> controls), but with different source on each channel.

Hmm. Yeah, among other things. 

I've used an enum control for that and the routes just enable the 
right thing depending on the selected value (either "Mic1+Mic2" or 
"Mic1" or "Mic2" or etcetc).

I think this part works fine in v8 - and is as nice as we can 
reasonably do it.

-----

Also, for some outputs, there are multiple channels, multiple muters, 
but just one playback volume (i.e. the volume is mono but the muters are 
stereo AND possibly crossed over, see below).

It would have been possible to retain which channel is which in 
the Mic Playback "volumes" - but not necessary. 
Multiple muters exist there so it would just have been for consistency.

So let's just not retain that.

> As I understand it, you can have shared controls by sharing the
> kcontrols structure, but then, you can't different labels.

Yes. Because that's the case there's no upside in sharing the 
Mic Playback Volume. Therefore, I've moved it back to the common controls 
and made it just one control. At that point the user has to use UCM or 
just notice that Mic Playback Volume changes the playback volume on all of:
- Left Mixer Mic1 Playback
- Left Mixer Mic2 Playback
- Right Mixer Mic1 Playback
- Right Mixer Mic2 Playback
(those four don't have sliders but physically output something if 
 individually unmuted).

(The downside of sharing the controls would be that the sharing 
 detection works by comparing the struct snd_kcontrol_new instance addresses. 
 Good luck in getting that to work in two struct snd_kcontrol_new[]. 
 I did it before by merging the arrays and index gymnastics but I'd rather 
 not do it at all now. Note to self: there's a way to dynamically allocate 
 alsa controls)

----

Also, there's ADC Capture Volume: that one actually affects everything 
that is captured, whatever the source. Now, the user has to know this. For 
him, it looks as if Mic1 had its own capture volume ("Mic1 Capture Volume") 
but that's actually the mic1 preamplifier gain which will be effectively 
multiplied by the ADC Capture Volume in the data he gets.

In the long term I think it would be nice if userspace could see the routes.

----

Then, on my hardware there's destructive interference when I enable the DAC->PA and 
the Mixer->PA and also enable the DAC->Mixer, to get:

- DAC->PA
- DAC->Mixer->PA

Currently, the user is not prevented from doing this, however it will result 
in no perceptible PA sound when he sends something to the DAC.

Is that fine?

----

If all these points are fine like that then let's do it like that.

I'll send a v9 patch along these lines.

Thanks,
   Danny
