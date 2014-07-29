From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 29 Jul 2014 13:19:39 -0700
Subject: [PATCH 8/8] clk: tegra: Add EMC clock driver
In-Reply-To: <53D75FA7.1030300@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-9-git-send-email-mperttunen@nvidia.com>
 <53CE97F2.80300@wwwdotorg.org> <53D75FA7.1030300@nvidia.com>
Message-ID: <20140729201939.4627.79710@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mikko Perttunen (2014-07-29 01:47:35)
> On 22/07/14 19:57, Stephen Warren wrote:
> > On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
> >> +static int emc_debug_rate_set(void *data, u64 rate)
> >> +{
> >> +    struct tegra_emc *tegra = data;
> >> +
> >> +    return clk_set_rate(tegra->hw.clk, rate);
> >> +}
> >> +
> >> +DEFINE_SIMPLE_ATTRIBUTE(emc_debug_rate_fops, emc_debug_rate_get,
> >> +                    emc_debug_rate_set, "%lld\n");
> >
> > I think the rate can already be obtained through
> > ...debug/clock/clock_summary. I'm not sure about changing the rate, but
> > shouldn't that be a feature of the common clock core, not individual
> > drivers?
> 
> The core doesn't allow writing to the rate debugfs files, so this is the 
> only way to trigger an EMC clock change for now. I agree that the core 
> might be a better place. I don't know if there are any philosophical 
> objections to that. I'd like to keep this in until a possible core 
> feature addition. Mike, any comments?

Yes, there is a philosophical rejection to exposing rate-change knobs to
userspace through debugfs. These can and will ship in real products
(typically Android) with lots of nasty userspace hacks, and also
represent pretty dangerous things to expose to userspace. I have always
maintained that such knobs should remain out of tree or, with the advent
of the custom debugfs entries, should be burden of the clock drivers.

Regards,
Mike
