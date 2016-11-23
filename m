From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Nov 2016 02:39:40 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <1479860851.10840.11@smtp.gmail.com>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch>
 <1479586147.10840.0@smtp.gmail.com>
 <20161120203037.pd5mhqyjeotileve@perseus.defre.kleine-koenig.org>
 <1479851991.26813.2@smtp.gmail.com>
 <1479860851.10840.11@smtp.gmail.com>
Message-ID: <20161123013940.GM2691@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 01:27:31AM +0100, tomas.hlavacek at nic.cz wrote:
> Hi Uwe!
> 
> On Tue, Nov 22, 2016 at 10:59 PM, tomas.hlavacek at nic.cz wrote:
> >Anyway I took your patch and tried few things:
> >- add pca9538 interrupt-controller
> >- add IRQ for 88E1514 PHY - and there is a problem:
> ...
> 
> I thought it over and if I am not mistaken this is not going to work
> anyway, because pca9538 driver causes the GPIO driver to set
> IRQ_NESTED_THREAD, so we can not simply use one of the GPIO expander
> pins as IRQ source for 88E1514, because request_irq() on it will
> fail ultimately.

Actually, the phylib now does uses threaded IRQs, since i implemented
interrupt support for the mv88e6xxx driver. Its interrupts require
MDIO transactions, so have to be threaded.

However, i don't think using interrupts on the pca9538 are
reliable. Interrupt support is compile time optional for that
driver. It is not clear to me if distributions do compile the driver
with interrupts enabled. So it could be the probe fails with OpenWRT,
Debian, etc...

	Andrew
