From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jul 2013 18:07:39 +0100
Subject: [PATCH v3 6/7] USB: ohci-at91: add usb_clk for transition to
 common clk framework
In-Reply-To: <1373988136-24622-1-git-send-email-b.brezillon@overkiz.com>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
 <1373988136-24622-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130716170739.GE24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 05:22:15PM +0200, Boris BREZILLON wrote:
> @@ -41,6 +41,10 @@ extern int usb_disabled(void);
>  
>  static void at91_start_clock(void)
>  {
> +	if (uclk) {

	if (!IS_ERR(uclk)) {

> +		clk_set_rate(uclk, 48000000);
> +		clk_prepare_enable(uclk);
> +	}
>  	clk_prepare_enable(hclk);
>  	clk_prepare_enable(iclk);
>  	clk_prepare_enable(fclk);
> @@ -52,6 +56,8 @@ static void at91_stop_clock(void)
>  	clk_disable_unprepare(fclk);
>  	clk_disable_unprepare(iclk);
>  	clk_disable_unprepare(hclk);
> +	if (uclk)

	if (!IS_ERR(uclk))

> +		clk_disable_unprepare(uclk);
>  	clocked = 0;
>  }
>  
> @@ -144,6 +150,11 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err2;
>  	}
>  
> +	uclk = clk_get(&pdev->dev, "usb_clk");
> +	if (IS_ERR(uclk)) {
> +		uclk = NULL;

Remove this line.

> +		dev_warn(&pdev->dev, "failed to get usb_clk\n");
> +	}
>  	iclk = clk_get(&pdev->dev, "ohci_clk");
>  	if (IS_ERR(iclk)) {
>  		dev_err(&pdev->dev, "failed to get ohci_clk\n");
> @@ -212,10 +223,11 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
>  	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>  	usb_put_hcd(hcd);
>  

What if uclk is NULL here?

	if (!IS_ERR(uclk))

> +	clk_put(uclk);
>  	clk_put(hclk);
>  	clk_put(fclk);
>  	clk_put(iclk);
> -	fclk = iclk = hclk = NULL;
> +	fclk = iclk = hclk = uclk = NULL;

Don't.

Range of invalid struct clk pointers: those which IS_ERR(clk) returns true.
Therefore, the range of valid struct clk pointers is: _____________________
(answer on a post card, stamped and addressed to...)
