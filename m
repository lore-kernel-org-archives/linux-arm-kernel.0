From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Oct 2013 22:04:02 +0200
Subject: [PATCH 3/3] [RFC] ARM: prepare ARMv7-M for MULTIPLATFORM use
In-Reply-To: <201309301234.25913.arnd@arndb.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380534577-15076-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309301234.25913.arnd@arndb.de>
Message-ID: <20131003200402.GD10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 12:34:25PM +0200, Arnd Bergmann wrote:
> On Monday 30 September 2013, Uwe Kleine-K?nig wrote:
> > v7-M is a third group that is incompatible with both v4/v5 and v6/v7.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > This behaves strange but I think is robust not to allow broken configs:
> > 
> > When v4/v5 is selected, v6/v7 and v7m are available for enabling, too.
> > When v6/v7 is selected the other choices are disabled
> > When v7m is selected only v6/v7 are available for enabling.
> 
> The Kconfig stuff all looks good, 
Actually this is a choice implemented using normal configs. Why not a
using a choice here:

choice
	prompt "CPU Core family selection"

config ARCH_MULTI_V4_V5
	bool "..."

config ARCH_MULTI_V6_V7
	bool "..."

config ARCH_MULTI_V7M
	bool "..."

endchoice

config ARCH_MULTI_V4T
	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
	depends on ARCH_MULTI_V4_V5

config ARCH_MULTI_V5
	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)" if ARCH_MULTI_V4T
	depends on ARCH_MULTI_V4_V5
	default y if !ARCH_MULTI_V4T

config ARCH_MULTI_V6
	...

config ARCH_MULTI_V7
	...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
