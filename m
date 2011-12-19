From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Dec 2011 08:02:41 -0600
Subject: [PATCH 1/3] of/base: Take NULL string into account for property
 with multiple strings
In-Reply-To: <1323095036-3739-2-git-send-email-b-cousson@ti.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
 <1323095036-3739-2-git-send-email-b-cousson@ti.com>
Message-ID: <4EEF4401.1060303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2011 08:23 AM, Benoit Cousson wrote:
> The current implementation just ignore any NULL string inserted in a
> multiple strings property.
> In some cases we can have a property with a fix number of strings but
> not necessarily used, like for example in a list of valid pinmux modes.
> 
>  prop = "uart_rx", "uart_tx", "", "", "safe_mode";
> 
> Do no skip NULL string and take them into account in
> of_property_read_string_index and of_property_count_strings.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>

Applied. The others need Grant's agreement.

Rob

> ---
>  drivers/of/base.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9b6588e..b707243 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -752,7 +752,7 @@ int of_property_read_string_index(struct device_node *np, const char *propname,
>  
>  	for (i = 0; total < prop->length; total += l, p += l) {
>  		l = strlen(p) + 1;
> -		if ((*p != 0) && (i++ == index)) {
> +		if (i++ == index) {
>  			*output = p;
>  			return 0;
>  		}
> @@ -790,11 +790,9 @@ int of_property_count_strings(struct device_node *np, const char *propname)
>  
>  	p = prop->value;
>  
> -	for (i = 0; total < prop->length; total += l, p += l) {
> +	for (i = 0; total < prop->length; total += l, p += l, i++)
>  		l = strlen(p) + 1;
> -		if (*p != 0)
> -			i++;
> -	}
> +
>  	return i;
>  }
>  EXPORT_SYMBOL_GPL(of_property_count_strings);
