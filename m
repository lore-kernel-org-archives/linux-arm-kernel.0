From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Wed, 18 Nov 2009 08:09:35 +0100
Subject: ARM kirkwood: how to run kirkwood_pcie_init() from kernel module
In-Reply-To: <c70ff3ad0911171910t2231317aw154ba6e455ca3511@mail.gmail.com>
References: <200911161032.02873.dk-arm-linux@gmx.de>
	<c70ff3ad0911171910t2231317aw154ba6e455ca3511@mail.gmail.com>
Message-ID: <200911180809.36672.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> please note that this function linked into the init section.

I was not able to call the kirkwood_pcie_init. Is there a way?
My idea after fighting a few hours with this issue was that
I couldn't call init functions because init code is freed from kernel after bootup,
isn't it?


But finally I got it working with fakephp by doing:

#disconnect my fpga
echo 0 > /sys/bus/pci/slots/0000:01:08.0/power
#disconnect my bridge
echo 0 > /sys/bus/pci/slots/0000:00:01.0/power
#
flashing my fpga.......
#initiate bus rescan
echo 1 > /sys/bus/pci/rescan

I have no idea why it doesn't work without fakephp (because pci subsystem also allows disabling
the devices via sysfs) but if I did it without fakephp
echo 1 > /sys/bus/pci/rescan
has absolutely no effect.



But now it works as expected.

Many thanks,
Dieter


> 
> On Mon, Nov 16, 2009 at 3:32 AM, Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> > Hi all,
> >
> > sorry for disturbing and also sorry for my - maybe strange - question ;)
> >
> > I've got the following problem:
> >
> > I want to boot my fpga before I start the pci layer.
> > To achieve this it is necessary to start the pci layer somewhat after flashing my fpga.
> >
> > So what I need is to run kirkwood_pcie_init() from inside my (flashing) driver.
> > Do you know a way how to realize this?
> >
> > The header common.h isn't meant to include it from anywhere else than from kirkwood *_setup.c files, right?
> >
> > Is it possible to do a EXPORT_SYMBOL(kirkwood_pcie_init) somehow?
> >
> > I've tried it allready but get linker warnings and function isn't called...
> >
> > Do you have an idea how I can do that?
> >
> > Many many thanks in advance,
> > Dieter
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
