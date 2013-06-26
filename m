From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 23:23:50 +0200
Subject: [PATCH 0/2] arm: add early_ioremap() support
In-Reply-To: <20130626192352.GE9078@rocoto.smurfnet.nu>
References: <1372182401-11029-1-git-send-email-leif.lindholm@linaro.org>
 <201306262052.09640.arnd@arndb.de> <20130626192352.GE9078@rocoto.smurfnet.nu>
Message-ID: <201306262323.50691.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Leif Lindholm wrote:
> On Wed, Jun 26, 2013 at 08:52:09PM +0200, Arnd Bergmann wrote:
> > I made a similar suggestion to extending the use of fixmap recently, see
> > "Re: SCU registers mapping for CA9/CA5 cores". Russell pointed out that
> > fixmap is intentionally limited to just kmap_atomic uses at the moment
> > and changing that would potentially have a significant impact when we
> > run out of pages in the fixmap area.
>  
> Is this an issue here, since (unlike x86) this early_ioremap only works
> before paging_init()?

The main problem is that the total fixmap size is only around 900kb,
and we want to reserve at least 64kb per cpu for kmap_atomic.
If you want to fit multiple 128kb mappings in there, you run out of
space really fast.


> > Extending the iotable mechanism on ARM would be the convenient
> > solution for us I think.
> 
> Could that easily be extended to give similar semantics sufficiently
> that we can progress with merging more of the UEFI and ACPI support 
> together as common code with x86/ia64?

I don't know what the requirements are, but the idea with iotable
is that the mappings stay around at run time, while it seems you want
to discard them at some point.

	Arnd
