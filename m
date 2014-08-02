From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Aug 2014 08:51:18 +0100
Subject: [PATCH 02/15] ARM: pass IRQ domain to the core IRQ handler
In-Reply-To: <1404825038-547-3-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
 <1404825038-547-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140802075118.GV30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 02:10:25PM +0100, Marc Zyngier wrote:
> Calling irq_find_mapping from outside a irq_{enter,exit} section is
> unsafe and produces ugly messages if CONFIG_PROVE_RCU is enabled:
> If coming from the idle state, the rcu_read_lock call in irq_find_mapping
> will generate an an unpleasant warning.
> 
> A solution is to add a new handle_domain_irq entry point into
> the arm code that the interrupt controller code can call.
> This new function takes an irq_domain, and calls into irq_find_domain
> inside the irq_{enter,exit} block.
> 
> Interrupt controllers can then be updated to use the new mechanism.

I merged this last night, and this says it all...

Subject: rmk build: 244 warnings 49 failures (rmk/v3.16-rc3-70-gc1ed1df)

arch/arm/kernel/irq.c:81:3: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]

So I'm dropping it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
