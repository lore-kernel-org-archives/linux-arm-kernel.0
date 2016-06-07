From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jun 2016 14:38:39 +0100
Subject: [PATCH] mmc: core: Fix mmc_select_hs200() regression in v4.7-rc.
In-Reply-To: <1465304543-23988-1-git-send-email-peter.griffin@linaro.org>
References: <1465304543-23988-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160607133839.GH18047@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jun 2016, Peter Griffin wrote:

> mmc_select_bus_width() returns bus width (4 or 8) on success or
> zero if unsupported. If bus width is set successfully we then wish
> to switch to HS200 mode.
> 
> This avoids the following error message in v4.70-rc2
> 
> [    2.523674] mmc0: mmc_select_hs200 failed, error 3
> [    2.528516] mmc0: error 3 whilst initialising MMC card
> 
> With this patch card is enumerated correctly
> 
> [    2.468065] mmc0: new HS200 MMC card at address 0001
> [    2.468335] mmcblk0: mmc0:0001 P1XXXX 7.20 GiB
> [    2.468441] mmcblk0boot0: mmc0:0001 P1XXXX partition 1 2.00 MiB
> [    2.468552] mmcblk0boot1: mmc0:0001 P1XXXX partition 2 2.00 MiB
> [    2.468651] mmcblk0rpmb: mmc0:0001 P1XXXX partition 3 128 KiB
> [    2.469269]  mmcblk0: p1
> 
> Fixes: 287980e (remove lots of IS_ERR_VALUE abuses)
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c984321..aafb73d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  	 * switch to HS200 mode if bus width is set successfully.
>  	 */
>  	err = mmc_select_bus_width(card);
> -	if (!err) {
> +	if (err > 0) {
>  		val = EXT_CSD_TIMING_HS200 |
>  		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	} else if (mmc_card_hs(card)) {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
> -		if (!err) {
> +		if (err > 0) {
>  			err = mmc_select_hs_ddr(card);
>  			if (err)
>  				goto free_card;

Looks like this has already been 'fixed' in -rc2.

Although, this patch does not work for me.

commit f741494363c6c90e6744117d2771bbdf0fb3c455
Author: Chen-Yu Tsai <wens@csie.org>
Date:   Sun May 29 15:04:42 2016 +0800

    mmc: fix mmc mode selection for HS-DDR and higher
    
    When IS_ERR_VALUE was removed from the mmc core code, it was replaced
    with a simple not-zero check. This does not work, as the value checked
    is the return value for mmc_select_bus_width, which returns the set
    bit width on success. This made eMMC modes higher than HS-DDR unusable.
    
    Fix this by checking for a positive return value instead.
    
    Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
    Cc: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Chen-Yu Tsai <wens@csie.org>
    Acked-by: Hans de Goede <hdegoede@redhat.com>
    Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
    Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
    Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
    Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c984321..5d438ad 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (!err) {
+	if (err >= 0) {
 		val = EXT_CSD_TIMING_HS200 |
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (!err) {
+		if (err >= 0) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
