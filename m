From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jan 2014 12:12:10 +0100
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <20140115162210.GP15937@n2100.arm.linux.org.uk>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <15344443.B6eHZOpkXH@wuerfel> <20140115162210.GP15937@n2100.arm.linux.org.uk>
Message-ID: <201401161212.11246.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014, Russell King - ARM Linux wrote:
> The issue here is that we'll potentially now end up with three
> inversions.  One in the GPIO layers.  One in mmc_gpio_get_cd(), and
> another in every driver which uses the GPIO layer inversion.  This
> is hardly the right approach as it leads to multiple points where
> confusion about the inverted status can occur.

I did not mean to suggest adding a third inversion. We already have
to deal with the one in the GPIO layer and the one in mmc_gpio_get_cd(),
which I absolutely agree is unfortunate. As was pointed out already,
the gpio driver used in this system does not support the inversion
in the DT binding, so the only proper solution is to use the
inversion from mmc_gpio_get_cd if MMC_CAP2_CD_ACTIVE_HIGH is set
in host->caps2. This flag gets set from mmc_of_parse based
on the presence of the "cd-inverted" flag, in the absence of the
gpio flags. The dw_mmc driver does not use mmc_of_parse() at the
moment, and while it probably should use that in the future,
it should definitely read the same DT properties with the
same semantics already and not introduce new properties.

	Arnd
