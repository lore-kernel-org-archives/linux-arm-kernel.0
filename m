From: robh@kernel.org (Rob Herring)
Date: Fri, 7 Sep 2018 10:08:18 -0500
Subject: [PATCH] clk: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-12-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-12-robh@kernel.org>
Message-ID: <CAL_JsqLR_jsVScGBp0cMfhNJrw4bYOAychWX3Ejw1DBzTpRK+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 8:53 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.


> @@ -492,8 +492,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>
>         provider->base = of_iomap(node, 0);
>
> -       provider->clkdm_name = kmalloc(strlen(node->parent->name) + 3,
> -                                      GFP_KERNEL);
> +       provider->clkdm_name = kasprintf(GFP_KERNEL, "%pOFnxxx", node->parent);

Turns out xxx was a bad choice as the %p handler eats all alphanumeric
characters. Looks like this has already been applied, so I will send a
fix.

Rob
