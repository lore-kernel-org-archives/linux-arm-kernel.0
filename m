From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2016 12:45:25 +0100
Subject: [PATCH 4/4] drivers/bus: make arm-ccn.c driver explicitly
 non-modular
In-Reply-To: <1459113058-14340-5-git-send-email-paul.gortmaker@windriver.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
 <1459113058-14340-5-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20160329114525.GC6745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 05:10:58PM -0400, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
> 
> config ARM_CCN
>         bool "ARM CCN driver support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We exchange module.h for moduleparam.h here since the driver uses
> module_param_named, and for now the easiest way to remain compatible
> with existing bootargs use cases is to leave this as-is.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.

I'd much rather fix the driver to build as a module, if at all possible.
Suzuki (CC'd) is taking a look at that, so please drop this patch for
now.

Will
