From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Oct 2013 17:33:28 +0100
Subject: [RFC] of: Allow for experimental device tree bindings
In-Reply-To: <1382540779-6334-1-git-send-email-treding@nvidia.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
Message-ID: <5267FA58.9050002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2013 04:06 PM, Thierry Reding wrote:
> Past and recent discussions have shown that there's some concensus that
> device tree bindings should be considered an ABI and therefore need to
> remain backwards-compatible once code to implement them is included in
> the final release of a Linux kernel.
> 
> At the same time there is a desire to keep some manoeuvre while we're
> trying to figure things out. The fact is that many of us lack the
> experience to design good bindings from the start. At the same time
> there is a shortage of people that can review bindings and help design
> better ones.
> 
> Progress and the addition of new features (and restoration of features
> that used to work before the advent of DT for that matter) are blocked
> to a large degree because of that.
> 
> This patch attempts to restore some degree of freedom by introducing an
> easy way to mark device tree bindings as experimental as well as a way
> for users to disable the use of experimental bindings if they choose
> functionality at the cost of potential device tree incompatibilities.
> 
> Bindings are marked experimental by prefixing the compatible value with
> an exclamation mark (!). In order to make it clear that experimental
> bindings are undesirable in the long run, a warning will be output when
> an experimental binding is encountered.

> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig

> +static int of_compat_match(const char *device, const char *driver,
> +			   const struct device_node *np)
> +{
> +	const char *dev = device;
> +	const char *drv = driver;
> +
> +	if (device[0] == '!')
> +		device++;
> +
> +	if (driver[0] == '!')
> +		driver++;
> +
> +	if (of_compat_cmp(device, driver, strlen(driver)) != 0)
> +		return 0;

Do we really want to polute the drivers and DT files with a ! in the
compatible values? I thought we'd considered that, but chosen having the
drivers that use unstable bindings depend on a Kconfig option as an
alternative, not an additional step?

The one issue with doing this is that if a binding is thought to be
unstable, but becomes stable later without any changes, we'll have to do
busy-work to remove the ! in all the DT files, thus artificially
introducing an incompatibility. Perhaps that's fine though?
