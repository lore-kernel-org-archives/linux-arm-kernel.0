From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 13:18:05 +0000
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
In-Reply-To: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
References: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <20110223131805.GK29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 06:24:50PM +0530, Rabin Vincent wrote:
> __nmk_gpio_irq_handler doesn't do anything more that what a normal handler
> does, so it can become one.  This is also needed for changing the GIC
> implementation to a different flow handler.

So you want to allow other people to request the GPIO interrupt?

You also want to have the IRQ tracing code called once for entry into
this handler and once for each GPIO interrupt which is pending?

You want to have the overhead of dealing with the inprogress stuff, etc?

I really don't like the idea of getting rid of the interrupt chaining
and reverting back to the proven-to-be-broken 2.2 kernel way of handing
this kind of thing - which is exactly what you're doing here.
