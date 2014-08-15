From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Aug 2014 08:43:36 +0200
Subject: [linux-sunxi] Re: [PATCH 3/4] simplefb: disable dt node upon
 remove
In-Reply-To: <CAKON4Oyp0qCucAhTNeXu7LELv_MRXPkYum+jOH2QADHb4Lw_HA@mail.gmail.com>
References: <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be>
 <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <CAKON4OzQbuaQsbTCDXuaqxLRxvat_5+wmf71S-rWXdfiT1gkvA@mail.gmail.com>
 <CACxGe6v1UPHMF5aPpe-boh+RuoPArJmKK_cQWr7aXsRjDUZrfQ@mail.gmail.com>
 <CAKON4OypgToTSXxjShCt6uTGZBU69LpJxRwVoz=PnotpL=zm4w@mail.gmail.com>
 <1408063512.890.22.camel@localhost>
 <CAKON4Oyp0qCucAhTNeXu7LELv_MRXPkYum+jOH2QADHb4Lw_HA@mail.gmail.com>
Message-ID: <20140815064336.GX15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 09:27:14PM -0400, jonsmirl at gmail.com wrote:
> On Thu, Aug 14, 2014 at 8:45 PM, Henrik Nordstr?m
> <henrik@henriknordstrom.net> wrote:
> > tor 2014-08-14 klockan 08:07 -0400 skrev jonsmirl at gmail.com:
> >
> >> So what are the rules going to be? Once the OS is up and starts
> >> changing things the state in the DT and the OS are going to diverge.
> >> How does this get handled for a kernel driver that can load/unload?
> >> Should the kernel remove those state nodes as soon as it alters the
> >> state?
> >
> > hardware that is no longer there should also not be represented/active
> > in DT.
> >
> > A simple fb that have been torn down is no more, no different from never
> > having been there. It can be argued that it never was in the first place
> > (i.e. that it is not actually hardware) but that it another can of worms
> > and both have their benefits and drawbacks. One thing is certain
> > however, as far as simplefb is concerned it is hardware, not really any
> > different from a persistent framebuffer with hardwired settings in
> > hardware.
> 
> How does the kernel know what clocks to protect? A list in the
> simplefb node?  This list of clocks is a reason for adding simplefb to
> the compatible list for the real hardware.  That way it won't be
> duplicated.
> 
> The issues with parameter conflicts between simplefb and the real
> hardware can be dealt with.  If the real hardware wants to add the
> simplefb compatible field it will need to get its parameters sorted
> out so that they don't conflict. Clock syntax is standardized in the
> DTS so it shouldn't be a problem.

It shouldn't be, but apparently, some disagree.

Anyway, I'm not sure having the simplefb compatible would work in this
use-case, mainly for two reasons:
  - Most likely, the bindings are going to be very different. Not only
    about which properties you'll have, but also what you will place
    in these properties. reg for example have the memory address of
    the buffer in the simplefb case, while in the KMS driver case, it
    would have the memory address of the registers.
  - There's will be a single driver probed. So if you want to go down
    the hand over road (which is a bit premature at this point if you
    ask me, but anyway), you will have no driver probed to hand over
    to.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140815/3cb2347d/attachment.sig>
