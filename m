From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Aug 2010 16:55:27 -0600
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
Message-ID: <AANLkTi=CRCKO3Vjsm3K+OZO1Ea=oGcZovEzfw71r=gtM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Implement the new runtime PM framework as a thin layer on top of the
> omap_device API. ?Since we don't have an OMAP-specific bus, override
> the runtime PM hooks for the platform_bus for the OMAP specific
> implementation.
[...]
> +int platform_pm_runtime_suspend(struct device *dev)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct omap_device *odev = to_omap_device(pdev);
> + ? ? ? int r, ret = 0;
> +
> + ? ? ? dev_dbg(dev, "%s\n", __func__);
> +
> + ? ? ? if (dev->driver->pm && dev->driver->pm->runtime_suspend)
> + ? ? ? ? ? ? ? ret = dev->driver->pm->runtime_suspend(dev);
> + ? ? ? if (!ret && omap_device_is_valid(odev)) {
> + ? ? ? ? ? ? ? r = omap_device_idle(pdev);
> + ? ? ? ? ? ? ? WARN_ON(r);

For the record, I should note here that this is *really* dangerous.
When handed a random platform_device pointer, it is not safe to use
to_omap_device() and dereference it with omap_device_is_valid().
There are no guarantees that the dereference is actually valid,
particularly so when the platform_device has been dynamically
allocated.

It is only okay to use to_omap_device() when the code is already
absolutely sure that the platform_device is in fact contained by a
struct omap_device.  There needs to be a different method to test if
it is contained by an omap_device before doing the dereference.
