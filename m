From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Apr 2011 08:44:10 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <op.vt74sxvp3ri7v4@arend-laptop>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<20110419140257.GA20456@kroah.com> <op.vt74sxvp3ri7v4@arend-laptop>
Message-ID: <201104200844.10607.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 April 2011 08:39:59 Arend van Spriel wrote:
> On Tue, 19 Apr 2011 16:02:57 +0200, Greg KH <greg@kroah.com> wrote:
> 
> > Please don't use a platform device, unless there is no other way for
> > your device to work.  For this device, you are connected to the PCI bus,
> > so a platform device does not make sense at all.
> 
> Hi Greg,
> 
> This is only true for a particular usage model. There are two models as  
> shown below:
> 
> 1) PCI(e) card
>                        ...........
> +----------+          :   x y z :     x, y, and z are cores.
> |    uC    |__________:___|_|_| :
> |          |  PCI-bus : axi-bus :
> +----------+          :.........:
>                        bcm chipset
> 
> 2) SoC
>            ...............
>            : uC    x y z :
>            :  |____|_|_| :
>            :    axi-bus  :
>            :.............:
>              bcm chipset
> 
> Your statement is true for 1) but in usage model 2) there is no PCI bus.  
> Also you refer to the chipset when you say 'device'. In the axi bus type  
> each individual core is registered as a device in the linux device tree.

I guess what Greg was referring to is having platform devices for x/y/z
here. In case 2, you might still need to have a platform_device for the
combination of the three IP cores if they make up one logical device.

As mentioned in my reply, it depends a lot on what these cores actually
are, e.g. whether you might want to have only one of them active in a
given system to drive a specific functionality, or if you always need
all three of them.

	Arnd
