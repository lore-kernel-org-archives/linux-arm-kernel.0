From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 25 Jun 2011 14:33:56 +0400
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <4E05A9B1.5090000@free.fr>
References: <20110622143216.GE27654@legolas.emea.dhcp.ti.com>
	<Pine.LNX.4.44L0.1106221055030.1977-100000@iolanthe.rowland.org>
	<20110622151902.GN27654@legolas.emea.dhcp.ti.com>
	<4E05A9B1.5090000@free.fr>
Message-ID: <BANLkTik_OPVYwucvVO1ODwSDhjFgXC07oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/25/11, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> On 06/22/2011 05:19 PM, Felipe Balbi wrote:
>> On Wed, Jun 22, 2011 at 11:02:27AM -0400, Alan Stern wrote:
>>> Until recently, ordering of the suspend callbacks didn't present any
>>> problem.  The gadget device was a child of the UDC device and therefore
>>> its suspend callback would always be invoked first.
>>>
>>> With the new UDC framework, I don't know if this is true any more.
>>> It's something to consider.
> That true also for the UDC driver, which should be suspended before the
> transciever, so that it can complete its shutdown properly.
> That's what bothers me with the patch.
>
> And we should not confuse the 2 suspends :
>   (1) driver suspend, which happens at suspendToRam or suspendToDisk
> (the one we're discussing here)
>   (2) USB suspend (which if I remember correctly is a special USB
> command while the USB bus remains powered).
>
> The order of suspend in (1) requires :
>   - gadget (gzero, gether, ...) suspended first
>   - UDC suspended second
>   - transceiver suspended last
>
> The order of suspend in (2) doesn't require anything AFAIR.
>
> For order in (1) :
>   - gadget before UDC should be enforced by the framework, as the UDC
> usb_gadget_probe_driver() method calls device_add() on the gadget<
>   - UDC before transceiver is enforced in some drivers by directly
> manipulating the gpio line.
>
> So Dimitry, do you have an idea as how to guarantee order of suspend in
> (1), between UDC driver and gpio_vbus ? Maybe an otg_*() call would do
> the trick ?

That is simple: UDC driver acquires transceiver via otg_*() calls, so
transceiver
is already registered at the point of probing UDC. I'll check the order of calls
during suspend though.

-- 
With best wishes
Dmitry
