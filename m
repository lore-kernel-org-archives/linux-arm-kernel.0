From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 24 Oct 2011 20:45:01 -0700
Subject: [PATCH] arm/tegra: Don't create duplicate gpio and pinmux devices
In-Reply-To: <1319218550-26002-1-git-send-email-swarren@nvidia.com>
References: <1319218550-26002-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B416D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Friday, October 21, 2011 11:36 AM:
...
> To avoid this duplicate registration, pass a parameter into *_pinmux_init()
> indicating whether they should register the device or not. Set this true
> for non-DT boards, and false otherwise.

Olof,

You'd asked if the same effect could be achieved simply setting up AUXDATA
entries so the DT and non-DT devices end up getting named the same, and
thus avoiding the duplicate registrations.

The answer is: this sort-of works, but apparently only by accident:

The static registration/probe through board-*-pinmux.c works as expected.

Then, when instantiating devs from DT, the AUXDATA /only/ sets the dev
name of the devs (and pdata if AUXDATA specificed it), but doesn't do
anything more; an attempt to register the dev from DT is still made, even
though a dev was already registered with that name. The first check that
catches this is a failure to create a sysfs entry for the dev, since the
name is the same. This is a WARN, or something with a very noisy backtrace.

That doesn't seem ideal; I think on balance I'd rather go with the original
patch. Hacking the DT code to check for already-existing names might be
an option, but since it's a temporary measure, I think hiding this in Tegra
code is better? Finally, for the upcoming T30 support, we really do want to
probe the pinmux from DT rather than ignoring the instantiation from DT, so
that the dev's OF node is available, and the driver can use a of_device_id
table to know which SoC version's data tables to use.

-- 
nvpublic
