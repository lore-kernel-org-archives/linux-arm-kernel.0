From: bp@alien8.de (Borislav Petkov)
Date: Sun, 5 May 2013 22:29:46 +0200
Subject: [PATCH, RFC 11/22] iwlegacy: il_pm_ops is only provided for
 PM_SLEEP
In-Reply-To: <1367507786-505303-12-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-12-git-send-email-arnd@arndb.de>
Message-ID: <20130505202946.GB12757@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 05:16:15PM +0200, Arnd Bergmann wrote:
> This makes sure the conditionals for the declaration match the
> definition, so we provide the alternative
> 
>  #else
>  #define IL_LEGACY_PM_OPS NULL
>  #endif
> 
> in the correct cases.
> 
> drivers/built-in.o:(.data+0x57974): undefined reference to `il_pm_ops'

Yep, I see this too here.

> 
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: John W. Linville <linville@tuxdriver.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/iwlegacy/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/iwlegacy/common.h b/drivers/net/wireless/iwlegacy/common.h
> index f8246f2..734f1b4 100644
> --- a/drivers/net/wireless/iwlegacy/common.h
> +++ b/drivers/net/wireless/iwlegacy/common.h
> @@ -1832,7 +1832,7 @@ u32 il_usecs_to_beacons(struct il_priv *il, u32 usec, u32 beacon_interval);
>  __le32 il_add_beacon_time(struct il_priv *il, u32 base, u32 addon,
>  			  u32 beacon_interval);
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  extern const struct dev_pm_ops il_pm_ops;
>  
>  #define IL_LEGACY_PM_OPS	(&il_pm_ops)

Btw, you might want to adjust the macro comments for consistency too,
like so. Alternatively, you could simply remove them since they only
clutter two-liner and one can see what it encloses.

--
diff --git a/drivers/net/wireless/iwlegacy/common.h b/drivers/net/wireless/iwlegacy/common.h
index f8246f2d88f9..4caaf52986a4 100644
--- a/drivers/net/wireless/iwlegacy/common.h
+++ b/drivers/net/wireless/iwlegacy/common.h
@@ -1832,16 +1832,16 @@ u32 il_usecs_to_beacons(struct il_priv *il, u32 usec, u32 beacon_interval);
 __le32 il_add_beacon_time(struct il_priv *il, u32 base, u32 addon,
 			  u32 beacon_interval);
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops il_pm_ops;
 
 #define IL_LEGACY_PM_OPS	(&il_pm_ops)
 
-#else /* !CONFIG_PM */
+#else /* !CONFIG_PM_SLEEP */
 
 #define IL_LEGACY_PM_OPS	NULL
 
-#endif /* !CONFIG_PM */
+#endif /* !CONFIG_PM_SLEEP */
 
 /*****************************************************
 *  Error Handling Debugging
--

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
