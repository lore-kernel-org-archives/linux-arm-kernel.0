From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 18:19:18 +0000
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
In-Reply-To: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
Message-ID: <20110105181918.GB8717@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 07:58:03PM +0200, Eduardo Valentin wrote:
> Currently, if one calls disable_irq(gpio_irq), the irq
> won't get disabled.
> 
> This is happening because the omap gpio code defines only
> a .mask callback. And the default_disable function is just
> a stub. The result is that, when someone calls disable_irq
> for an irq in a gpio line, it will be kept enabled.
> 
> This patch solves this issue by setting the .disable
> callback to point to the same .mask callback.

Amd this is a problem because?

The way this works is that although it isn't disabled at that point,
if it never triggers, then everything remains happy.  However, if it
does trigger, the genirq code will then mask the interrupt and won't
call the handler.
