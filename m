From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Mon, 6 Nov 2017 14:28:08 +0000
Subject: [v11,1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <8760aoz78q.fsf@bilbrey.org>
References: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
 <8760aoz78q.fsf@bilbrey.org>
Message-ID: <DB6PR0501MB2197286DFD9801F6C78D638DB1500@DB6PR0501MB2197.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 
Thanks for review>

> -----Original Message-----
> From: Chip Bilbrey [mailto:chip at bilbrey.org]
> Sent: Monday, November 6, 2017 12:33 AM
> To: Oleksandr Shamray <oleksandrs@mellanox.com>
> Cc: gregkh at linuxfoundation.org; arnd at arndb.de; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; openbmc at lists.ozlabs.org; joel at jms.id.au;
> jiri at resnulli.us; tklauser at distanz.ch; linux-serial at vger.kernel.org;
> mec at shout.net; Vadim Pasternak <vadimp@mellanox.com>; system-sw-low-
> level <system-sw-low-level@mellanox.com>; robh+dt at kernel.org; openocd-
> devel-owner at lists.sourceforge.net; linux-api at vger.kernel.org;
> davem at davemloft.net; mchehab at kernel.org; Jiri Pirko <jiri@mellanox.com>
> Subject: Re: [v11,1/4] drivers: jtag: Add JTAG core driver
> 
> 
> Oleksandr Shamray writes:
> > diff --git a/include/uapi/linux/jtag.h b/include/uapi/linux/jtag.h new
> > file mode 100644 index 0000000..0b25a83
> > --- /dev/null
> > +++ b/include/uapi/linux/jtag.h
> > [...]
> > +/**
> > + * enum jtag_xfer_mode:
> > + *
> > + * @JTAG_XFER_HW_MODE: hardware mode transfer
> > + * @JTAG_XFER_SW_MODE: software mode transfer  */ enum
> jtag_xfer_mode
> > +{
> > +	JTAG_XFER_HW_MODE,
> > +	JTAG_XFER_SW_MODE,
> > +};
> 
> Is this essentially selecting between bit-bang mode or not?  Is there a generally
> applicable reason to select SW mode over HW (or vice versa)?
> This sounds like it's tied to device-specific capability which shouldn't be exposed
> in a generic user API.

It is a mode of working some JTAG master devices. F.e Aspeed JTAG core can work in fully automatic mode when all StateMachine 
transitions and pin control done by hardware and in the more simpler mode when JTAG pin control does by the user (like bit-bang). 

It HW defined feature and can be applied not in all cases. 

Seems it can be deleted from xfer option and controlled by separate like IOCTL_SET_PARAM command.
> 
> > +/**
> > + * struct jtag_xfer - jtag xfer:
> > + *
> > + * @mode: access mode
> > + * @type: transfer type
> > + * @direction: xfer direction
> > + * @length: xfer bits len
> > + * @tdio : xfer data array
> > + * @endir: xfer end state
> > + *
> > + * Structure represents interface to Aspeed JTAG device for jtag sdr
> > +xfer
> > + * execution.
> 
> Probably should remove the reference to Aspeed here.

Thanks, will remove it.

> 
> > +/* ioctl interface */
> > +#define __JTAG_IOCTL_MAGIC	0xb2
> > +
> > +#define JTAG_IOCRUNTEST	_IOW(__JTAG_IOCTL_MAGIC, 0,\
> > +			     struct jtag_run_test_idle)
> > +#define JTAG_SIOCFREQ	_IOW(__JTAG_IOCTL_MAGIC, 1, unsigned int)
> > +#define JTAG_GIOCFREQ	_IOR(__JTAG_IOCTL_MAGIC, 2, unsigned int)
> > +#define JTAG_IOCXFER	_IOWR(__JTAG_IOCTL_MAGIC, 3, struct
> jtag_xfer)
> > +#define JTAG_GIOCSTATUS _IOWR(__JTAG_IOCTL_MAGIC, 4, enum
> > +jtag_endstate)
> 
> I notice the single-open()-per-device lock was dropped by request in an earlier
> revision of your patches, but multiple processes trying to drive a single JTAG
> master could wreak serious havoc if transactions get interleaved. Would
> something like an added JTAG_LOCKCHAIN/UNLOCKCHAIN
> ioctl() for exclusive client access be reasonable to prevent this?

Yes, it dropped by recommendation of Greg KH <gregkh@linuxfoundation.org>. 
Uer app should care about it.

> 
> -Chip

Thanks for review.
Oleksandr.
