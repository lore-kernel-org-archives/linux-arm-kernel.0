From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 16:54:31 +0100
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <52D6A9FF.3000603@linaro.org>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <002c01cf11ff$6790a8a0$36b1f9e0$%jun@samsung.com>
 <52D6A9FF.3000603@linaro.org>
Message-ID: <201401151654.31843.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014, zhangfei wrote:
> 
> On 01/15/2014 10:38 PM, Seungwon Jeon wrote:
> >> Hmm, looks you are right.
> >> Though not see clearly mmc_gpio_get_cd declaratoin, other drivers
> >> directly set get_cd as mmc_gpio_get_cd.
> >> .get_cd	= mmc_gpio_get_cd
> >>
> >> However, in our board cd =0 when card is deteced while cd=1 when card is
> >> removed.
> >> In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> >> set, as well as new property "caps2-mmc-cd-active-low".
> > 
> > Ok, you could do more.
> > mmc_gpio_get_cd() is expected to return non-zero if card is detection.
> 
> > I think your board seems not to use pull-up on GPIO line for card detection.
> > So, MMC_CAP2_CD_ACTIVE_HIGH would be needed.
> 
> Unfortunately, the specific cd pin can not be configured.
> Suspect on our board the cd =1 when card is inserted, can not measure as
> no clear resister and need check with hardware guy tomorrow.
> 
> "cd-inverted" may be required as mentioned by Arnd.
> Will update the patch as following if no problem.

The patch looks right, but I wonder if a better longer-term
solution would be to just the common mmc_of_parse() function
rather than duplicating it in dw_mmc.

	Arnd
