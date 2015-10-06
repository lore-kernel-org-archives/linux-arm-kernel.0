From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 12:30:19 +0200
Subject: ARM64 PCIe legacy interrupts
In-Reply-To: <loom.20151006T121259-647@post.gmane.org>
References: <loom.20151001T142318-555@post.gmane.org>
 <CAHM4w1kzt0wCCxfvofXqzgK=Te50_1ZsYnApbEojMQq8x+wcdA@mail.gmail.com>
 <loom.20151006T121259-647@post.gmane.org>
Message-ID: <5647794.zPHEyLbn48@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 10:17:11 bharat kumar gogada wrote:
> I have a confusion in handling legacy interrupts in driver, I'm seeing that
> for legacy handling there is separate node being created. Ex: for
> pcie-xilinx.c the following node is being used
> 
> pcie_intc: interrupt-controller {
>                         interrupt-controller;
>                         #address-cells = <0>;
>                         #interrupt-cells = <1>;
>                 };
> 
> Why do we need a separate child node for legacy handling

This is a special case where the interrupt lines are not simply
passed through to the parent interrupt controller but require
an Ack in a separate register.

Most sane implementations only need an interrupt-map property
that documents how the legacy interrupts are wired to the GIC.

> and why is the address cells parameter assigned zero value

It means that the interrupt can be identified by the interrupt
number itself and does not need to be identified by an address
as well. This is true for almost all interrupt controllers.

	Arnd
