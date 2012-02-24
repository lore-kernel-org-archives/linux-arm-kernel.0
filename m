From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 24 Feb 2012 08:44:37 -0800
Subject: [PATCH] pinctrl: make the pinmux-pins more helpful
In-Reply-To: <1330062969-25016-1-git-send-email-linus.walleij@stericsson.com>
References: <1330062969-25016-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BCC79@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Thursday, February 23, 2012 10:56 PM:
> The debugfs file pinmux-pins used to tell which function was
> enabled but now states simply which device owns the pin. Being
> owned by the pinctrl driver itself means just that it's hogged
> so be a bit more helpful by printing that.

> +		if (!desc->owner)
> +			owner = "UNCLAIMED";
> +		else if (!strcmp(desc->owner, pinctrl_dev_get_name(pctldev)))
> +			owner = "HOG";
> +		else
> +			owner = desc->owner;
> +
>  		seq_printf(s, "pin %d (%s): %s\n", pin,
>  			   desc->name ? desc->name : "unnamed",
> -			   desc->owner ? desc->owner : "UNCLAIMED");
> +			   owner);

Personally, I'd prefer not to make this change. I don't really like the
way we treat hogs as some kind of special-case; they work exactly like
any other pinctrl state (at least after the patch I posted to implemnt
pinctrl_select_state()), so I don't really see the need for special-casing
the debug information here.

If we do make a change like this, I'd prefer the format to be:

UNCLAIMED
"%s (HOG)", desc->owner
desc->owner

So that the ownership is always there in the standard format, but the
hog information is additional if you care about the special case.

> I somewhat mourn the loss of being able to tell from the debugfs
> which function is using a certain pin, does anyone have ideas on
> how to go about fixing this properly? The root file
> pinctrl-handles does tell it, but requires cross-referencing
> which isn't helpful.

This doesn't seem like a big deal to me; it's very easy to cross-
reference. That said, we could either:

a) Add a field to pin_desc which indicates current usage. This would be
set whenever the pin's mux function was set, i.e. in pinctrl_select_state()
or pinctrl_request_gpio().

b) Add a pinctrl driver ops function which reads and prints the current
state from HW.

(and note the fact that having the debug file list the current mux
function per pin doesn't really make sense on HW where the muxing is
per group...)

-- 
nvpublic
