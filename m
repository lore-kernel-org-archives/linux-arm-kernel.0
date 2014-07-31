From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 31 Jul 2014 12:06:59 -0700
Subject: [PATCH 8/8] clk: tegra: Add EMC clock driver
In-Reply-To: <20140730093456.GA29590@ulmo>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-9-git-send-email-mperttunen@nvidia.com>
 <53CE97F2.80300@wwwdotorg.org> <53D75FA7.1030300@nvidia.com>
 <20140729201939.4627.79710@quantum> <53D81CD4.5010307@wwwdotorg.org>
 <20140730093456.GA29590@ulmo>
Message-ID: <20140731190659.4463.92139@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thierry Reding (2014-07-30 02:34:57)
> On Tue, Jul 29, 2014 at 04:14:44PM -0600, Stephen Warren wrote:
> > On 07/29/2014 02:19 PM, Mike Turquette wrote:
> > >Quoting Mikko Perttunen (2014-07-29 01:47:35)
> > >>On 22/07/14 19:57, Stephen Warren wrote:
> > >>>On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
> > >>>>+static int emc_debug_rate_set(void *data, u64 rate)
> > >>>>+{
> > >>>>+    struct tegra_emc *tegra = data;
> > >>>>+
> > >>>>+    return clk_set_rate(tegra->hw.clk, rate);
> > >>>>+}
> > >>>>+
> > >>>>+DEFINE_SIMPLE_ATTRIBUTE(emc_debug_rate_fops, emc_debug_rate_get,
> > >>>>+                    emc_debug_rate_set, "%lld\n");
> > >>>
> > >>>I think the rate can already be obtained through
> > >>>...debug/clock/clock_summary. I'm not sure about changing the rate, but
> > >>>shouldn't that be a feature of the common clock core, not individual
> > >>>drivers?
> > >>
> > >>The core doesn't allow writing to the rate debugfs files, so this is the
> > >>only way to trigger an EMC clock change for now. I agree that the core
> > >>might be a better place. I don't know if there are any philosophical
> > >>objections to that. I'd like to keep this in until a possible core
> > >>feature addition. Mike, any comments?
> > >
> > >Yes, there is a philosophical rejection to exposing rate-change knobs to
> > >userspace through debugfs. These can and will ship in real products
> > >(typically Android) with lots of nasty userspace hacks, and also
> > >represent pretty dangerous things to expose to userspace. I have always
> > >maintained that such knobs should remain out of tree or, with the advent
> > >of the custom debugfs entries, should be burden of the clock drivers.
> > 
> > That argument seems a bit inconsistent.
> > 
> > I can see the argument to disallow code that lets user-space fiddle with
> > clocks. However, if that argument holds, then surely it must apply to either
> > the clock core *or* a clock driver; the end effect of allowing the code in

Stephen,

You meant to say, "it must apply to both the clock core and a clock
driver"? I agree.

> > either place is that people will be able to implement the user-space hacks
> > you want to avoid. Yet, if we allow the code because it's a useful debug
> > tool, then surely it should be in the clock core so we don't implement it
> > redundantly in each clock driver.

I don't want it anywhere to be honest. Read-only debugfs stuff is great
and I'm happy to merge it. I have repeatedly NAK'd any attempt to get
the userspace rate-change stuff merged into the core.

Recently we have the ability to assign custom debugfs entries that are
specific to the clock driver. I'm trying to find the right balance
between giving the clock driver authors the right amount of autonomy to
implement what they need while trying to keep the crazy out of the
kernel. Maybe in this case I should stick to my guns and NAK this patch.

> > 
> > We could always taint the kernel if the feature is used. Admittedly that
> > wouldn't stop people using the feature as a hack in Android/product kernels,
> > but at least nobody would have to unknowingly debug problems due to such
> > manipulation, in the context of an upstream kernel.
> 
> Not merging this feature upstream won't stop anybody from implementing
> it as a hack in Android/product kernels either. If it's useful then
> somebody will implement it in whatever downstream kernel they use. And
> if it's useful to more than one vendor then we'll end up with a copy of
> the implementation (and derivations on top) in each vendor's tree.

Thierry,

That argument is not sufficient to merit merging code. There is all
kinds of wacky downstream code that gets duplicated by various hardware
vendors, Linux distributions, the Cyanogenmod community, etc. Should we
merge any piece of downstream code just because more than one person
wants to use it?

> 
> debugfs requires superuser privileges anyway, in which case you could
> equally well write userspace software that directly bangs on the clock
> controller registers.

Sure. There are lots of technical reasons why this isn't such a bad idea
(e.g. you need admin privileges, we shouldn't ship devices with debugfs
turned on, etc). But by merging it we tell people, "hey, this is an OK
thing to do", which it is not.

Regards,
Mike

> 
> Thierry
