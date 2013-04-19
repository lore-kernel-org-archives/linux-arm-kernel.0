From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 19 Apr 2013 22:53:50 +0000 (UTC)
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <201304200008.28716.arnd@arndb.de>
References: <5170B4C6.1030300@gmail.com> <201304192258.36276.arnd@arndb.de>
 <20130419215134.GY10155@atomide.com> <201304200008.28716.arnd@arndb.de>
Message-ID: <alpine.DEB.2.00.1304192249250.24986@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 20 Apr 2013, Arnd Bergmann wrote:

> I think part of the problem is the way the Makefile is laid
> out, e.g.
> 
> clockdomain-common                      += clockdomain.o
> obj-$(CONFIG_ARCH_OMAP2)                += $(clockdomain-common)
> obj-$(CONFIG_ARCH_OMAP3)                += $(clockdomain-common)
> obj-$(CONFIG_ARCH_OMAP4)                += $(clockdomain-common)
> obj-$(CONFIG_SOC_AM33XX)                += $(clockdomain-common)
> obj-$(CONFIG_SOC_OMAP5)                 += $(clockdomain-common)
> 
> This results in building clockdomain.o whenever any of the various
> SoCs are enabled, but not when none of them are enabled.
> 
> However, according to the error messages, this driver is actually
> referenced by code that is enabled unconditionally.

Seems to me that's where the issue is: in the code that uses it, like 
omap_hwmod.o.  If we're not building code for any OMAP SoCs, it seems 
rather pointless to build omap_hwmod.o -- at least until omap_hwmod.o is 
moved out into drivers/.


- Paul
