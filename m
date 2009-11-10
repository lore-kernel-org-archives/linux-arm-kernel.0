From: rshitrit@marvell.com (Ronen Shitrit)
Date: Tue, 10 Nov 2009 17:26:16 +0200
Subject: orion/kirkwood pcie issue still open with rc6
In-Reply-To: <200911091006.15757.dk-arm-linux@gmx.de>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<20091109094958.4ba72970@marrow.netinsight.se>
	<200911091006.15757.dk-arm-linux@gmx.de>
Message-ID: <309002C0DA137042828828FC53D7A9347E13FD4A92@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

The bit below indicates whether to propagate external errors on the PCIE as external abort or not.
In your case the external error is a PCI master abort, this is a legitimate error in case of issuing a configuration read to a device which doesn't exist on the bus.

To overcome the kernel fault and still enable the error propagation, there is the option to add handler which will look for the error cause and ignore it in case of master abort or to disable this bit before doing PCI config read.

Regards


-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Dieter Kiermaier
Sent: Monday, November 09, 2009 11:06 AM
To: linux-arm-kernel at lists.infradead.org
Cc: Simon Kagstrom; Nicolas Pitre
Subject: Re: orion/kirkwood pcie issue still open with rc6

Am Montag 09 November 2009 09:49:58 schrieb Simon Kagstrom:
> On Mon, 9 Nov 2009 09:33:46 +0100
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
>
> > Ronan Shitrit from marvell gave me the information to clear bit 2 of physical
> > address 0xf1020100 to enable bus scanning.
> > I don't know what this really does but it helped to get my kernel up and running.
>
> You have that in the functional specification for the kirkwood
> processors:
>
>   http://www.marvell.com/files/products/embedded_processors/kirkwood/FS_88F6180_9x_6281_OpenSource.pdf
>
> See Appendix A for the register set and lookup address 0x20100 (the CPU
> configuration register). Bit 2 in that register turns on/off error
> propagation:
>
>               Mbus-L Error propogation
>               For a list of errors see "Error Handling".
>               0 = NoErrProp: Error indications are not propagated to Mbus-L. The
>                   transactions are completed normally.
>               1 = ErrProp: Error indications are propagated to Mbus-L.
>
> and clearing it sounds quite a bit like hiding the real problem :-).
>

I've seen this and you're absolutely right. Thats why I've posted!

>
> Probably it's best to try to find out what's causing this error (see
> the Error Handling section of the PCIe chapter in the reference manual
> above) so that that a proper fix can be implemented!

And here my problems are starting ;)
How can I implement error handling for that kind of reported errors?
I'm sorry but I've absolutely no idea.

>
> // Simon

Many thanks,
Dieter
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
