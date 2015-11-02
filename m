From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 02 Nov 2015 09:53:19 +0000
Subject: [PATCH 05/13 v2] irqchip/gic: assign irqchip dynamically
In-Reply-To: <1445591083-22494-1-git-send-email-linus.walleij@linaro.org>
References: <1445591083-22494-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5637328F.7060601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Sorry for the delay, I just enjoyed two weeks off, and I'm slowly making
my way through my exploding Inbox...

On 23/10/15 10:04, Linus Walleij wrote:
> Instead of having the irqchip being a static struct, make it part
> of the per-instance data so we can assign it a dynamic name. This
> has the usable side effect of displaying the GIC with an instance
> number as GIC0, GIC1 ... GICn in /proc/interrupts, which is helpful
> when debugging cascaded GICs, such as on the ARM PB11MPCore.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Keep the static structs around, just delete the .name
>   field assign them to the chips at registration time, updating
>   the name field with the instance number.
> - Also enumerate the EOIMODE1 sub-chips.
> 
> Marc: can't test the EOIMODE1 thing, it's far above me, but it
> "should work". Is it correct that there is one unique and coupled
> EOIMODE1 instance per GIC instance like this?

I'm afraid you misinterpreted the EOIMODE==1 thing. The GIC can either
be EOIMODE==0 (which is what most people are using on 32bit when not
booting at HYP), or EOIMODE==1 (most 64bit systems). For systems with
multiple GICs, the secondary GICs are always EOIMODE==0.

So you should only have a single irqchip structure in gic_chip_data, and
populate it depending on the case you're in:

- gic_nr == 0 && static_key_true(&supports_deactivate) -> EOIMODE==1
- otherwise EOIMODE==0.

Does this make more sense?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
