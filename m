From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 9 Dec 2011 08:49:01 -0800
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <CAA+hA=Sx=tmnjsY_7EF8NciZO4PvgYOCgRNK9WsGpKmJ8X-r3g@mail.gmail.com>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
 <CAA+hA=Sx=tmnjsY_7EF8NciZO4PvgYOCgRNK9WsGpKmJ8X-r3g@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17518604C3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng wrote at Friday, December 09, 2011 8:03 AM:
...
> I agree that parsing data from device tree increases much effort
> because we can not using any help functions like microes in dts file and we have
> to construct the structure we need in driver by parsing that data.
> And it will increase dtsi file's size a lot when after adding all functions.
> 
> I wonder if we can define that data as a pdata in a .c file and only
> get a pointer from dts file. That would make life much easier.

You can't get pointers themselves directly from a .dts file, since the
.dts file author has no idea what the memory layout (or even which OS)
is present on the running system.

An alternative is to key off the compatible flag in the device tree,
and use that to index a table that points at the various structures you
want pointers to.

struct of_device_id's .data field, and the function of_match_device()
are for exactly that purpose; see the way the Tegra pinctrl driver that
I posted uses them for an example of mapping compatible flag to per-
SoC initialization function pointers.

-- 
nvpublic
