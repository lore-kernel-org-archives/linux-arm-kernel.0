From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Tue, 22 May 2018 15:00:19 +0000
Subject: [patch v21 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <CAHp75VctG5RBtLF3nT5e_j7_e9O12u=5gerJ6OMxWbABM9ft2w@mail.gmail.com>
References: <1526394095-5069-1-git-send-email-oleksandrs@mellanox.com>
 <1526394095-5069-2-git-send-email-oleksandrs@mellanox.com>
 <CAHp75VctG5RBtLF3nT5e_j7_e9O12u=5gerJ6OMxWbABM9ft2w@mail.gmail.com>
Message-ID: <AM5PR0501MB2449FE5F9439B6C6E7396DFBB1940@AM5PR0501MB2449.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy. 
Thanks for review.

Please read my answers inline.

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> Sent: 16 ??? 2018 ?. 0:22
> To: Oleksandr Shamray <oleksandrs@mellanox.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Arnd Bergmann 
> <arnd@arndb.de>; Linux Kernel Mailing List 
> <linux-kernel@vger.kernel.org>; linux-arm Mailing List 
> <linux-arm-kernel@lists.infradead.org>; devicetree 
> <devicetree@vger.kernel.org>; openbmc at lists.ozlabs.org; Joel Stanley 
> <joel@jms.id.au>; Ji?? P?rko <jiri@resnulli.us>; Tobias Klauser 
> <tklauser@distanz.ch>; open list:SERIAL DRIVERS <linux- 
> serial at vger.kernel.org>; Vadim Pasternak <vadimp@mellanox.com>; 
> system-sw-low-level <system-sw-low-level@mellanox.com>; Rob Herring 
> <robh+dt@kernel.org>; openocd-devel-owner at lists.sourceforge.net; 
> linux- api at vger.kernel.org; David S. Miller <davem@davemloft.net>; 
> Mauro Carvalho Chehab <mchehab@kernel.org>; Jiri Pirko 
> <jiri@mellanox.com>
> Subject: Re: [patch v21 1/4] drivers: jtag: Add JTAG core driver
> 
> On Tue, May 15, 2018 at 5:21 PM, Oleksandr Shamray 
> <oleksandrs@mellanox.com> wrote:
> > Initial patch for JTAG driver
> > JTAG class driver provide infrastructure to support 
> > hardware/software JTAG platform drivers. It provide user layer API 
> > interface for flashing and debugging external devices which equipped 
> > with JTAG interface using standard transactions.
> >
> > Driver exposes set of IOCTL to user space for:
> > - XFER:
> > - SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
> > - SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> > - RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
> >   number of clocks).
> > - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> >
> > Driver core provides set of internal APIs for allocation and
> > registration:
> > - jtag_register;
> > - jtag_unregister;
> > - jtag_alloc;
> > - jtag_free;
> >
> > Platform driver on registration with jtag-core creates the next 
> > entry in dev folder:
> > /dev/jtagX
> 
> >  0xB0   all     RATIO devices           in development:
> >                                         <mailto:vgo@ratio.de>
> >  0xB1   00-1F   PPPoX                   <mailto:mostrows@styx.uwaterloo.ca>
> > +0xB2   00-0f   linux/jtag.h            JTAG driver
> > +
> > +<mailto:oleksandrs@mellanox.com>
> 
> Consider to preserve style (upper vs. lower).

JTAG in code is lower (jtag) cane but in descriptions and notes it  is upper (JTAG).
In all places which do not correspond to this I will fix. 

> 
> > +         This provides basic core functionality support for JTAG class devices.
> > +         Hardware that is equipped with a JTAG microcontroller can be
> > +         supported by using this driver's interfaces.
> > +         This driver exposes a set of IOCTLs to the user space for
> > +         the following commands:
> > +         SDR: (Scan Data Register) Performs an IEEE 1149.1 Data Register scan
> > +         SIR: (Scan Instruction Register) Performs an IEEE 1149.1 Instruction
> > +         Register scan.
> > +         RUNTEST: Forces the IEEE 1149.1 bus to a run state for a specified
> > +         number of clocks or a specified time period.
> 
> Something feels wrong with formatting here.
> 

Will fix

> > +#define MAX_JTAG_NAME_LEN (sizeof("jtag") + 5)
> 
> Interesting definition. Why not to set to 10 explicitly? And why 10?
> (16 sounds better)
> 
5 - is a max len of JTAG device id in device name. I will add define to it.

In general I don't see the case for the system with hundreds JTAG interfaces.
I will limit maximum jtag master to 255 devices and change  id len to 3

#define MAX_JTAG_ID_STR_LEN 5
#define MAX_JTAG_NAME_LEN (sizeof("jtag") + MAX_JTAG_ID_STR_LEN)

> > +struct jtag {
> > +       struct miscdevice miscdev;
> 
> > +       struct device *dev;
> 
> Doesn't miscdev parent contain exactly this one?

Yes. 
Will fix.

> 
> > +       const struct jtag_ops *ops;
> > +       int id;
> > +       bool opened;
> > +       struct mutex open_lock;
> > +       unsigned long priv[0];
> > +};
> 
> > +               err = copy_to_user(u64_to_user_ptr(xfer.tdio),
> > +                                  (void *)(xfer_data), data_size);
> 
> Redundant parens in one case. Check the rest similar places.
> 

Yes.

> > +static int jtag_open(struct inode *inode, struct file *file) {
> 
> > +       struct jtag *jtag = container_of(file->private_data, struct jtag,
> > +                                        miscdev);
> 
> I would don't care about length and put it on one line.
> 

But following to LINUX kernel style, it should be no longer than 80 symbols. 
It will not pass by  ./scripts/checkpatch.pl

Will it be OK to send a patch which failed 80 symbols limitation check?

> > +       if (jtag->opened) {
> > +       jtag->opened = true;
> > +       jtag->opened = false;
> 
> Can it be opened non exclusively several times? If so, this needs to 
> be a ref counter instead.

It can be opened only once.

> 
> > +       if (!ops->idle || !ops->mode_set || !ops->status_get || !ops->xfer)
> > +               return NULL;
> 
> Are all of them mandatory?
> 

Yes, except "mode_set"
Will remove mode_set from check

> > +int jtag_register(struct jtag *jtag)
> 
> Perhaps devm_ variant.

Jtag driver uses miscdevice and related  misc_register and misc_deregister 
calls for creation and destruction. There is no device object prior to 
call to  misc_register, which could be used in devm_jtag_register.

> 
> > +#define jtag_u64_to_ptr(arg) ((void *)(uintptr_t)arg)
> 

Redundant. Removed.

> Where is this used or supposed to be used?
> 
> > +#define JTAG_MAX_XFER_DATA_LEN 65535
> 
> Is this limitation from some spec?
> Otherwise why not to allow 64K?
> 

It not limited by specification.  
But we enforce an upper bound for the length here, to prevent users from draining 
kernel memory with giant buffers.
So it was limited by  size of unsigned short int (65535)

> > +/**
> > + * struct jtag_ops - callbacks for jtag control functions:
> > + *
> > + * @freq_get: get frequency function. Filled by device driver
> > + * @freq_set: set frequency function. Filled by device driver
> > + * @status_get: set status function. Filled by device driver
> > + * @idle: set JTAG to idle state function. Filled by device driver
> > + * @xfer: send JTAG xfer function. Filled by device driver  */
> 
> Perhaps you need to describe which of them are _really_ mandatory and 
> which are optional.
> 

Ok

> --
> With Best Regards,
> Andy Shevchenko

Best Regards,
Oleksandr Shamray
