From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 06:11:46 +0100
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1386736215.7152.259.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <201312102257.33942.arnd@arndb.de>
 <1386736215.7152.259.camel@host5.omatika.ru>
Message-ID: <201312110611.46443.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Sergei Ianovich wrote:
> > It probably makes sense to have a single driver file for the
> > FPGA device that does this, and only split out the other devices
> > from it that consume the irqs.
> 
> Is drivers/irqchip/ the right place this driver?
> 
> I am asking because there is no tristate config options in
> drivers/irqchip/Kconfig at the moment.
> 

It depends: if the driver is for the entire FPGA and does
the irqchip stuff in addition, it should probably live
in drivers/mfd. If it's a pure irqchip driver, drivers/irqchip
is better. You have to be careful in the second case though
because devices pointing to this irqchip in DT won't get
an IRQ resource assigned automatically but have to use
irq_of_parse_and_map instead. This may have been fixed since
I last looked though, I would consider that behavior a
bug in the of_platform handling.

	Arnd
