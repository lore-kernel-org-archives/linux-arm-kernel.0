From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 1 Jul 2014 19:49:53 +0200
Subject: [PATCH 4/4] ARM: mvebu: add armada drm init to Dove board setup
In-Reply-To: <20140701164527.GY32514@n2100.arm.linux.org.uk>
References: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1404219871-18419-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140701131026.GO32514@n2100.arm.linux.org.uk>
 <53B2B5E5.50502@gmail.com>
 <20140701133627.GP32514@n2100.arm.linux.org.uk>
 <20140701180426.54a79a0b@armhf>
 <20140701164527.GY32514@n2100.arm.linux.org.uk>
Message-ID: <20140701194953.78a0c5cf@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Jul 2014 17:45:27 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> Let's tell the full story rather than just presenting half of it.
> 
> You indeed wanted to do what you said above, but you also wanted to
> completely change the component helpers in a way that I was not happy
> with.  You wanted to add all sorts of DT specific gunk into the
> helpers, which would have tied it to DT.
> 
> While DT is the current thing on ARM, it is /not/ the current thing
> everywhere - a point which you failed to grasp.

I don't think that there will ever be a x86 DT.
Yes, I did not know what was the DT. For me, when entering in the ARM
world, it was a marvellous tool which could have ended in a unique ARM
kernel. I'm a dreamer!

> You wanted to make the component operations optional, which I pointed
> out makes no sense (because then components have no way to know what
> happens to their master device - which is /really/ important for DRM.)

You did not explain too much that you wanted to keep it for DRM only.

> You refused to listen to those concerns, and refused to look at the
> patch which I proposed, which did exactly the same as your patch,
> while keeping the DRM slave interfaces for tilcdc to use, until they
> have a chance to convert over.

The change in tilcdc was easy and the code was greatly simplified.

> You kept telling me that I had "opened the door" to your changes.  I
> claimed that your changes abused the code which I had written - a point
> which I still maintain to this day.

Your code was offering a simple way to synchronize the system
initialization without this lot of 'probe defer's. It could have been
used so.

> You also claimed that deferred probing didn't work.  Since the component
> helpers were designed with the deferred probing problem in mind at the
> time, and include the solution to that problem - which has been well
> tested hundreds if not thousands of times by now - and you did not
> provide the technical details as to why you thought it didn't work,
> there was nothing that could be done to progress that point.

AFAIR, you also said that the probe defer was not working. But, thanks
again for your component layer: all my init problems are gone, even if
there are still some prove defer's...

> Moreover, your abuse of the component layer would have made it more
> difficult to maintain it into the future - which is a fundamental
> point which has to be considered when accepting any patch into the
> kernel.  If a patch makes some code unable to be maintained, then an
> alternative approach has to be found.  Since you were not willing to
> compromise on finding or considering alternative approaches such as
> the one I presented.

I don't see what you are talking about.

> Since the component layer had had various comments which were in
> progress, and your abuse of the component layer would have also
> prevented those changes taking place (which are - in part - the set
> of component patches which are on the list now) there is no way that
> your uncompromising set of patches would be merged - at least not
> until you start accepting some of the comments being given to you.
> 
> > Now, the last thing for me is to put the TDA998x codec in the kernel
> > (it is also working in an other machine with 2 tda998x's).  
> 
> Yes, supporting the I2S connection is something that is need, but we
> /also/ need to support SPDIF, and SPDIF is the preferred method on
> the Cubox.  SPDIF should be used to talk to the TDA998x whenever
> possible because it opens up the possibility for sending out
> compressed MPEG2 and AC-3 audio streams, thus offloading the decode
> of these formats to external hardware.
> 
> This works today, and is a feature that people have been using with
> platforms such as xbmc and various other installations on the Cubox.
> 
> Limiting to I2S means that you can't send out these compressed audio
> streams.  In fact, the Dove manual tells you that you must disable
> the I2S playback stream if you're sending non-PCM - non-PCM is only
> supported via SPDIF.

I don't understand: both I2S and S/PDIF may work in the kirkwood audio
subsystem as it is (yes, actually not at the same time, and this is a
choice because DPCM does not work for the Cubox). I have the 3 ways in
my system:

$ cat /proc/asound/pcm 
00-00: i2s-i2s-hifi i2s-hifi-0 :  : playback 1
00-01: spdif-spdif-hifi spdif-hifi-1 :  : playback 1
00-02: spdif-dit-hifi dit-hifi-2 :  : playback 1

So, S/PDIF should work, but I don't know it: I have no optical connector.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
