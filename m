From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 11:56:14 +0100
Subject: [PATCH v2 03/10] ARM: mvebu: add workaround for data abort
 issue on Armada 375
In-Reply-To: <2289743.0TLVompA6m@wuerfel>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392200619-3141-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <2289743.0TLVompA6m@wuerfel>
Message-ID: <20140213115614.71e95251@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 12 Feb 2014 14:10:35 +0100, Arnd Bergmann wrote:
> On Wednesday 12 February 2014 11:23:32 Thomas Petazzoni wrote:
> > +/*
> > + * Early versions of Armada 375 SoC have a bug where the BootROM
> > + * leaves an external data abort pending. The kernel is hit by this
> > + * data abort as soon as it enters userspace, because it unmasks the
> > + * data aborts at this moment. We register a custom abort handler
> > + * below to ignore the first data abort to work around this problem.
> > + */
> > +static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
> > +                                       struct pt_regs *regs)
> > +{
> > +       static int ignore_first;
> > +
> > +       if (!ignore_first) {
> > +               ignore_first = 1;
> > +               return 0;
> > +       }
> > +
> > +       return 1;
> > +}
> 
> I think this should try to match the fsr and addr field if possible and
> only ignore the one external abort you expect.

I've added a check on fsr. Checking addr is not possible, because the
address changes from one boot to another. I must say I don't really
know the details of the BootROM code that leaves this data abort
pending, but it looks like the address that triggers the data abort is
not always the same.

Thanks for your review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
