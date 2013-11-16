From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Nov 2013 11:41:34 +0000
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <20131116112754.GT15393@sirena.org.uk>
References: <52864BBC.7000506@koalo.de> <1384537403.14845.131.camel@smile>
 <20131115175155.GQ16735@n2100.arm.linux.org.uk>
 <CAHp75Vf3CJNgSiSjoZ6dYjRRHWN4bTpMxRTLG37+wwtEsQbq4g@mail.gmail.com>
 <20131116112754.GT15393@sirena.org.uk>
Message-ID: <20131116114134.GU16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 11:27:54AM +0000, Mark Brown wrote:
> On Sat, Nov 16, 2013 at 11:37:54AM +0200, Andy Shevchenko wrote:
> 
> > The reason why I was asking about I'm just wondering what we have to do
> > with existing drivers. Shall we convert them to be initialized as normal
> > platform drivers instead of subsys_initcall?
> 
> We should in general be moving in that direction however it does need a
> bit of care to make sure that there aren't any dependencies which do
> things like discard error codes, fail to check errors or treat errors as
> hard failures.

I don't agree: on platforms which have done this, it's very difficult to
tell from reading the kernel message log whether things came up correctly
because there's soo much spew from deferred probing it's virtually
impossible to tell whether component X initialised or whether that error
about resource Y missing was ever resolved.

The only way that can be checked is when things work (or don't) from
userspace.

It's soo bad on some platforms that reading the kernel boot log is a
total waste of time; you don't get any useful information from it.

If we want kernel boot logs to be useful, we really need to shut up *all*
the drivers and subsystems whinging about being deferred probing, and only
have the driver model core reporting this status - maybe only allow
output about why at debug level or similar.
