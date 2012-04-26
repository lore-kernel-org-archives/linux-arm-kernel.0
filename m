From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 25 Apr 2012 23:28:32 -0700
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
Message-ID: <4F98EB10.2000505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 10:58 PM, Saravana Kannan wrote:
> Create a struct clk_init_data to hold all data that needs to be passed from
> the platfrom specific driver to the common clock framework during clock
> registration. Add a pointer to this struct inside clk_hw.
>
> This has several advantages:
> * Completely hides struct clk from many clock platform drivers and static
>    clock initialization code that don't care for static initialization of
>    the struct clks.
> * For platforms that want to do complete static initialization, it removed
>    the need to directly mess with the struct clk's fields while still
>    allowing to statically allocate struct clk. This keeps the code more
>    future proof even if they include clk-private.h.
> * Simplifies the generic clk_register() function and allows adding optional
>    fields in the future without modifying the function signature.
> * Simplifies the static initialization of clocks on all platforms by
>    removing the need for forward delcarations or convoluted macros.

<SNIP>

> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 90627e4..8ea11b4 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -167,6 +167,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>   {

<SNIP>

> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index b555a04..cbd2462 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -52,6 +52,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
>   {

<SNIP>

> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index 0021616..578465e 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -119,6 +119,7 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
>   {

<SNIP>

> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 6e58f11..8e97491 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>   {

I would really like to remove these functions. At least until we add 
device tree support where each clock is listed in device tree.

At present, these functions seem to be abused more than actually being 
used appropriately. IMHO, these should not be used to register clocks in 
your probe function by calling these functions one at a time. Just 
declare the clocks statically and call clk_register in a loop on them.

The only time I see these functions as being appropriate is when the 
list of clocks in your device is detected by actually probing (reading 
registers) HW or by parsing device tree (haven't followed it closely, 
but still seems to be work in progress).

Regards,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
