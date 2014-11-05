From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 4 Nov 2014 22:48:45 -0200
Subject: [PATCH] mmc: core: fix card detection regression
In-Reply-To: <1415146961-25993-1-git-send-email-kristina.martsenko@gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <1415146961-25993-1-git-send-email-kristina.martsenko@gmail.com>
Message-ID: <CAOMZO5CKB4aHTyYCvnT0UZCi4Pe+XyDa2-G1kpzyce1J3y3nfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kristina,

On Tue, Nov 4, 2014 at 10:22 PM, Kristina Mart?enko
<kristina.martsenko@gmail.com> wrote:
> Since commit 89168b489915 ("mmc: core: restore detect line inversion
> semantics"), the SD card on i.MX28 (and possibly other) devices isn't
> detected and booting stops at:
>
> [    4.120617] Waiting for root device /dev/mmcblk0p3...
>
> This is caused by the MMC_CAP2_CD_ACTIVE_HIGH flag being set incorrectly
> when the host controller doesn't use a GPIO for card detection (but
> instead uses a dedicated pin). In this case mmc_gpiod_request_cd() will
> return before assigning to the gpio_invert variable, leaving the
> variable uninitialized. The variable then gets used to set the flag.
> This patch fixes the issue by making sure gpio_invert is set to false
> when a GPIO isn't used. After this patch, i.MX28 boots fine.
>
> The MMC_CAP2_RO_ACTIVE_HIGH (write protect) flag is also set incorrectly
> for the exact same reason (it uses the same uninitialized variable), so
> this patch fixes that too.
>
> Fixes: 89168b489915 ("mmc: core: restore detect line inversion semantics")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Kristina Mart?enko <kristina.martsenko@gmail.com>

This fixes mx28 card detection, thanks!

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
