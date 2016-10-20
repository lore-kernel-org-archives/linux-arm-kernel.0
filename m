From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2016 11:52:20 +0200
Subject: [PATCH v2 3/6] ARM: at91: Add armv7m support
In-Reply-To: <20161020094135.18221-4-alexandre.belloni@free-electrons.com>
References: <20161020094135.18221-1-alexandre.belloni@free-electrons.com>
 <20161020094135.18221-4-alexandre.belloni@free-electrons.com>
Message-ID: <5506721.HBUId2vnJb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 20, 2016 11:41:32 AM CEST Alexandre Belloni wrote:
> +
> +static void __init samx7_dt_device_init(void)
> +{
> +       struct soc_device *soc;
> +       struct device *soc_dev = NULL;
> +
> +       soc = at91_soc_init(samx7_socs);
> +       if (soc)
> +               soc_dev = soc_device_to_device(soc);
> +
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
> +}

This was initially the idea for the soc_device, but we've stopped
using it as the parent for the on-chip devices a while ago.

Just register the device for identification here, and use
of_platform_default_populate with a NULL parent as most others do.

We should also investigate whether we can convert the three other
at91 variants to do the same without breaking expectations in user space.

	Arnd
