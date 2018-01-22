From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Jan 2018 16:23:11 +0530
Subject: [PATCH 1/6] mfd: syscon: Add syscon_register() function
In-Reply-To: <1516418424-28686-2-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
 <1516418424-28686-2-git-send-email-david@lechnology.com>
Message-ID: <75ad5a5e-319e-75d3-c1c7-15e7518d424b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 08:50 AM, David Lechner wrote:
> This adds a new syscon_register() function that creates a new syscon
> regmap and adds it to the lookup list.
> 
> This function serves two purposes:
> 
> 1. This is needed for platforms without device tree support where the
>    syscon regmap is needed in early boot (e.g. clocks), because using a
>    platform driver at this point in boot is not an option.

Is this because platform_device_register() of the syscon device fails
when called early on? It will be nice to document the exact failure case
here (at least the return value) so its clear what the issue is.

> 2. It allows other drivers to use syscon_regmap_lookup_by_compatible()
>    for both device tree and non-DT platforms instead of having to have
>    a separate case that calls syscon_regmap_lookup_by_pdevname().

"compatible" is a very device-tree specific terminology so I am afraid
this is will actually turn out to be confusing.

So, if we are doing this, I would rather be more explicit about it:

/*
 * registers a "global" syscon "device", usually not backed by a real
 * device. To be used only in cases where the syscon is not
 * related to any actual device, like system clocks, for example.
 *
 * name passed here must be globally unique.
 */
struct regmap *syscon_register_by_name(resource_size_t start, size_t
				       size, const char *name);

and

struct regmap *syscon_regmap_lookup_by_name(const char *name);

I understand, with this the driver becomes little more complicated and
DT and non-DT cases still need to be handled differently. But I think
thats not the main issue you are trying to solve.

> 
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks,
Sekhar
