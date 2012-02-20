From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Feb 2012 16:30:06 +0100
Subject: [PATCH 1/4 v2] i2c/gpio: add DT support
In-Reply-To: <20120220152748.GF26840@n2100.arm.linux.org.uk>
References: <20120220100843.GE22562@n2100.arm.linux.org.uk>
 <20120220102231.GC11307@game.jcrosoft.org>
 <20120220125054.GF22562@n2100.arm.linux.org.uk>
 <20120220133725.GD11307@game.jcrosoft.org>
 <20120220134634.GE11307@game.jcrosoft.org>
 <20120220135807.GB26840@n2100.arm.linux.org.uk>
 <20120220144635.GF11307@game.jcrosoft.org>
 <20120220150040.GC26840@n2100.arm.linux.org.uk>
 <20120220150810.GH11307@game.jcrosoft.org>
 <20120220152748.GF26840@n2100.arm.linux.org.uk>
Message-ID: <20120220153006.GK11307@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:27 Mon 20 Feb     , Russell King - ARM Linux wrote:
> On Mon, Feb 20, 2012 at 04:08:10PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 15:00 Mon 20 Feb     , Russell King - ARM Linux wrote:
> > > On Mon, Feb 20, 2012 at 03:46:35PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 13:58 Mon 20 Feb     , Russell King - ARM Linux wrote:
> > > > > On Mon, Feb 20, 2012 at 02:46:34PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > On 14:37 Mon 20 Feb     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > > On 12:50 Mon 20 Feb     , Russell King - ARM Linux wrote:
> > > > > > > > On Mon, Feb 20, 2012 at 11:22:31AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > > > > On 10:08 Mon 20 Feb     , Russell King - ARM Linux wrote:
> > > > > > > > > > On Mon, Feb 20, 2012 at 10:58:13AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > > > > > > On 18:17 Mon 13 Feb     , Karol Lewandowski wrote:
> > > > > > > > > > > > > +	- udelay: delay between GPIO operations (may depend on each platform)
> > > > > > > > > > > > > +	- timeout: timeout to get data (ms)
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > If these are really needed then I would prefer to have these fully
> > > > > > > > > > > > qualified (with unit type "-ms/-millisecs" appended).
> > > > > > > > > > > > 
> > > > > > > > > > > > Regulator framework, with its "-microvolt/-microamp", serve here as
> > > > > > > > > > > > prime example of being quite descriptive (one doesn't neet to look up
> > > > > > > > > > > > the docs). Please see:
> > > > > > > > > > > > 
> > > > > > > > > > > >   http://permalink.gmane.org/gmane.linux.ports.arm.omap/67637
> > > > > > > > > > > timeout are usualy in ms I don't really see the need of -ms or so
> > > > > > > > > > 
> > > > > > > > > > Which is obviously total crap for udelay, which would be in _micro_seconds.
> > > > > > > > > agreed but here on i2c gpio I never see timetout as udelay so I don't see
> > > > > > > > > the mandatory to force the name in the binding
> > > > > > > > > 
> > > > > > > > > futhermore it's maybe linux specific
> > > > > > > > 
> > > > > > > > Stop grabbing at straws.  There's nothing linux specific about the units
> > > > > > > > of specification.
> > > > > > > > 
> > > > > > > > What is linux specific is specifying the _delay_ rather than specifying
> > > > > > > > the bus frequency.  So as soon as you're trying to justify not adding
> > > > > > > > the units because they may be linux specific, you've already lost that
> > > > > > > > argument by using a delay rather than a bus frequency.  You can't have
> > > > > > > > it both ways.
> > > > > > > > 
> > > > > > > > Moreover, mixing microseconds and milliseconds in the properties for a
> > > > > > > > device is absolutely insane.
> > > > > > > > 
> > > > > > > > So, which ever way, your patch as it currently stands is wrong and broken.
> > > > > > >  no what I said is the binding timeout is maybe linux specific for i2c gpio
> > > > > > 
> > > > > > I do not argue about that here we do not even disucss about the bus frequency
> > > > > > but the specific bining to the i2c algo bit for it's internal timeout
> > > > > > 
> > > > > > the timeout is used to do not end in an infinite loop while ready the scl on
> > > > > > slow device
> > > > > 
> > > > > The patch is still wrong and broken.
> > > > > 
> > > > > As you're not listening to me at all, I've lost patience, so I'm just going
> > > > > to say this:
> > > > > 
> > > > > Explicit NAK on this patch.
> > > > > 
> > > > > When you feel like you can _constructively_ _consider_ the point that both
> > > > > Karol and myself have raised with respect to the _U_N_I_T_S_ then feel free
> > > > > to continue this discussion.  If not, don't waste your time writing another
> > > > > email.  I hope that's plain.
> > > >
> > > > I do not discuss about the U_N_I_T_S at all in this reply
> > > > so the NACK is no revelent
> > > 
> > > LET ME PUT IT IN BIG LETTERS FOR YOU.  I AM DISCUSSING THE UNITS ISSUE IN
> > > MY EMAILS.  YOU KEEP BRINGING UP THE LINUX SPECIFIC CRAP ABOUT UDELAY OR
> > > TIMEOUT.
> > > 
> > > I AM TALKING ABOUT UNITS.  MICROSECONDS.  MILLISECONDS.
> > > 
> > > I HAVE BEEN TALKING ABOUT UNITS ON THIS THREAD ALL DAY SO FAR.
> > > 
> > > GET IT THROUGH YOUR BIG HEAD THAT I AM DISCUSSING ABOUT THE UNITS.  I AM
> > > NOT DISCUSSING, AND HAVE NOT BEEN DISCUSSING ABOUT WHETHER BUS FREQUENCY
> > > OR DELAYS ARE APPROPRIATE IN THIS CASE.
> > > 
> > > ALL THAT I AM DISCUSSING IS ABOUT THE UNITS.  *T*H*E* *S*O*D*D*I*N*G*
> > > *U*N*I*T*S*.
> > > 
> > > HAVE YOU GOT THE FUCKING MESSAGE YET?
> > > 
> > > SO, THE NACK STANDS UNTIL YOU START REPLYING TO THE POINT I AM RAISING.
> > 
> > I just said we have 2 properties
> > 
> > - timeout which is expressed in jiffies (today in C) which is at my sense a linux specific
> >   propertie as it's representing a timeout of the i2c bit algo
> >   and here I don't see the mandatory to name it timeout-ms or timeout-milisecond
> 
> THIS IS IN MILLISECONDS.
> 
> > - udelay which is the delay between GPIO operations
> 
> THIS IS IN MICROSECONDS.
> 
> TWO DIFFERENT UNITS FOR TWO DIFFERENT PROPERTIES FOR THE SAME DEVICE.
> CONFUSING.  NACK STANDS.

I said 

> > > > > > I do not argue about that 

after I just discuss about the fact taht "timeout" is maybe linux
implementation specic and maybe need "linux," prefix that's all

Best Regards,
J.
