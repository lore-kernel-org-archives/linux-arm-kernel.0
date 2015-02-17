From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 17 Feb 2015 12:38:04 -0500 (EST)
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <20150217074310.GT14545@x1>
References: <20150216130549.GF14545@x1>
 <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
 <20150216162712.GR14545@x1> <87fva5a4i2.fsf@free.fr>
 <20150217074310.GT14545@x1>
Message-ID: <alpine.LFD.2.11.1502171221300.22104@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Feb 2015, Lee Jones wrote:

> Arnd, Greg,
> 
>   Perhaps you have some ideas WRT programmables (PLDs/CPLDs/FPGAs)?

FWIW...

The Lubbock is an ancient development board (circa 2003) using a CPLD to 
multiplex a couple things on the board.  I really doubt anyone would 
reprogram this CPLD at this point. So I'd treat it just like another 
interrupt controller + random peripherals that will never change.  And 
yes, maybe a more appropriate name is needed.

And I happen to have one such beast on my desk wasting significant 
realestate and picking up dust.  I don't think I booted it even once in 
the last 3 years.  I'm seriously considering a trip to the recycling 
facility to dispose of it unless someone wants it and is ready to pay 
for the shipping.

> On Mon, 16 Feb 2015, Robert Jarzmik wrote:
> > Lee Jones wrote:
> > > What's all this?  Please configure your mail client correctly.
> > >
> > > For advice, see:
> > >
> > >   Documentation/email-clients.txt
> > While at day work, I have only access to web mail ...
> 
> Probably best to hold off your reply until you get home then.  It's
> not just a formatting issue, you also exposed many raw email addresses
> to the internet, which are easily harvested up by web crawlers.
> 
> See this:
>   https://lkml.org/lkml/2015/2/16/247
> 
> > >>  2) after v2, we _both_ agreed that the accurate name is "cplds"
> > >>     which exactly what is in this patch
> > >>     (see device registering with lubbock_cplds).
> > >
> > > There is no mention of this decision in the changelogs.  If it's not
> > > in the change logs, it didn't happen. ;)
> > Ah right.
> > 
> > > I'm still concerned with the fact that the driver file is named using
> > > and is populated by lots of instances of a "board" name.  I'm sure you
> > > would share my thoughts is someone submitted a driver called
> > > beaglebone.c or raspberrypi.c to MFD.
> > I understand your concern. Arnd, a thought about it ? The only viable
> > alternative would be to move it to arch/arm/plat-pxa AFAIS.
> 
> I don't think this is correct either.  CPLD handling would probably be
> slightly less out of place in drivers/misc, but perhaps a new
> subsystem for PLDs/CPLDs/FPGAs would be more appropriate
> drivers/programmables or similar maybe.
> 
> > >> > Besides, this is MFD, where we support single pieces of silicon which
> > >> > happen to support multiple devices.  I definitely don't want to support
> > >> > boards here.
> > >> > You might want to re-think the naming and your (sales) pitch.
> > >> I might need help. As for the (sales), no comment.
> > >
> > > By pitch, I mean to convince me that this belongs in MFD.
> > I've been trying.
> 
> I'm pretty convinced that it doesn't belong in MFD now, but it doesn't
> mean I'm going to leave you on the curb.  I'd like to help you get it
> into a better home.
> 
> [...]
> 
> > > Understanding was lost when I learned that the whole file was centred
> > > around the premise of board support.  I understand now that this is a
> > > driver for a CPLD, which I'm not sure is even MFD.  Also, if it is
> > > really a CPLD driver, shouldn't be named after the manufacturer/model
> > > number of the chip, rather than the PCB which it's connected to?
> > >
> > > I'm also concerned that this driver has no functional CPLD code
> > > contained.  All you're doing is defining an IRQ domain.  Why then
> > > isn't this really an drivers/irqchip (Suggested-by: Josh Cartwright)
> > > driver?
> > Is not only a irqchip because, as explained at the bottom of the commit message,
> > quoting myself :
> >   This patch moves all that handling to a mfd driver. It's only purpose
> >   for the time being is the interrupt handling, but in the future it
> >   should encompass all the motherboard CPLDs handling :
> >    - leds
> >    - switches
> >    - hexleds
> 
> I had a conversation about this on IRC yesterday and some good
> points/questions were posed.  This is a difficult area, because you
> can program these things to do whatever you like.  Depending on the
> 'intention' (and it is only an intention -- someone else can come
> along and reprogram these devices on a whim), the CPLD code could live
> anywhere.  If you wanted to put watchdog functionality in there, then
> there is an argument for it to live in drivers/watchdog, etc etc.  So
> just because the plan is to support a few (i.e. more than one) simple
> devices, it doesn't necessarily mean that the handling should be done
> in MFD.
> 
> Yesterday I was asked "Are you wanting to restrict drivers in
> drivers/mfd to those that make use of MFD_CORE functionality?".  My
> answer to that was "No, however; I only want devices which
> _intrinsically_ operate in multiple subsystems", which these
> programmables no not do.
> 
> FYI, you're not on your own here.  There is at least one of these
> devices in the kernel already and upon a short inspection there
> appears to be a number of Out-of-Tree (OoT) drivers out there which
> will require a home in Mainline sooner or later.
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
