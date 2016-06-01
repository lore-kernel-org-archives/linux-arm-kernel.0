From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 1 Jun 2016 11:58:34 -0700
Subject: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
In-Reply-To: <1464505484-3661-2-git-send-email-wens@csie.org>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <1464505484-3661-2-git-send-email-wens@csie.org>
Message-ID: <CAOCOHw7aHvSUUoxkrDkGwNrTGNbZm-3RSuhJF3CCvRUiK5tDgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2016 at 12:04 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> with a simple not-zero check. This does not work, as the value checked
> is the return value for mmc_select_bus_width, which returns the set
> bit width on success. This made eMMC modes higher than HS-DDR unusable.
>
> Fix this by checking for a positive return value instead.

mmc_select_bus_width() can return 0 on "success" as well and the
previous check was !IS_ERR_VALUE(err), which coverts that. So I
believe these checks should be for err >= 0 rather than just > 0.


Either way this fixes the boot failures seen on my Qualcomm based
boards with v4.7-rc1.

Regards,
Bjorn
