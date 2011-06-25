From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Jun 2011 11:26:09 +0200
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <20110622151902.GN27654@legolas.emea.dhcp.ti.com>
References: <20110622143216.GE27654@legolas.emea.dhcp.ti.com>
	<Pine.LNX.4.44L0.1106221055030.1977-100000@iolanthe.rowland.org>
	<20110622151902.GN27654@legolas.emea.dhcp.ti.com>
Message-ID: <4E05A9B1.5090000@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2011 05:19 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jun 22, 2011 at 11:02:27AM -0400, Alan Stern wrote:
>> No, the patch is appropriate.
Indeed.
>>
>> We don't need better communication.  If g_mass_storage (for example)
>> knows that the device is in use, it can block suspends by returning
>> -EBUSY from its own suspend callback.  The UDC driver doesn't need to
>> worry about these matters; it should assume that such things have
>> already been handled elsewhere.  That's what Dmitry meant when he was
>> talking about a "higher level driver" -- maybe "lower level" would have
>> been a better choice of words.  :-)
The suspend at driver level should not care about filesystem in use, etc 
... A disconnected cable cannot be prevented by the kernel, and the 
effect in fine is the same as the suspend.

>> Until recently, ordering of the suspend callbacks didn't present any
>> problem.  The gadget device was a child of the UDC device and therefore
>> its suspend callback would always be invoked first.
>>
>> With the new UDC framework, I don't know if this is true any more.
>> It's something to consider.
That true also for the UDC driver, which should be suspended before the 
transciever, so that it can complete its shutdown properly.
That's what bothers me with the patch.

And we should not confuse the 2 suspends :
  (1) driver suspend, which happens at suspendToRam or suspendToDisk 
(the one we're discussing here)
  (2) USB suspend (which if I remember correctly is a special USB 
command while the USB bus remains powered).

The order of suspend in (1) requires :
  - gadget (gzero, gether, ...) suspended first
  - UDC suspended second
  - transceiver suspended last

The order of suspend in (2) doesn't require anything AFAIR.

For order in (1) :
  - gadget before UDC should be enforced by the framework, as the UDC 
usb_gadget_probe_driver() method calls device_add() on the gadget<
  - UDC before transceiver is enforced in some drivers by directly 
manipulating the gpio line.

So Dimitry, do you have an idea as how to guarantee order of suspend in 
(1), between UDC driver and gpio_vbus ? Maybe an otg_*() call would do 
the trick ?

Cheers.

--
Robert
