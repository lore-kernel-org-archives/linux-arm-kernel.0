From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Sep 2012 12:40:35 -0600
Subject: [RFC 0/6] pinctrl: samsung: Remove static platform-specific data
In-Reply-To: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
Message-ID: <505CB4A3.9050707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 02:53 AM, Tomasz Figa wrote:
> This RFC series is a work on replacing static platform-specific data in
> pinctrl-samsung driver with data dynamically parsed from device tree.

Hmm. I tend to think this is exactly the opposite of the correct
direction; you end up wasting a whole ton of time during the boot
process parsing data out of the device tree only to end up with exactly
the same tables that you would have just put into the kernel anyway. Is
it really likely that future SoCs will change information such as the
width of the pullup/pulldown bitfield, but not change anything else
that's not already in this binding. If that isn't the case, the binding
won't be complete enough to describe any new features on future SoCs anyway.

> It aims at reducing the SoC-specific part of the driver and thus the
> amount of modifications to driver sources when adding support for next
> SoCs (like Exynos4x12).
> 
> Furthermore, moving definitions of pin banks to device tree will allow
> to simplify GPIO and GEINT specification to a format similar to used
> previously by gpiolib-based implementation, using a phandle to the bank
> and pin index inside the bank, e.g.
> 	gpios = <&gpa1 4 0>;
> 	interrupt-parent = <&gpa1>;
> 	interrupts = <4 0>;

I don't think those two are correlated; the GPIO specifier format could
just as easily be <bank pin> irrespective of whether the pinctrl driver
contains SoC-specific tables or not.

> Any comments are welcome.
> 
> TODO:
>  - bindings documentation

That's unfortunate; it would be the most interesting part to review. I
guess I'll try to work out the binding from the examples in patch 6.
