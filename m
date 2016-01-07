From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 7 Jan 2016 15:52:37 +0100
Subject: [PATCH v4 55/58] mtd: nand: add helpers to access ->priv
In-Reply-To: <20160106231323.GM109450@google.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
 <20151218221758.GQ10460@google.com>
 <20151219040124.7ffe4274@bbrezillon>
 <20160106231323.GM109450@google.com>
Message-ID: <20160107155237.7271aa7e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Wed, 6 Jan 2016 15:13:23 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> On Sat, Dec 19, 2015 at 04:01:24AM +0100, Boris Brezillon wrote:
> > Actually the nand_{get,set}_controller_data() helpers are not about
> > assigning NAND controller private data (as you pointed those can
> > already be retrieved thanks to the ->controller field using the
> > container_of() trick), but per-chip private data instantiated by the
> > NAND controller and attached to a specific chip. For example, some
> > controllers pre-compute some register values or a clk rate to set when
> > a specific chip is selected. This is what per-chip controller data is
> > meant for.
> 
> Sure. Really, it's just anything the controller driver needs to store on
> a per-chip basis. All I'm suggesting is picking a name that doesn't
> imply it's a per-controller instance, when it's actually a
> per-flash-chip instance.
> 
> > Now, the reason I explicitly specified the data usage instead of using
> > a generic name like nand_{get,set}_data() is because I plan to define
> 
> I never suggested just "_data"; I said "_drvdata".

Not sure it clarifies the per-chip aspect ;), and driver is, IMHO, too
generic: I also consider manufacturer specific code as drivers (but in
this case they are chip drivers, not controller drivers).

How about nand_{get,set}_ctrldrvdata()?

> 
> > other helpers to allow NAND manufacturer code to manipulate its own
> > private data. This is required if we want to support read-retry on some
> > chips who are requiring a read OTP area step to retrieve some register
> > values which will later be used to change from one read-retry mode to
> > another.
> > The plan was to define the nand_{set,get}_manufacturer_data() helpers,
> > and create or reuse an existing priv field (mtd->priv?) to store this
> > private data.
> 
> That's interesting. Sounds like an OK idea. (Personally, I wouldn't
> try to use mtd->priv for this, but otherwise looks OK.)

Yes, I don't like the idea of using mtd->priv to store that, but it's
shame to have this unused field and create another one :p.

> 
> > Also note that the spi framework provides the same kind of helpers [1].
> 
> Hmm, OK. FWIW, they have both "driver data" and "controller state". It's
> not perfectly clear to me why both exist.

Well, "driver data" in this case is the data used by the i2c device
driver (the driver communicating with the device on the i2c bus), while
the "controller state" is the per-device controller specific data.
If we do the analogy with the NAND framework, I'd consider the
"SPI controller state" as what I call here the "NAND controller per-chip
data", and the "SPI driver data" as the "manufacturer data".

I know the names are not necessarily better in the SPI framework, but I
think we should find names that describe as much as possible which
data is used by which part of the code. 

> 
> > This being said, I'm perfectly fine changing the function names, but
> > I'd like to replace it by something explicitly telling the user that
> > this field should only be set by NAND controller drivers. 
> 
> Sure. I though a "driver data"-based name did this. But I'll leave it to
> you. I could even be OK with "controller data", if you still think this
> fits your overall controller refactoring plan, and communicates its
> purpose best.

If you're OK with that I'd like to keep a name containing the
'controller' or 'ctrl' word in it:
1/ nand_{get,set}_controller_data() (the names originally proposed)
2/ nand_{get,set}_ctrldrv_data() or nand_{get,set}_ctrldrvdata()

What do you prefer?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
