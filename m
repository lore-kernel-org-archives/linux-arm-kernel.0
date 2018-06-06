From: tiwai@suse.de (Takashi Iwai)
Date: Wed, 06 Jun 2018 11:47:21 +0200
Subject: [alsa-devel] [PATCH 0/3] ASoC: stm32: sai: add support of iec958
 controls
In-Reply-To: <c4b2d22f-320d-a415-6328-b33f9c03aafe@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
 <20180417111733.GG8973@sirena.org.uk>
 <2ae6c5b6-872a-9aaa-6ca4-e29adb7c8bc0@st.com>
 <s5hpo15xf1q.wl-tiwai@suse.de>
 <c4b2d22f-320d-a415-6328-b33f9c03aafe@st.com>
Message-ID: <s5hpo14w8k6.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Jun 2018 11:31:45 +0200,
Arnaud Pouliquen wrote:
> 
> 
> 
> On 06/05/2018 08:29 PM, Takashi Iwai wrote:
> > On Tue, 05 Jun 2018 17:50:57 +0200,
> > Arnaud Pouliquen wrote:
> >> 
> >> Hi Takashi,
> >> 
> >> On 04/17/2018 01:17 PM, Mark Brown wrote:
> >> > On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:
> >> > 
> >> >> I guess the blocking patch in this patchset is the patch "add IEC958 
> >> >> channel status control helper". This patch has been reviewed several 
> >> >> times, but did not get a ack so far.
> >> >> If you think these helpers will not be merged, I will reintegrate the 
> >> >> corresponding code in stm driver.
> >> >> Please let me know, if I need to prepare a v2 without helpers, or if we 
> >> >> can go further in the review of iec helpers patch ?
> >> > 
> >> > I don't mind either way but you're right here, I'm waiting for Takashi
> >> > to review the first patch.? I'd probably be OK with it just integrated
> >> > into the driver if we have to go that way though.
> >> 
> >> Gentlemen reminder for this patch set. We would appreciate to have your
> >> feedback on iec helper.
> >> From our point of view it could be useful to have a generic management
> >> of the iec controls based on helpers instead of redefining them in DAIs.
> >> Having the same behavior for these controls could be useful to ensure
> >> coherence of the control management used by application (for instance
> >> Gstreamer uses it to determine iec raw mode capability for iec61937 streams)
> > 
> > Oh sorry for the late reply, I've totally overlooked the thread.
> > 
> > And, another sorry: the patchset doesn't look convincing enough to
> > me.
> > 
> > First off, the provided API definition appears somewhat
> > unconventional, the mixture of the ops, the static data and the
> > dynamic data.
> Sorry i can't figure out your point. I suppose that you speak about the
> snd_pcm_iec958_params.
> what would be a more conventional API?

Imagine you'd want to put a const to the data passed to the API for
hardening.  The current struct is a mixture of static and dynamic
data.


> > Moreover, this is only for your driver, ATM.? 
> It is also compatible with the sound/sti driver, even if we does not
> propose patch yet. We also plan to propose an implementation, for the
> HDMI_codec that would need to export a control to allow none-audio mode.
> 
> >If it were an API that
> > does clean up the already existing usages, I'd happily apply it. There
> > are lots of drivers creating and controlling the IEC958 ctls even
> > now.
> > 
> > Also, the patchset requires more fine-tuning, in anyways.? The changes
> > in create_iec958_consumre() are basically irrelevant, should be split
> > off as an individual fix.? it is linked to the control, as not possible in existing implementation
> (rate and width are get from hwparam or runtime). But no problem we can
> split it in a separate patch.
> 
> Also, the new function doesn't create the
> > "XXX Mask" controls.? And the byte comparison should be replaced with
> > memcmp(), etc, etc.
> Yes mask are missing, can be added. For the rest could you comment
> directly in code? i suppose that you want to replace the for loops by
> memcmp, memcpy...

Right.

> > So, please proceed rather with the open codes for now.? If you can
> > provide a patch that cleans up the *multiple* driver codes, again,
> > I'll happily take it.? But it can be done anytime later, too.
> Not simple to clean up the other drivers as this control is a PCM
> control, that is mainly implemented as a mixer or card control.
> This means that it should be registered on the pcm_new in CPU DAI or in
> the DAI codec, to be able to bind it to the PCM device.
> Inpact is not straigthforward as this could generate regression on driver.

Yes, and that's my point.  The application of API is relatively
limited -- although the API itself has nothing to do with ASoC at
all.

> For now We can add the clean up on the sti driver based on this helper,
> and we are working on the HDMI_codec, we could also use this helper to
> export the control....
> 
> So if you estimate that it is interesting to purchase on this helper we
> can try to come back with a patch set that implements the helper for
> the 3 drivers.

Right.  Basically there are two cases we add a new API:

1. It's absolutely new and nothing else can do it
2. API simplifies the whole tree, not only one you're trying to add.

And in this case, let's prove 2 at first, that the API *is* actually
useful in multiple situations we already have.  Then I'll happily ack
for that.  More drivers cleanup, better.  At best, think of more
range above ASoC, as you're proposing ALSA core API, not the ASoC
one.

> The other option, is that we drop the helpers, and implement the control
> directly in our drivers.

This is of course another, maybe easier option.

> Please just tell us if we should continue to propose the helpers or not.

I have no preference over two ways, but am only interested in the
resulting patches :)


thanks,

Takashi
