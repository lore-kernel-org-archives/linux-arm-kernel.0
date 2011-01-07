From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jan 2011 23:32:16 +0100
Subject: [PATCH V2] ST SPEAr: PCIE gadget suppport
In-Reply-To: <137dfad4a093ea0ac80396f5eb7fbf0c382be698.1294314772.git.viresh.kumar@st.com>
References: <137dfad4a093ea0ac80396f5eb7fbf0c382be698.1294314772.git.viresh.kumar@st.com>
Message-ID: <201101072332.16985.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 January 2011, Viresh Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> This is a configurable gadget. can be configured by sysfs interface. Any
> IP available at PCIE bus can be programmed to be used by host
> controller.It supoorts both INTX and MSI.
> By default, gadget is configured for INTX and SYSRAM1 is mapped to BAR0
> with size 0x1000

The code looks reasonably clean, but I don't yet understand how you would
use this device for the interesting case of communicating with the host
side. I've put a lot of thought into similar hardware designs before, but
never got an implementation done myself.

Forwarding devices that don't need interrupts with your driver seems to
be the only case that will easily work, but that is also rather limited
in what you can use it for.

One concept that people have played with before is to export a virtio
channel through PCI that you can use with e.g. virtio-net  or virtfs.
This is very powerful and has  a lot of possible applications because
we have support for virtio drivers across a number of operating systems
and platforms already.

>  Documentation/misc-devices/spear-pcie-gadget.txt |  125 ++++
>  drivers/misc/Kconfig                             |   10 +
>  drivers/misc/Makefile                            |    1 +
>  drivers/misc/spear13xx_pcie_gadget.c             |  856 ++++++++++++++++++++++

Why would you put this under drivers/misc?

I think drivers/pci/gadget/ would be a better place. I would also
recommend splitting the user interface from the hardware dependent
parts, so someone else can easily do another gadget driver for
different hardware.

> +/*wait till link is up*/
> +# cat sys/devices/platform/pcie-gadget-spear.0/link
> +wait till it returns UP.

A blocking sysfs read is not a nice interface. This is probably where
the sysfs abstraction for your hardware stops making sense.

> +To assert INTA
> +# echo 1 >> sys/devices/platform/pcie-gadget-spear.0/inta
> +
> +To de-assert INTA
> +# echo 0 >> sys/devices/platform/pcie-gadget-spear.0/inta

And this looks somewhat impractical and slow. 

> +to send msi vector 2
> +# echo 2 >> sys/devices/platform/pcie-gadget-spear.0/send_msi

Using a sysfs file only for its side-effect is not very nice either.

The user interface for the interrupts looks to me like it should really
be based around a character device and either read/write/poll or
ioctl and poll. Using an eventfd might be cool here, because  then you
can combine this with other devices by passing the event file to
an interface that operates on eventfd. This would e.g. make it possible
to combine a UIO device generating interrupts with a PCIe gadget
sending the interrupts somewhere else, without leaving kernel
space.

For setting up the basic parameters, sysfs (or configfs, as Greg suggested)
is a reasonable choice, so there is no need to change that.

I don't know what the rules for configfs are though, i.e. if eventfd
files or ioctls are ok or not.

	Arnd
