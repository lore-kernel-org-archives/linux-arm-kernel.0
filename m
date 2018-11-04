From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:34:31 +0100
Subject: [PATCH 11/15] x86, olpc: Use a correct version when making up a
 battery node
In-Reply-To: <20181010172300.317643-12-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-12-lkundrak@v3.sk>
Message-ID: <20181104123430.GD23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:56, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/x86/platform/olpc/olpc_dt.c | 59 +++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
> index d6ee92986920..6e54e116b0c5 100644
> --- a/arch/x86/platform/olpc/olpc_dt.c
> +++ b/arch/x86/platform/olpc/olpc_dt.c
> @@ -218,10 +218,28 @@ static u32 __init olpc_dt_get_board_revision(void)
>  	return be32_to_cpu(rev);
>  }
>  
> -void __init olpc_dt_fixup(void)
> +int olpc_dt_compatible_match(phandle node, const char *compat)
>  {
> -	int r;
>  	char buf[64];
> +	int plen;
> +	char *p;
> +	int len;
> +
> +	plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
> +	if (plen <= 0)
> +		return 0;
> +
> +	len = strlen(compat);
> +	for (p = buf; p < buf + plen; p += strlen(p) + 1) {
> +		if (strcmp(p, compat) == 0)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +void __init olpc_dt_fixup(void)
> +{
>  	phandle node;
>  	u32 board_rev;
>  
> @@ -229,32 +247,33 @@ void __init olpc_dt_fixup(void)
>  	if (!node)
>  		return;
>  
> -	/*
> -	 * If the battery node has a compatible property, we are running a new
> -	 * enough firmware and don't have fixups to make.
> -	 */
> -	r = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
> -	if (r > 0)
> -		return;
> -
> -	pr_info("PROM DT: Old firmware detected, applying fixes\n");
> -
> -	/* Add olpc,xo1-battery compatible marker to battery node */
> -	olpc_dt_interpret("\" /battery at 0\" find-device"
> -		" \" olpc,xo1-battery\" +compatible"
> -		" device-end");
> -
>  	board_rev = olpc_dt_get_board_revision();
>  	if (!board_rev)
>  		return;
>  
>  	if (board_rev >= olpc_board_pre(0xd0)) {
> +		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
> +			return;
> +
> +		/* Add olpc,xo1.5-battery compatible marker to battery node */
> +		olpc_dt_interpret("\" /battery at 0\" find-device"
> +			" \" olpc,xo1.5-battery\" +compatible"
> +			" device-end");
> +
> +		/* We're running a very old firmware if this is missing. */
> +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
> +			return;
> +
>  		/* XO-1.5: add dcon device */
>  		olpc_dt_interpret("\" /pci/display at 1\" find-device"
>  			" new-device"
>  			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
>  			" finish-device device-end");
>  	} else {
> +		/* We're running a very old firmware if this is missing. */
> +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
> +			return;
> +
>  		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
>  		olpc_dt_interpret("\" /pci/display at 1,1\" find-device"
>  			" new-device"
> @@ -264,6 +283,11 @@ void __init olpc_dt_fixup(void)
>  			" \" olpc,xo1-rtc\" +compatible"
>  			" device-end");
>  	}
> +
> +	/* Add olpc,xo1-battery compatible marker to battery node */
> +	olpc_dt_interpret("\" /battery at 0\" find-device"
> +		" \" olpc,xo1-battery\" +compatible"
> +		" device-end");
>  }
>  
>  void __init olpc_dt_build_devicetree(void)
> @@ -289,6 +313,7 @@ void __init olpc_dt_build_devicetree(void)
>  /* A list of DT node/bus matches that we want to expose as platform devices */
>  static struct of_device_id __initdata of_ids[] = {
>  	{ .compatible = "olpc,xo1-battery" },
> +	{ .compatible = "olpc,xo1.5-battery" },
>  	{ .compatible = "olpc,xo1-dcon" },
>  	{ .compatible = "olpc,xo1-rtc" },
>  	{},

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/d2ffb676/attachment.sig>
