From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Tue, 21 Sep 2010 08:51:54 +0300
Subject: [PATCH v6 5/7] wl1271: make ref_clock configurable by board
In-Reply-To: <1284593511-30052-1-git-send-email-ohad@wizery.com>
References: <1284593511-30052-1-git-send-email-ohad@wizery.com>
Message-ID: <1285048314.17849.20.camel@powerslave>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 01:31 +0200, ext Ohad Ben-Cohen wrote:
> The wl1271 device is using a reference clock that may change
> between board to board.
> 
> Make the ref_clock parameter configurable by board settings
> instead of having a hard coded value in the sources.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>

With some small cosmetic comments below.


> diff --git a/drivers/net/wireless/wl12xx/wl1271_boot.c b/drivers/net/wireless/wl12xx/wl1271_boot.c
> index f36430b..fc21db8 100644
> --- a/drivers/net/wireless/wl12xx/wl1271_boot.c
> +++ b/drivers/net/wireless/wl12xx/wl1271_boot.c
> @@ -457,17 +457,20 @@ int wl1271_boot(struct wl1271 *wl)
>  {
>  	int ret = 0;
>  	u32 tmp, clk, pause;
> +	int ref_clock = wl->ref_clock;

I guess you don't need this local ref_clock.  Can't you just use
wl->ref_clock directly?

 
>  	wl1271_boot_hw_version(wl);
>  
> -	if (REF_CLOCK == 0 || REF_CLOCK == 2 || REF_CLOCK == 4)
> +	if (ref_clock == 0 || ref_clock == 2 || ref_clock == 4)
>  		/* ref clk: 19.2/38.4/38.4-XTAL */
>  		clk = 0x3;
> -	else if (REF_CLOCK == 1 || REF_CLOCK == 3)
> +	else if (ref_clock == 1 || ref_clock == 3)
>  		/* ref clk: 26/52 */
>  		clk = 0x5;
> +	else
> +		return -EINVAL;
>  
> -	if (REF_CLOCK != 0) {
> +	if (ref_clock != 0) {
>  		u16 val;
>  		/* Set clock type (open drain) */
>  		val = wl1271_top_reg_read(wl, OCP_REG_CLK_TYPE);
> @@ -516,7 +519,7 @@ int wl1271_boot(struct wl1271 *wl)
>  	wl1271_debug(DEBUG_BOOT, "clk2 0x%x", clk);
>  
>  	/* 2 */
> -	clk |= (REF_CLOCK << 1) << 4;
> +	clk |= (ref_clock << 1) << 4;

While you're@it, you could remove this useless /* 2 */ comment from
here.  This was a reference to TI's reference driver, but the need for
it is loooong gone. ;)


> diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
> index bd70563..95deae3 100644
> --- a/include/linux/wl12xx.h
> +++ b/include/linux/wl12xx.h
> @@ -29,6 +29,7 @@ struct wl12xx_platform_data {
>  	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
>  	int irq;
>  	bool use_eeprom;
> +	int board_ref_clock;

Could we add a comment here explaining the possible values for ref_clock
and what they mean?

I guess it's something like this:

0 = 19.2
1 = 26
2 = 38.4
3 = 52
4 = 38.4 XTAL


-- 
Cheers,
Luca.
