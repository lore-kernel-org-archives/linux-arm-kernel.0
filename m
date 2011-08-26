From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 26 Aug 2011 09:16:14 +0000
Subject: [alsa-devel] [PATCH v2 1/1] ASoC: soc-core: check rate for
	symmetry only when pcm is active
In-Reply-To: <4E552F5F.9070801@metafoo.de>
References: <1314183728-23627-1-git-send-email-b29396@freescale.com>
	<4E5520CE.60204@ti.com> <4E552F5F.9070801@metafoo.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772225E52@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars at metafoo.de]
> Sent: Thursday, August 25, 2011 1:06 AM
> To: Liam Girdwood
> Cc: Dong Aisheng-B29396; alsa-devel at alsa-project.org;
> broonie at opensource.wolfsonmicro.com; s.hauer at pengutronix.de; linux-arm-
> kernel at lists.infradead.org; w.sang at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH v2 1/1] ASoC: soc-core: check rate for
> symmetry only when pcm is active
> 
> On 08/24/2011 06:03 PM, Liam Girdwood wrote:
> > On 24/08/11 12:02, Dong Aisheng wrote:
> >> For the playback and record using different dai links, checking
> >> !rtd->rate for symmetry may not be accurate because that pcm may be
> >> acutually not running and the default new open rate is 0, then the
> >> warning message "Not enforcing symmetric_rates" will happen each time
> >> with running arecord | aplay.
> >>
> >> Now we only check rate for symmetry when the pcm is really active
> >> which seems more sensible.
> >>
> >> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> >> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >> Cc: Liam Girdwood <lrg@ti.com>
> >> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > Acked-by: Liam Girdwood <lrg@ti.com>
> >
> 
> I don't think the patch in it's current form is a good idea. All it does
> is silencing the warning instead of addressing the real issue. The issue
> at hand here is, that the same DAI is connected to two other DAIs and the
> thus shared between two PCMs. The shared DAI requires symmetric rates.
> This is something that is not covered by the current code, since it
> assumes that a DAI is not shared between different PCMs. So with this
> patch the warning will be gone, but it is still possible that the capture
> and playback stream of the DAI to be configured to run at different rates,
> which will obviously unwanted behavior.
Although I think that's another issue and it's a special using case.
But I think it would be good if we can fix that issue by covering this wrong
warning message issue also.

> A more sensible solution would in my opinion be to save the current rate
> in the dai struct itself and not in the pcm struct. Upon opening a stream
> check for cpu and codec DAI whether they require symmetry. If they do and
> are active constraint the rate to DAIs rate. This also ensures that if
> boths DAIs are already active and are running at different rates there
> will be no valid rate for the new stream.
I have made another patch based on your idea and will send it out as RFC soon.
Thanks a lot for your good suggestion.

Regards
Dong Aisheng
