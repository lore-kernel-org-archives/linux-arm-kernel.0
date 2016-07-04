From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 4 Jul 2016 10:17:09 +0100
Subject: [PATCH 3/4] bus: tegra-aconnect: make it explicitly non-modular
In-Reply-To: <20160703173040.23612-4-paul.gortmaker@windriver.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
 <20160703173040.23612-4-paul.gortmaker@windriver.com>
Message-ID: <577A2995.6020504@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 03/07/16 18:30, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/bus/Kconfig:config TEGRA_ACONNECT
> drivers/bus/Kconfig:    bool "Tegra ACONNECT Bus Driver"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.

In version 3 of the aconnect series [0] I had made this a tristate
because we allowed it to be removed and you had submitted a patch to
export the PM_CLK APIs. However, when discussing with Thierry he said
that we were unable to merge with tristate because of the dependency on
your patch. So he suggested we merge with bool for now and then change
it back to tristate for v4.9.

I understand that we should not do this, but we do plan to make this
modular in the future.

Cheers
Jon

[0] http://marc.info/?l=linux-tegra&m=146616753627760&w=2

-- 
nvpublic
