From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 7 Jan 2014 14:00:19 +0100
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
In-Reply-To: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
References: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140107140019.7220eed6@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sylwester Nawrocki wrote:
> Ensure clk->kref is dereferenced only when clk is not NULL.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Hi Sachin,
> 
> please try if this patch fixes the exyno5420 boot crash.
> 
> Thanks,
> Sylwester
> 
>  drivers/clk/clk.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e3e0327..a1fe86f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2179,24 +2179,25 @@ EXPORT_SYMBOL_GPL(devm_clk_unregister);
>   */
>  int __clk_get(struct clk *clk)
>  {
> -	if (clk && !try_module_get(clk->owner))
> -		return 0;
> +	if (clk) {
> +		if (!try_module_get(clk->owner))
> +			return 0;
> 
This change is unnecessary! The part after the && is only evaluated
when clk is not NULL.

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
