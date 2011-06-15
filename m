From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 15 Jun 2011 16:18:42 +0400
Subject: GPIO vs. other drivers order
In-Reply-To: <20110615120629.GC24628@pulham.picochip.com>
References: <ita6o6$od6$1@dough.gmane.org>
	<20110615120629.GC24628@pulham.picochip.com>
Message-ID: <BANLkTikJtAqgKHGU2kBbMQdS5GSszxihYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/15/11, Jamie Iles <jamie@jamieiles.com> wrote:
> Hi Dmitry,
>
> On Wed, Jun 15, 2011 at 11:57:58AM +0000, Dmitry Eremin-Solenikov wrote:
>> Hello, colleagues,
>>
>> I'm currently looking at cleaning up LoCoMo and Scoop2 drivers (custom
>> Sharp ASICs used by Sharp Zaurus PDAs). One of the problems I'm stuck at
>> is about GPIO parts of that chips: there are plenty of other devices
>> depending on GPIO pins working correctly (ranging from board code
>> itself up to several other sub-drivers).
>>
>> What would be the better approach: to create a basic-mmio-gpio node (and
>> hope for the order of initialization to be correct) or embed bgpio into
>> main driver and call all necessary hooks directly from it?
>
> Currently the basic-mmio-gpio platform driver is registed with a
> module_initcall so this may be too late for any machines that need GPIO
> in their .init_machine callback.  Moving the registration to a
> postcore_initcall (as OMAP does) and I don't recall seeing any
> objections to this.

Will someone commit this or I'll have to submit this as a patch?

Platform (collie) uses GPIOs for managing RTS/CTS/DTR/DSR,
but I think I'll be able to workaround this somehow.

> If the basic-mmio-gpio driver does everything you need then registering
> it as a platform_device would be fine imho.  If you need to add/override
> some of the generic functionallity then embedding the bgpio_chip into
> your own structure is the probably best way to go.


I'll need to extend it with enable/disable bits, but I think this
change is generic
enough to be submitted to main driver.

-- 
With best wishes
Dmitry
