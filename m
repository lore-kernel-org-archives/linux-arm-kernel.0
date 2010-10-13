From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Oct 2010 16:08:50 -0400 (EDT)
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <1286955116-22793-1-git-send-email-ohad@wizery.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
Message-ID: <alpine.LFD.2.00.1010131602590.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Oct 2010, Ohad Ben-Cohen wrote:

> Fix SDIO suspend/resume regression introduced by
> 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e "mmc: fix all hangs related to
> mmc/sd card insert/removal during suspend/resume":
> 
> [ 5647.295953] PM: Syncing filesystems ... done.
> [ 5647.318792] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [ 5647.337048] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> [ 5647.356915] Suspending console(s) (use no_console_suspend to debug)
> [ 5647.366651] pm_op(): platform_pm_suspend+0x0/0x5c returns -38
> [ 5647.366671] PM: Device pxa2xx-mci.0 failed to suspend: error -38
> [ 5647.367082] PM: Some devices failed to suspend
> 
> 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e moved the card removal/insertion
> mechanism out of MMC's suspend/resume path and into pm notifiers
> (mmc_pm_notify), and that broke SDIO's expectation that mmc_suspend_host()
> will remove the card, and squash the error, in case -ENOSYS is returned
> from the bus suspend handler (mmc_sdio_suspend() in this case).
> 
> mmc_sdio_suspend() is using this whenever at least one of the card's SDIO
> function drivers does not have suspend/resume handlers - in that case
> it is agreed to force removal of the entire card.
> 
> This patch fixes this regression by trivially bringing back that part of
> mmc_suspend_host(), which was removed by 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e.
> 
> Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: <stable@kernel.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> --
> 
> It may still be desired to further clean this area up by using the card
> removal mechanism in mmc_pm_notify() for SDIO as well.
> 
> To use mmc_pm_notify's card-removal code also for SDIO, we need it
> to check if all the SDIO functions have suspend handlers. That
> would probably make us add a new bus_ops handler (something like
> host->bus_ops->remove_card_on_suspend ?).
> 
> It's starting to get a bit complicated though, and I'm not sure it
> would make the code a lot more readable.
> 
> In addition, this would still not work for drivers like libertas sdio,
> which do have a suspend handler, but sometimes let it return -ENOSYS,
> expecting mmc_suspend_host() to remove the card and squash the error.
> For those cases, we still need the old card-removal logic in mmc_suspend_host().
> 
> This brings up a question whether libertas_sdio really needs this
> functionality; When MMC_PM_KEEP_POWER is not needed, can't it just return 0
> (and as a result the card will be powered down, but not removed) ?

It could, but then there has to be extra code in the resume handler to 
cope with the fact that the card was powered off.  When the card is 
simply removed, then redetecting and reinserting the card on resume is 
trivial.


Nicolas
