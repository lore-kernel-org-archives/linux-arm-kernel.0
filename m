From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Apr 2014 22:33:26 +0100
Subject: [RFC] ARM: dts: imx27-pdk: Add PMIC support
In-Reply-To: <1397596027-14301-1-git-send-email-festevam@gmail.com>
References: <1397596027-14301-1-git-send-email-festevam@gmail.com>
Message-ID: <20140415213326.GY24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 06:07:07PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Hi,
> 
> I am sending it as RFC because I am getting the warning below.
> 
> Booting the non-dt kernel does not cause this warning.
> 
> Appreciate any comments/suggestions.

Quite simply, the driver is buggy.  You seem to be getting an interrupt
delivered to the thread right after the IRQ is requested:

        ret = request_threaded_irq(mc13xxx->irq, NULL, mc13xxx_irq_thread,
                        IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
        if (ret)
                return ret;

        mutex_init(&mc13xxx->lock);

and the thread tries to lock mc13xxx->lock.

There's nothing quite like initialising resources before using them...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
