From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 16 Mar 2017 14:55:18 +0000
Subject: [PATCH] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
In-Reply-To: <20170316133632.GV21222@n2100.armlinux.org.uk>
References: <20170316122653.19930-1-vigneshr@ti.com>
 <20170316133632.GV21222@n2100.armlinux.org.uk>
Message-ID: <9a6dcf55-0ace-e617-73bc-0472a939b36c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/17 13:36, Russell King - ARM Linux wrote:
> On Thu, Mar 16, 2017 at 05:56:53PM +0530, Vignesh R wrote:
>> Using dev_name() as irq name during request_irq() might be misleading in
>> case of serial over PCI. Therefore use a better alternative name for
>> identifying serial port irqs as "serial" appended with serial_index of
>> the port. This ensures that "serial" string is always present in irq
>> name while port index will help in distinguishing b/w different ports.
> 
> Wouldn't it be better to use the device name (iow, ttySx) rather than
> "serialx" ?
> 
> Maybe a helper function in serial_core.c to format the device name into
> a supplied string, which can be re-used elsewhere, eg, uart_report_port()
> and uart_suspend_port().  IOW:
> 
> const char *uart_port_name(char *buf, size_t n, struct uart_driver *drv,
> 			   struct uart_port *port)
> {
> 	snprintf(buf, n, "%s%d", drv->dev_name,
> 		 drv->tty_driver->name_base + port->line);
> 
> 	return buf;
> }
> 
> which means you can do this:
> 
> 	char name[16];
> 
> 	request_irq(..., uart_port_name(name, sizeof(name), driver, port), ...)
> 
> which also avoids the allocation.

...and makes 'cat /proc/interrupts' particularly fun later:

  8:          0          GICv2  72 Level     ??h	????V!

Unless a suitably long-lived string already exists somewhere else in the
serial core, the allocation is unavoidable, although kasprintf() (or its
devm_ variant) might make matters a little simpler.

Robin.

>  8250 device names are always "ttyS"
> plus a number, so 16 characters (including NULL terminator) should be
> more than sufficient, and that's most likely true of all serial drivers.
> (The longest device name I'm aware of is ttyAMA plus a small integer
> for PL011 ports.)
> 
