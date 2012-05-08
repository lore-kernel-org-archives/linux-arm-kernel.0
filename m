From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 May 2012 15:38:09 -0700
Subject: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
In-Reply-To: <1336506724-5494-4-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Wed, 9 May 2012 01:22:03 +0530")
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
 <1336506724-5494-4-git-send-email-hvaibhav@ti.com>
Message-ID: <87397ajo32.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> The function __omap2_set_globals() can be common across all
> platforms/architectures, even in case of omap4, internally it
> calls same set of functions as in __omap2_set_globals() function
> (except for sdrc).

OK so far.

> This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
> so that we can reuse same function across omap2/3/4...

But what happens when a single kernel is built that has support for an
SoC with an SDRC (OMAP4) and one that doesn't (AM33xx)?

In that case this new SOC_HAS_OMAP2_SDRC will be set, and
set_globals_sdrc() will be called even for the SoCs without SDRC.

So, rather than add a new Kconfig option for this, I would rather see 
you using the existing runtime feature check for the SDRC: omap_has_sdrc()

Kevin
