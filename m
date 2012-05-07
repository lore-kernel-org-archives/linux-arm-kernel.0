From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 May 2012 13:07:39 -0600 (MDT)
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120504223933.GX5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
Message-ID: <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 4 May 2012, Tony Lindgren wrote:

> How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> Then this becomes just:
> 
> #ifdef CONFIG_SOC_OMAP3PLUS

We might want to consider having separate CONFIG_SOC_* values for each 
SoC.  So rather than CONFIG_SOC_OMAP3PLUS, we'd have CONFIG_SOC_OMAP3430, 
CONFIG_SOC_OMAP3630, etc.

This would be for two main reasons.  One is that Kconfig options like 
CONFIG_SOC_OMAP3PLUS don't have much meaning.  It is really unclear to me 
what SoCs would be included in CONFIG_SOC_OMAP3PLUS, since some of them 
differ so radically -- different interconnects, different power and system 
management IP blocks, different CPU subsystems, different RAM controllers, 
etc.  The advantage of using SoC-specific Kconfig options, from this point 
of view, is that it is easy to know what they mean.  Then those 
SoC-specific Kconfig options can select the appropriate SoC-independent 
interconnect driver, PRCM drivers, CPU options, etc.

The other motivation would be to support device manufacturers who only 
wish to build a kernel for the single device that they are shipping.  In 
terms of kernels shipped, this is probably the most popular use-case. With 
something like CONFIG_SOC_OMAPAM33XX, they can avoid building quite a bit 
of code and data (and potentially bugs) that are not needed for their 
specific device.


- Paul
