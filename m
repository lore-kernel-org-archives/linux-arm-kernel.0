From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 19 Dec 2015 04:01:24 +0100
Subject: [PATCH v4 55/58] mtd: nand: add helpers to access ->priv
In-Reply-To: <20151218221758.GQ10460@google.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
 <20151218221758.GQ10460@google.com>
Message-ID: <20151219040124.7ffe4274@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Fri, 18 Dec 2015 14:17:58 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> Hi Boris,
> 
> On Thu, Dec 10, 2015 at 09:00:39AM +0100, Boris Brezillon wrote:
> > Add two helpers to access the field reserved for private controller data.
> > This makes it clearer what this field is reserved for and ease future
> > refactoring.
> 
> I agree with the refactoring part, but I'm not sure about the name. Is
> it really "controller" data? That sounds like something that has 1
> instance per controller. But the way this is sometimes used, we get 1
> instance per NAND chip, and there may be more than one NAND chip per
> controller.
> 
> So at the moment, this is more like opaque "driver data", like
> dev_{get,set}_drvdata(), which doesn't really have a prescribed use --
> it's up to the driver.
> 
> Notably, we already have a (sort of) 1-per-controler-instance field:
> struct nand_hw_control (I notice we have both the 'controller' and
> 'hwcontrol' fields in nand_chip; that's pretty ugly too...).

Will be addressed soon ;-).

> Those don't
> have private data fields, but we could of course extend that if we
> really want "controller" data.

Actually the nand_{get,set}_controller_data() helpers are not about
assigning NAND controller private data (as you pointed those can
already be retrieved thanks to the ->controller field using the
container_of() trick), but per-chip private data instantiated by the
NAND controller and attached to a specific chip. For example, some
controllers pre-compute some register values or a clk rate to set when
a specific chip is selected. This is what per-chip controller data is
meant for.

Now, the reason I explicitly specified the data usage instead of using
a generic name like nand_{get,set}_data() is because I plan to define
other helpers to allow NAND manufacturer code to manipulate its own
private data. This is required if we want to support read-retry on some
chips who are requiring a read OTP area step to retrieve some register
values which will later be used to change from one read-retry mode to
another.
The plan was to define the nand_{set,get}_manufacturer_data() helpers,
and create or reuse an existing priv field (mtd->priv?) to store this
private data.

Also note that the spi framework provides the same kind of helpers [1].

This being said, I'm perfectly fine changing the function names, but
I'd like to replace it by something explicitly telling the user that
this field should only be set by NAND controller drivers. 

[1]http://lxr.free-electrons.com/source/include/linux/spi/spi.h#L189

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
