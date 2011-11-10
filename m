From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Nov 2011 09:57:48 +0100
Subject: [PATCH 1/4] arm/imx: fix mx3_defconfig to add FEC back
In-Reply-To: <1320914372-4416-2-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
 <1320914372-4416-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111110085748.GL13122@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 04:39:29PM +0800, Shawn Guo wrote:
> The commit 'd880db0 arm: mx3: update defconfig' removes FEC support
> which is not good, since FEC is useful for both developers and users.

$ git show d880db0^:drivers/net/Kconfig | grep -A4 'config FEC$'
config FEC
	bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
	depends on M523x || M527x || M5272 || M528x || M520x || M532x || \
		IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC
	default IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC if ARM

So when d880db0 was created

	make savedefconfig

dropped CONFIG_FEC=y justifiably. The culprit is commit

	230dec6 (net/fec: add imx6q enet support)

which dropped the default line.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
