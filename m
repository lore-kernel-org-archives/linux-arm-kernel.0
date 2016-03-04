From: kvalo@qca.qualcomm.com (Valo, Kalle)
Date: Fri, 4 Mar 2016 08:34:55 +0000
Subject: [PATCH] ath9k: reduce stack usage in ar9003_aic_cal_post_process
References: <1455278130-1831694-1-git-send-email-arnd@arndb.de>
Message-ID: <87mvqezln6.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> In some configurations, this function uses more than the warning limit
> of 1024 bytes:
>
> drivers/net/wireless/ath/ath9k/ar9003_aic.c: In function 'ar9003_aic_cal_post_process':
> drivers/net/wireless/ath/ath9k/ar9003_aic.c:434:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>
> It turns out that there are two large arrays on the stack here, but
> almost all the data in them is never used outside of the loop in
> which it gets written, so we can replace the array with a single
> instance.
>
> The .valid flag is used later, so I'm replacing the array of structures
> with an array of bools. An obvious follow-up optimization would be
> to replace it with a bitmask and set_bit()/find_first_bit()/
> find_last_bit()/... operations. However, I have not tested this patch,
> so I sticked to the simpler transformation that does the job of
> reducing the stack usage to a harmless level.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to ath.git, thanks.

-- 
Kalle Valo
