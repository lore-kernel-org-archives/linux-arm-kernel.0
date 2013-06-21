From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 15:31:39 -0600
Subject: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
In-Reply-To: <1371838198-7327-2-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-2-git-send-email-gsi@denx.de>
Message-ID: <51C4C63B.3030300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> update the device tree binding documentation for the GPIO matrix keypad
> driver: mention the driver's selecting all columns at once, reword the
> delay descriptions, add the missing active low GPIO pin level property

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

Presumably the changes to this file simply seek to precisely document
the HW that this binding supports, and do not intend to change the
semantics of the binding at all. If that's the case, then they seem fine
to me.

Have you checked that all users of this binding do assume that the
column GPIOs are output, and rows inputs, rather than the other way
around for example? I suppose if the Linux driver is already implemented
to assume that, then nobody can be successfully using this binding for
HW where that isn't the case, so this change is fine.

This change assumes it's OK to activate all columns at once, and
presumably that drivers can request the GPIOs as IRQs. This need not be
true on all HW. Should an additional property be added to describe
whether it's legal to activate all columns at once? For the IRQ case,
presumably the driver can simply try to request an IRQ for each GPIO,
and fall back to not doing so if that doesn't work.

> +Simple keypad matrix layouts just connect GPIO lines to mechanical
> +switches, with no other active components involved.  Although due to the

I don't think that's always true. On some Tegra boards for example,
multiple processes can "press" certain switches, so we actually have a
wired-OR feed into a transistor which then connects a particular
(column, row) combination. We do this e.g. for remote-control USB over
the power button for example. I believe the effect is the same, but it
does mean that statement above isn't quite true.

> +driver's operation of activating all columns at the same time for most

Saying "driver" in a DT binding is a slight red flag. The binding should
really purely describe HW, rather than SW's use of it. Here, the use is
probably generic enough not to be an issue, although it there's some way
to reword it to avoid that word it might be good.

> +- gpio-activelow:	row pins as well as column pins are active low

That one change is definitely wrong. Each entry in row-gpios and
col-gpios should include GPIO flags (in a format defined by the binding
for the DT node providing the GPIO). Those flags include an active-high
vs. active-low bit. In Linux, you can use of_get_gpio_flags() to
retrieve a standardized representation of the flags.
