From: aisheng.dong@nxp.com (A.S. Dong)
Date: Wed, 17 May 2017 06:01:37 +0000
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
 <20170517033139.GB9913@b29396-OptiPlex-7040>
 <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
Message-ID: <AM3PR04MB306D5C86AED120D15C4D46A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nikita Yushchenko [mailto:nikita.yoush at cogentembedded.com]
> Sent: Wednesday, May 17, 2017 1:44 PM
> To: Dong Aisheng
> Cc: A.S. Dong; linux-serial at vger.kernel.org; Andy Duan;
> gregkh at linuxfoundation.org; Y.B. Lu; linux-kernel at vger.kernel.org;
> stefan at agner.ch; Mingkai Hu; jslaby at suse.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit
> register support
> 
> >>> @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device
> *pdev)
> >>>  	}
> >>>  	sport->port.line = ret;
> >>>  	sport->lpuart32 = sdata->is_32;
> >>> +	lpuart_is_be = sdata->is_be;
> >>
> >> Setting a global variable in per-device routine is quite bad design.
> >>
> >
> > There is a reason for that we don't want to change the exist
> > lpuart32_read[write] API which is widely used in driver.
> > Making a global lpuart_is_be is the simplest way to do it.
> >
> > Any strong blocking reason?
> 
> Code should be consistent.
> 

Yes.

> There is no good reason to have sport->lpuart32 inside sport, but
> lpuart_is_be outside of it. Both these values describe properties of
> particular device, and thus should be in per-device structure.
> 

That's for special case, normally we wouldn't do that.

> If that implies adding sport arg to lpuart32_(read|write), just do that.

There's another reason that we have to deal with earlycon which is
executed much early before driver probe.

And I need specificly align the endian data.
e.g.
static int __init lpuart32_early_console_setup(struct earlycon_device *device,
                                          const char *opt)
{
        if (!device->port.membase)
                return -ENODEV;

        lpuart_is_be = true;
        device->con->write = lpuart32_early_write;
        return 0;
}

static int __init lpuart32_imx_early_console_setup(struct earlycon_device *device,
                                                   const char *opt)
{
        if (!device->port.membase)
                return -ENODEV;

        lpuart_is_be = false;
        device->port.membase += IMX_REG_OFF;
        device->con->write = lpuart32_early_write;

        return 0;
}

Regards
Dong Aisheng
