From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Mar 2014 11:54:26 +0800
Subject: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
In-Reply-To: <530B594F.2030500@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk> <530B594F.2030500@ti.com>
Message-ID: <20140303035426.GC2411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 08:38:07AM -0600, Nishanth Menon wrote:

> Intent here is to allow drivers such as cpufreq-cpu0 to be reused on
> platforms such as TI's OMAP derivatives, and other SoCs which differ
> only by the sequence involved in voltage scale operations. So, this
> patch provides a framework for registering the underlying
> implementation of the SoC specific voltage change methodology.

That bit is clear, what's very opaque from the code is how this is going
to be accomplished.

> Overall the sequence takes place after this patch is as follows:
> a) voltage domain drivers such as those of TI or others register with
> voltage domain with devm_voltdm_register.
> b) cpufreq-cpu0/devfreq drivers:
> of_pm_voltdm_notifier_register(introduced as part of patch #1) to
> register notifiers around clk of interest. This request is linked to
> the specific voltage domain using phandle in device tree.
> c) when cpufreq-cpu0/devfreq does a clk_set_rate, the common clock
> framework triggers notifiers in voltage domain core which in turn,
> invokes the corresponding handlers for the voltage domain driver
> ensuring the right dvfs sequence specific to the SoC is triggered.

So the first question I have here is what happens if multiple clocks
need to be updated in lock step - if we're only triggering off clock
notifiers that seems tricky.  The other thing here is that the fact that
your API is "of_" suggests that it is in fact linked very srongly to DT
- it'd be good to split out the layers to make sure things make sense
standalone, the DT helpers are obviously good but the API should be able
to stand separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/73db7b2b/attachment.sig>
