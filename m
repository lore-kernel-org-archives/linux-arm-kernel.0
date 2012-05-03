From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 3 May 2012 18:21:27 +0000
Subject: [PATCH] net: davinci_emac: Add pre_open, post_stop platform
 callbacks
In-Reply-To: <20120503160917.GA11310@animalcreek.com>
References: <20120502234718.GA5432@animalcreek.com>
 <B5906170F1614E41A8A28DE3B8D121433EA72820@DBDE01.ent.ti.com>
 <20120503160917.GA11310@animalcreek.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EA73591@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 21:39:18, Mark A. Greer wrote:
> On Thu, May 03, 2012 at 10:44:44AM +0000, Bedia, Vaibhav wrote:
> > On Thu, May 03, 2012 at 05:17:18, Mark A. Greer wrote:
> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > > 
> > > The davinci EMAC driver has been incorporated into the am35x
> > > family of SoC's which is OMAP-based.  The incorporation is
> > > incomplete in that the EMAC cannot unblock the [ARM] core if
> > > its blocked on a 'wfi' instruction.  This is an issue with
> > > the cpu_idle code because it has the core execute a 'wfi'
> > > instruction.
> > > 
> > > To work around this issue, add platform data callbacks which
> > > are called at the beginning of the open routine and at the
> > > end of the stop routine of the davinci_emac driver.  The
> > > callbacks allow the platform code to issue disable_hlt() and
> > > enable_hlt() calls appropriately.  Calling disable_hlt()
> > > prevents cpu_idle from issuing the 'wfi' instruction.
> > > 
> > > It is not sufficient to simply call disable_hlt() when
> > > there is an EMAC present because it could be present but
> > > not actually used in which case, we do want the 'wfi' to
> > > be executed.
> > > 
> > 
> > Are you trying to say that if ARM executes _just_ wfi and _absolutely
> > nothing else_ is done in the OMAP PM code, EMAC stops working?
> 
> No, I'm saying the EMAC can't wake the core from the wfi so if nothing
> else happens in the system, its effectively hung.  If something else
> does happen in the system (e.g., a timer expires), the the system is
> extremely slow because because its only waking up when a timer (or
> something else wakes it up--but not net traffic).  This is very apparent
> when using an nfs-mounted rootfs. It doesn't hang but its extremely
> slow because occasionally something else wakes up the core but it
> spends most of its time stuck in the wfi when it should be handling
> net/nfs traffic.
> 

So, if I understood this correctly, it's effectively like blocking a low power
state transition (here wfi execution) when EMAC is active?
