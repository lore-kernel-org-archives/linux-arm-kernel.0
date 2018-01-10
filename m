From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jan 2018 16:57:12 +0000
Subject: [PATCH 0/3] ARM branch predictor hardening
In-Reply-To: <86608c3urn.wl-marc.zyngier@arm.com>
References: <20180106120907.26701-1-marc.zyngier@arm.com>
 <608da127-fffa-0782-7baf-7edfe189abdc@gmail.com>
 <86608c3urn.wl-marc.zyngier@arm.com>
Message-ID: <20180110165712.GP17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 09:28:28PM +0000, Marc Zyngier wrote:
> On Sat, 06 Jan 2018 18:50:41 +0000,
> Florian Fainelli wrote:
> 
> Hi Florian,
> 
> > Le 01/06/18 ? 04:09, Marc Zyngier a ?crit?:
> > > This small series implements some basic BP hardening by invalidating
> > > the BTB on CPUs that are known to be susceptible to aliasing attacks.
> > > 
> > > These patches are closely modelled against what we do on arm64,
> > > although simpler as we can rely on an architected instruction to
> > > perform the invalidation.
> > > 
> > > The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
> > > generalises it to be used on all affected CPUs. The second perform the
> > > same invalidation on fatal signal delivery. The last one nukes it on
> > > guest exit, and results in some major surgery (kudos to Dimitris
> > > Papastamos who came up with the magic vector decoding sequence).
> > > 
> > > Note that that M-class CPUs are not affected and for R-class cores,
> > > the mitigation doesn't make much sense since we do not enforce
> > > user/kernel isolation.
> > 
> > Broadcom's Brahma-B15 CPUs are also affected, I can either send an
> > incremental patch on top of this series once it lands in, or since it
> > looks like you are going to respin a v2, feel free to incorporate the
> > changes I sent as replies to patch 1 and 2.
> 
> I've re-spun the series, as there was quite a few issues with the
> first one. Could you please try and respin your B15 patches on top?
> 
> > What about P4JB and Krait, should they also be covered?
> 
> I have no idea. I only know of the ARM cores. Other implementation
> will have to check whether they are affected or not.
> 
> > Even though I am assuming -stable maintainers will quickly pick
> > those changes, should there be an explicit mention of CVE-2017-5715?
> 
> I have no plans for these patches to be merged immediately. We're
> targeting the arm64 patches at v4.16, and I don't expect the 32bit
> patches to be any different.
> 
> As for the CVE mention, I'm not really bothered (yet another number
> soup). Everybody knows what we're talking about, these days...

That is untrue.  I've been trying to talk to you guys about it, and
I'm getting very little back - you haven't replied to the email I sent
privately last week for example, and so far I've not seen any response
to my email yesterday.

So for the past week, I've been researching the information and trying
stuff out.  I've my own conclusions, reached entirely independently,
and so far I see nothing to suggest that this patch series does anything
to solve any of the published issues.

Given that, I'm not currently considering merging these patches until
it becomes clearer what they are trying to address.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
