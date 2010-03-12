From: utx@penguin.cz (Stanislav Brabec)
Date: Fri, 12 Mar 2010 10:07:04 +0100
Subject: bit errors on spitz
In-Reply-To: <4B995EE1.1050609@warmcat.com>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
	<4B995EE1.1050609@warmcat.com>
Message-ID: <1268384824.4963.35.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Green wrote: 
> On 03/11/10 15:42, Somebody in the thread at some point said:
> > Andy Green wrote:
> >
> >> I saw very similar failures for a long time on our iMX31 based device.
> >> Eventually I found a Freescale errata where the RAM inside the USB2
> >> macrocell started to make single bit errors below 1.38V Vcore; ours was
> >> 1.4V at that time but dipped on CPU load.
> >
> > Good tip. It seems that nobody ported driver for the voltage control
> > chip ISL6271 from 2.4 kernel, and bootloader probably does not set
> > correct values.

> Unless there's more to it in the way the zaurus using it that regulator 
> isn't programmable digitally.

OOPS, I made a mistake and linked ISL6721 instead of ISL6271 there.
Now it is fixed:
http://www.penguin.cz/~utx/zaurus/datasheets/power/XScale/ISL6271A.pdf

This one has I2C. It is connected to GPIO 3 (PWR_SCL) and GPIO 4
(PWR_SDA).

It is visible between the black plastic and the large circular coil:
http://www.penguin.cz/~utx/zaurus/teardown#pcbt

> Reading about your CF Card WLAN related issues they suck down a good 
> amount of power when their radio is up, I would definitely suggest 
> monitoring with a 'scope the various rails (Vcore, RAM and whatever it 
> is the CF Card is powered by) while putting it under load.

I guess that Zaurus has a good power design and that voltage should be
constant enough. CF has a dedicated step down (plus 2.8V power detector
(Why so low, if CF standard requres more?)), HDD has a dedicated step
up/down. USB has dedicated step up. Companion chips use dedicated 3.3V
step down. Audio uses dedicated linear regulator. CPU has several
dedicated step downs, CPU 3.3V uses step-up to 5V and then down to 3.3V
(which is shared only with IOPORT).

Nearest common point between CF card power and CPU power is the battery.


________________________________________________________________________

Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
