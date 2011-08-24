From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 24 Aug 2011 21:22:21 +0800
Subject: [PATCH 1/2] mmc: sdhci move vmmc to set_ios
In-Reply-To: <1311663973-23715-2-git-send-email-zhangfei.gao@marvell.com>
References: <1311663973-23715-1-git-send-email-zhangfei.gao@marvell.com>
	<1311663973-23715-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <CAMj5BkhyPtbFJfpDKssoWiTDbjAjwy5TuJJa8zATrBOCjuENSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 3:06 PM, Zhangfei Gao <zhangfei.gao@marvell.com> wrote:
> Move vmmc to set_ios, as a result mmc_power_up/down handles regulator_enable/disable vmmc
> Move regulator outof spin_lock, since usually i2c operation is called
> Remove vmmc from suspend/resume function, instead vmmc is handled properly in mmc_suspend/resume_host according to mmc_card_keep_power
>
> CC: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> ?drivers/mmc/host/sdhci.c ?| ? 27 +++++++++++++++------------
> ?include/linux/mmc/sdhci.h | ? ?1 +
> ?2 files changed, 16 insertions(+), 12 deletions(-)
>

Hi, Daniel

We found some impact to sd if reusing vmmc in set_ios, when no sd card
is inserted.
When no sd card, CD pin is high, but when vmmc is disabled in
mmc_power_down, as a result CD pin will be pulled down, which is same
as sd card is inserted, however the card detect will fail since no sd
card in fact.

So additional regulator vsdio still required to control power of
vsdio, to make mmc_power_up/down control sdio power.

Thanks
