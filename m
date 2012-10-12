From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Fri, 12 Oct 2012 17:29:55 +0000
Subject: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
In-Reply-To: <20121012164202.GQ28061@n2100.arm.linux.org.uk>
References: <20120925083029.GG31374@n2100.arm.linux.org.uk>
 <20120925083118.GI9137@arwen.pp.htv.fi>
 <20120925091228.GI31374@n2100.arm.linux.org.uk>
 <20120925091112.GK9137@arwen.pp.htv.fi>
 <20120925092118.GJ31374@n2100.arm.linux.org.uk>
 <CAKdam57bpTJ94Gn=mKVw1Fm-76fVPp3DGjFuNu_HfesybM1hPg@mail.gmail.com>
 <87ipas2y4h.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1210111748010.5736@utopia.booyaka.com>
 <50784458.9080806@ti.com> <877gqv7imt.fsf@deeprootsystems.com>,
 <20121012164202.GQ28061@n2100.arm.linux.org.uk>
Message-ID: <FEB1293C1A07484EA4E9721B32981131CC2362@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
________________________________________
From: Russell King - ARM Linux [linux at arm.linux.org.uk]
Sent: Friday, October 12, 2012 10:12 PM
To: Kevin Hilman
Cc: Poddar, Sourav; Paul Walmsley; Balbi, Felipe; gregkh at linuxfoundation.org; tony at atomide.com; linux-kernel at vger.kernel.org; Shilimkar, Santosh; linux-serial at vger.kernel.org; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; alan at linux.intel.com
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not  suspended.

On Fri, Oct 12, 2012 at 09:35:54AM -0700, Kevin Hilman wrote:
> Sourav <sourav.poddar@ti.com> writes:
> > diff --git a/drivers/tty/serial/omap-serial.c
> > b/drivers/tty/serial/omap-serial.c
> > index 6ede6fd..3fbc7f7 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -1414,6 +1414,7 @@ static int __devinit serial_omap_probe(struct
> > platform_device *pdev)
> >         INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
> >
> >         platform_set_drvdata(pdev, up);
> > +       pm_runtime_set_active(&pdev->dev);
>
> NAK.
>
> This will obviously break platforms where the UARTs are not active
> before driver loads.

I thought I had proposed a solution for this issue, which was this
sequence:

        omap_device_enable(dev);
        pm_runtime_set_active(dev);
        pm_runtime_enable(dev);

Yes, I can understand people not liking the omap_device_enable()
there, but I also notice that the email suggesting that never got a
reply either - not even a "I tried this and it doesn't work" or "it
does work".

Sorry for the late reply on this. I tried this sequence and it worked perfectly fine on
panda and beagle. 

As such, it seems this issue isn't making any progress as we had
already established that merely doing a "pm_runtime_set_active()"
before "pm_runtime_enable()" was going to break other platforms.

 I was  trying to analyse your explanations on this and since omap_device_enable is not generally 
recommended,  I was trying to see if anything else can be done to get around this.

I send this patch for N800 testing so  as to see how it behaves. (We are suspecting that there might be
mux setting issue also with N800).   

~Sourav
