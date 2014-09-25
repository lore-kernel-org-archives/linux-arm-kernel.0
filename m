From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 25 Sep 2014 17:29:10 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <20140925112122.GA22753@ulmo>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
Message-ID: <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2014 13:21, Thierry Reding <thierry.reding@gmail.com> wrote:
> I just noticed these patches because they conflicted with some of the
> local patches I had to add a very similar framework. One of the reasons
> why I hadn't posted these publicly yet is because the platform where I
> want to use this (Tegra) is somewhat quirky when it comes to power
> domains.

It's great that more things goes on in this area. :-)

>
> On Tegra these domains are called power gates and they currently have
> their own API. We've been looking at migrating things over to some
> generic framework for some time and PM domains do seem like a good fit.
> However one of the quirks regarding these domains on Tegra is that a
> fixed sequence exists that needs to be respected when enabling or
> disabling a power partition. The exact sequence can be found in the
> drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> function. Essentially we need to call into the clock and reset drivers
> at very specific moments during the operations that the PMC does.

I am not sure I fully understand how the power gating actually
happens. How is it triggered?

>
> One solution to this would be to make the needed clocks and resets
> available to the power domain driver via DT, but then we have the
> problem that two drivers would be controlling the same resources. For
> example drivers could still want to disable the clock for more fine-
> grained power management.

Sorry, but I think I need a better understanding to be able to comment.

But maybe, drivers could implement runtime PM support and define
runtime PM callbacks. From the callbacks those will handle clocks and
resets, is not that enough? What more is needed from a PM domain point
of view?

> Furthermore for some devices it may turn out
> that turning the domain off and on introduces too much latency to be
> useful.

This should be handled by the generic PM domain governor. Through the
per device QOS, you are able to set latencies constraints which could
prevent a PM domain from being gated.

>
> Does anyone have any better ideas on how to make that work with this
> generic PM domain framework? Or is Tegra just too special to be a good
> fit?

I certainly think it's worth a try, I would be surprised if we
shouldn't be able to address requirements from Tegra.

As you might have figured out, I am dedicated to improve the generic
power domain such it could fit more SOCs than today, thus I am also
hoping for more SOC to start to convert to it.

Kind regards
Uffe
