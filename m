From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 16:06:57 +0200
Subject: [PATCH] arm: mvebu: move irq controller driver in drivers/irqchip/
In-Reply-To: <50894346.60507@gmail.com>
References: <1351168500-11129-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <50894346.60507@gmail.com>
Message-ID: <20121025160657.57a52658@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Thu, 25 Oct 2012 08:48:54 -0500, Rob Herring wrote:

> I don't mean to pick on this specific patch, but this is a common
> problem of moving various low-level pieces like irqchips, cpuidle,
> timers, etc. to drivers/*. If we, just moving the code as is over, we
> still need some hooks between arch/arm and drivers. I think if we keep
> adding ARM SOC specific headers to include/linux, that will be the
> next thing we get yelled at for and will have to clean-up.
> 
> For irqchips, the way I see this working is we would have a single
> call to of_irq_init with a match list of all irqchips in
> drivers/irqchips. This contains the init function within
> drivers/irqchips. Then all the machines can just call a generic
> irqchip_init.

Sounds doable indeed.

> The handle_irq ptr would also need to be plugged in at runtime.

However, do you have a more specific idea here? In setup_arch(), the
value of mdesc->handle_irq gets picked up way before the ->init_irq
machine hook is being called.

An option would be to fill this mdesc->handle_irq() field during the
mdesc->init_early() callback (would require moving things around a bit
in setup_arch(), but sounds reasonable). However, at the time of
mdesc->init_early(), I guess we can't call of_irq_init(). So we would
have a two step process: fill in mdesc->handle_irq during
mdesc->init_early(), and call irqchip_init() (which will do the
of_irq_init()) in mdesc->init_irq().

If that's fine with you, I can cook a patch for BCM2835 and MVEBU that
implements this idea.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
