From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 May 2014 07:24:50 -0500
Subject: [PATCH v3] of: Keep track of populated platform devices
In-Reply-To: <1399981716-24618-1-git-send-email-pawel.moll@arm.com>
References: <1399473437.3706.25.camel@hornet>
 <1399981716-24618-1-git-send-email-pawel.moll@arm.com>
Message-ID: <CAL_Jsq+8xZO0LEhVa4tmOfq6CD2a0O+0CaGCnZLqDguz=yN_zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 6:48 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> In "Device Tree powered" systems, platform devices are usually
> massively populated with of_platform_populate() call, executed
> at some level of initcalls, either by generic architecture
> or by platform-specific code.
>
> There are situations though where certain devices must be
> created (and bound with drivers) before all the others.
> This presents a challenge, as devices created explicitly
> would be created again by of_platform_populate().
>
> This patch tries to solve that issue in a generic way,
> adding a "populated" flag for a DT node description.
> Once set, this device will never be created again via
> of_* API, so of_platform_populate() will skip such nodes
> (and its children) in a similar way to the non-available
> ones.
>
> The flag is cleared when a device is being removed and
> returns the DT node by calling of_device_node_put() (it
> was missing from the amba device release function, added).
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

A few formatting nits, but otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

[..]

> @@ -206,12 +206,13 @@ static struct platform_device *of_platform_device_create_pdata(
>  {
>         struct platform_device *dev;
>
> -       if (!of_device_is_available(np))
> +       if (!of_device_is_available(np) ||
> +                       of_node_test_and_set_flag(np, OF_POPULATED))

This should be lined up with the ! on the previous line.


> @@ -264,14 +269,15 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>
>         pr_debug("Creating amba device %s\n", node->full_name);
>
> -       if (!of_device_is_available(node))
> +       if (!of_device_is_available(node) ||
> +                       of_node_test_and_set_flag(node, OF_POPULATED))

And this one.

>                 return NULL;

Rob
