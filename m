From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 19 Jul 2018 22:53:58 +0200
Subject: [PATCH] ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch
In-Reply-To: <20180719193823.9486-1-u.kleine-koenig@pengutronix.de>
References: <20180719193823.9486-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20180719205358.GD12150@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 09:38:23PM +0200, Uwe Kleine-K?nig wrote:
> The Marvell switches report their interrupts in a level sensitive way.
> When using edge sensitive detection a race condition in the interrupt
> handler of the swich might result in the OS to miss all future events
> which might make the switch non-functional.
> 
> The problem is that both mv88e6xxx_g2_irq_thread_fn() and
> mv88e6xxx_g1_irq_thread_work() sample the irq cause register
> (MV88E6XXX_G2_INT_SRC and MV88E6XXX_G1_STS respectively) once and then
> handle the observed sources. If after sampling but before all observed
> irq sources are handled a new irq source gets active this is not noticed
> by the handler which returns unsuspecting, but the interrupt line stays
> active which prevents the edge detector to kick in.
> 
> All device trees but imx6qdl-zii-rdu2 get this right (most of them by
> not specifying an interrupt parent). So fix imx6qdl-zii-rdu2
> accordingly.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Fixes: f64992d1a916 ("ARM: dts: imx6: RDU2: Add Switch interrupts")

    Andrew
