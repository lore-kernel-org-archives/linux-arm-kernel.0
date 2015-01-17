From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 17 Jan 2015 15:52:22 -0800
Subject: [RFC 0/3] mmc: Add dynamic frequency scaling
In-Reply-To: <CAPDyKFqe7UxSrQxuvGw7UWFQhvX0NZ83rvLrAEMZFpA4n0GcNg@mail.gmail.com>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFpGiaDJ3zjCSSbcia6iLS2+FLBRjGAheQAzvFsAkJax+A@mail.gmail.com>
 <1421313626.19448.8.camel@AMDC1943>
 <CAPDyKFqe7UxSrQxuvGw7UWFQhvX0NZ83rvLrAEMZFpA4n0GcNg@mail.gmail.com>
Message-ID: <20150117235222.22722.904@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2015-01-15 02:04:04)
> On 15 January 2015 at 10:20, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > On czw, 2015-01-15 at 09:20 +0100, Ulf Hansson wrote:
> >> + Mike, Stephen (Clock maintainers)
> >>
> >> On 12 January 2015 at 10:23, Krzysztof Kozlowski
> >> <k.kozlowski@samsung.com> wrote:
> >> > Hi,
> >> >
> >> >
> >> > I would like to hear some comments about idea of scaling MMC clock
> >> > frequency. The basic idea is to lower the clock when device is
> >> > completely idle or not busy enough.
> >>
> >> We already have host drivers that implements runtime PM support.
> >> Typically that would mean the clock will be gated once the device
> >> becomes runtime PM suspended.
> >>
> >> Why should we decrease the frequency of an already gated clock?
> >
> > In case of idle state you're right that clkgate would be better. But
> > what about finding a compromise between high performance (high
> > frequency) and energy saving for different loads on MMC?
> 
> I guess a compromise could be beneficial for some SOC and use cases.
> At least I remember, ST-Ericsson's UX500 SOC had such an out of tree
> hack to track MMC load.

It is very important to model when resources are not needed, since this
has some system-wide effects. There are two main use-cases I have in
mind:

1) MMC clk is a leaf clock of some complex hierarchy (e.g. a PLL at the
top of a clock sub-tree). If MMC is always "locked" at some fast rate
(e.g. 48MHz instead of 24MHz or 12MHz) then that constraint prevents
the rest of the hierarchy from transitioning to a lower frequency. Even
if the MMC clock is aggressively gating, maximum system-level power
savings may not be achieved since the rest of the clock sub-tree
(starting at the PLL) will be "stuck" at a higher frequency than
necessary. Thus, aggressive clock gating might give good power savings
for the MMC case, but may be a blocker for other system components.

2) Wake-up latency constraints might make it impossible to clock gate,
and thus the only power-saving option is to run at a lower frequency.
This is not quite what is described above, but the point is that clock
frequency scaling and clock gating are complementary power saving
options, but we rely on the driver to model resource requirements
accurately to get the best results.

Regards,
Mike

> 
> >
> > The frequency scaling could help in that case. Anyway I should prepare
> > some more benchmarks for such conditions.
> 
> Seems reasonable and please do!
> 
> Kind regards
> Uffe
