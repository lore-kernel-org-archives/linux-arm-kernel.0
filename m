From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 26 Nov 2010 14:29:16 +0100
Subject: [sodaville] [PATCH 1/9] spi/pxa2xx: don't use subys initcall
	for driver init
In-Reply-To: <20101126110605.GI9310@n2100.arm.linux.org.uk>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
	<4CED3199.2040700@linutronix.de>
	<20101125235415.GA9310@n2100.arm.linux.org.uk>
	<20101126105028.GA24010@www.tglx.de>
	<20101126110605.GI9310@n2100.arm.linux.org.uk>
Message-ID: <4CEFB62C.6020508@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Nov 26, 2010 at 11:50:28AM +0100, Sebastian Andrzej Siewior wrote:
>> * Russell King - ARM Linux | 2010-11-25 23:54:15 [+0000]:
>>
>>> Why should the PXA code change when you haven't explained _why_ you want
>>> to change the SPI driver to conform to your idea?
>> The problem was, that the platform driver never got probed after I
>> registered the PCI driver. For that reason I made the patch attached. It
>> got lost while moving the tree forward and I did not notice it earlier.
>> While at it, I changed the subsys_init to module_init because it looked
>> wrong. At this time I was also thinking about using one module for the
>> platform and PCI code but never got to it.
> 
> This is one of the problems of the foo_driver_probe() idea - if the
> device is not present at the time the driver is registered, then the
> driver loses out completely.
> 
> This would seem to be exagerated as you're creating this platform device
> from a PCI device - who's to say that someone won't unbind the PCI device
> and re-bind it later, causing the platform device to be deleted and
> re-created?

Unbinding a PCI device should call ->remove of the pci driver and this in
turn will remove the platform device which calls ->remove of the driver.

> As such, I think the patch you've shown in this email is more appropriate
> (getting rid of the platform_driver_probe()) than trying to sort out
> init-level dependencies.  Really, the init-level dependencies in this case
> are not the problem - the use of platform_driver_probe() is.

Okay. So I leave as it.

Sebastian
