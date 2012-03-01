From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:38:27 +0000
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE86173C@HQMAIL01.nvidia.com>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE86173C@HQMAIL01.nvidia.com>
Message-ID: <201203012038.28062.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Stephen Warren wrote:
> 
> Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The driver should not call set_irq_flags itself, and
> 
> Probably true in this case.
> 
> > cannot do this from a loadable module.
> 
> I hope that's not true; grep'ing the entire of drivers/ shows a bunch
> of drivers calling this function, and many look like they'd be reasonable
> as module.

The drivers that I can see using it are for the most part implementing
irq controllers by themselves, which is different from merely using an
interrupt.

There are three exceptions today:

arnd at klappe2:~/linux-arm$ git grep -l set_irq_flags  drivers/ | xargs grep -L irq_chip
drivers/tty/serial/serial_ks8695.c
drivers/tty/serial/sirfsoc_uart.c
drivers/usb/host/ehci-tegra.c

> From what little I understand of this, any irq_chip is going to call
> that function after setting up any child/cascaded IRQs, and I assume
> that irq_chips can be in modules.

But the function is not exported. I guess if we want to allow
irq_chips in loadable modules, we could export it, but I don't see
how it could ever have worked so far.
 
> > Remove the call for now, which might break the driver
> > but at least lets the kernel link again.
> 
> The driver appears to work fine with this removed. At least, on Tegra20
> Harmony, I was able to modprobe ehci-hcd and then use the USB Ethernet
> controller for DHCP and SSH.

Ok, maybe it was the right fix after all then and it just needs a proper
change description ;-)

	Arnd
