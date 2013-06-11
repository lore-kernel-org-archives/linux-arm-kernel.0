From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Jun 2013 10:33:12 -0600
Subject: [PATCH] drivers: pinctrl: add active state to core
In-Reply-To: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
References: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <51B75148.5080701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 02:16 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> In addition to the recently introduced pinctrl core
> control, the PM runtime pin control for the OMAP platforms
> require a fourth state in addtition to the default, idle and
> sleep states already handled by the core: an explicit "active"
> state. Let's introduce this to the core in addition to the
> other states already defined.

Surely "default" /is/ "active"? That's what it's meant so far.

Since the pinctrl states are represented in DT, the DT bindings of all
devices potentially get affected by changes like this. They'd need to be
documented in a DT binding document, and the exact semantics of the
different states clearly explained.

It may be better for struct device, struct platform_driver, or similar,
to contain a list of the states that are required by the driver or its
binding. That way, the list of states (or states beyond the basic
default) is driver-/DT-binding- specific, and custom stuff like this for
OMAP wouldn't require explicit code in drivers/base/pinctrl.c, but
rather simply iterating over a custom list.

Related to that, I'm not sure we should be deriving what we put into DT
based on the runtime PM requirements of drivers; DT is supposed to be
driven by HW definitions, although I suppose you could argue that the
drivers implement what they do because they're implementing the HW
requirements.
