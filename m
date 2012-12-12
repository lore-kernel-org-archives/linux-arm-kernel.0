From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 12 Dec 2012 09:29:46 -0500
Subject: Kernel failed to boot when add more drivers
In-Reply-To: <50C88E3B.8090108@ronetix.at>
References: <50C881C6.7070806@ronetix.at>
 <91586D499ADFD74FBCFB8425266A5DE4013765E58576@pluto.melinkcorp.local>
 <50C88E3B.8090108@ronetix.at>
Message-ID: <91586D499ADFD74FBCFB8425266A5DE4013765E585C6@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin,

Answers below.

Regards,
Bryan Evenson

> -----Original Message-----
> From: Martin Peevski [mailto:martin at ronetix.at]
> Sent: Wednesday, December 12, 2012 9:02 AM
> To: Bryan Evenson
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Kernel failed to boot when add more drivers
> 
> On 12/12/12 15:53, Bryan Evenson wrote:
> > Martin,
> >
> > Whenever I've had similar issues it's because I have a U-Boot
> > environment variable that assumes the kernel is smaller than it is.
> > So U-Boot may not be loading the entire kernel which would cause your
> > CRC errors.  Could you you provide the following information:
> >
> > How are you loading the kernel?  From NAND flash, SD card, TFTP boot?
> 
> I'm loading the Kernel from NAND
> 
> > Could you show us your U-Boot environment variables (result of
> "printenv"
> > U-Boot command)?
> 
> U-Boot> printenv
> bootargs=mem=128M console=ttyS0,115200
> mtdparts=atmel_nand:8M(bootstrap/uboot/kernel)ro,-(rootfs)
> root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs
> bootcmd=nand read.jffs2 0x22000000 0x200000 0x250000; bootm 0x22000000
> bootdelay=1
> baudrate=115200
> ethact=macb0
> 
> Environment size: 277/131067 bytes
> U-Boot>

The bootcmd is set to read 0x250000 bytes from NAND flash for the kernel,
Which is about 2.31 MB.  Change the bootcmd to read as follows:

bootcmd=nand read.jffs2 0x22000000 0x200000 0x300000; bootm 0x22000000

then you should be good with kernel sizes up to 3 MB.  Remember to adjust
as needed based upon the size of your kernel.

> 
> 
> > Thanks,
> > Bryan Evenson
> >
> >
> >> -----Original Message-----
> >> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-
> >> kernel-bounces at lists.infradead.org] On Behalf Of Martin Peevski
> >> Sent: Wednesday, December 12, 2012 8:08 AM
> >> To: linux-arm-kernel at lists.infradead.org
> >> Subject: Kernel failed to boot when add more drivers
> >>
> >>       Hello! Can you, please, help me!
> >>
> >>       I'm building Linux Kernel version 2.6.39 for at91sam9x5ek.
> When
> >> I want to add more drivers the U-boot is imposible to load the
> Kernel
> >> because CRC error. The size of the uImage is 2.38MB. When I remove
> >> some driversand uImage become around 2.31MB the Kernel is loading
> >> successfully. Do you know what is the reason, I want to use more
> >> drivers?
> >>
> >>       Many thanks!
> >>       Martin Peevski.
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
