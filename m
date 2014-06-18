From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Jun 2014 00:03:44 +0200
Subject: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
In-Reply-To: <53A1D089.8010605@wwwdotorg.org>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
 <53A069B6.6070902@wwwdotorg.org> <53A1CB23.5090307@collabora.com>
 <53A1D089.8010605@wwwdotorg.org>
Message-ID: <20140618220343.GD26514@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 11:46:49AM -0600, Stephen Warren wrote:
> On 06/18/2014 11:23 AM, Tomeu Vizoso wrote:
> > On 06/17/2014 06:15 PM, Stephen Warren wrote:
> >> On 06/17/2014 06:16 AM, Tomeu Vizoso wrote:
> >>> On 06/16/2014 10:02 PM, Stephen Warren wrote:
> >>>> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> >>>>> +#ifdef CONFIG_TEGRA124_EMC
> >>>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
> >>>>> long rate);
> >>>>> +void tegra124_emc_set_floor(unsigned long freq);
> >>>>> +void tegra124_emc_set_ceiling(unsigned long freq);
> >>>>> +#else
> >>>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
> >>>>> long rate)
> >>>>> +{ return -ENODEV; }
> >>>>> +void tegra124_emc_set_floor(unsigned long freq)
> >>>>> +{ return; }
> >>>>> +void tegra124_emc_set_ceiling(unsigned long freq)
> >>>>> +{ return; }
> >>>>> +#endif
> >>>>
> >>>> I'll repeat what I said off-list so that we can have the whole
> >>>> conversation on the list:
> >>>>
> >>>> That looks like a custom Tegra-specific API. I think it'd be much
> >>>> better
> >>>> to integrate this into the common clock framework as a standard clock
> >>>> constraints API. There are other use-cases for clock constraints
> >>>> besides
> >>>> EMC scaling (e.g. some in audio on Tegra, and I'm sure many on other
> >>>> SoCs too).
> >>>
> >>> Yes, I wrote a bit in the cover letter about our requirements and how
> >>> they map to the CCF. Could you please comment on that?
> >>
> >> My comments remain the same. I believe this is something that belongs in
> >> the clock driver, or at the least, some API that takes a struct clock as
> >> its parameter, so that drivers can use the existing DT clock lookup
> >> mechanism.
> > 
> > Ok, let me put this strawman here to see if I have gotten close to what
> > you have in mind:
> > 
> > * add per-client accounting (Rabin's patches referenced before)
> > 
> > * add clk_set_floor, to be used by cpufreq, load stats, etc.
> > 
> > * add clk_set_ceiling, to be used by battery drivers, thermal, etc.
> 
> Yes. I'd expect those to be maintained per-client, and so the clock core
> (or whatever higher level code implements clk_set_floor/ceiling)
> performs the logic that "blends" together all the different requests
> from different clients.
> 
> As an aside, for audio usage, I would expect clk_set_rate to be a
> per-client (rather than per HW clock) operation too, and to error out if
> one client says it wants to set pll_a to the rate needed for
> 44.1KHz-based audio and a different client wants the rate for
> 48KHz-based audio.

>From what I remember, Mike was fairly strongly opposing the idea of
virtual clocks, but what you're proposing here sounds like it would
assume the existence of virtual clocks. clk_set_rate() per client
doesn't work with the current API as I understand it.

Or perhaps what you're proposing isn't about the individual clocks at
all but rather about a mechanism to express constraints for a set of
clocks?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140619/be2d8870/attachment.sig>
