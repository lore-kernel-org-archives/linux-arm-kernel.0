From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 25 Feb 2015 19:52:25 +0100
Subject: [PATCH 1/2] mmc: dw_mmc: Only enable CD after setup and only
 if needed
In-Reply-To: <1424887912-20015-1-git-send-email-dianders@chromium.org>
References: <1424887912-20015-1-git-send-email-dianders@chromium.org>
Message-ID: <54EE19E9.9090501@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 02/25/2015 07:11 PM, Doug Anderson wrote:
> We really don't want to get a card detect interrupt during probe time
> since it can confuse things.  Let's disable the card detect interrupt
> until we're in a really good place: the end of probe.  Let's also
> simply avoid enabling the card detect interrupt if it's not used.
> 
> It appears that (at least on rk3288) when vqmmc is turned on it can
> cause a bogus "card detect" interrupt.  That meant that we were
> getting a predictable card detect interrupt while we were in
> mmc_add_host().  On the version of the kernel I'm working with at
> least (3.14), this is not a great time to get a card detect interrupt
> since I think that we don't grab all the needed locks in
> mmc_add_host() and children.  I put stack dumps in dw_mci_setup_bus()
> and found that I could see two distinct stack crawls that looked like:
> 
> Caller one:
> * dw_mci_setup_bus
> * dw_mci_set_ios
> * mmc_power_up
> * mmc_start_host
> * mmc_add_host
> 
> Caller two:
> * dw_mci_setup_bus
> * dw_mci_set_ios
> * mmc_set_chip_select
> * mmc_go_idle
> * mmc_rescan
> * process_one_work
> * worker_thread
> * kthread
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
