From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 12 Jan 2012 16:22:52 -0700 (MST)
Subject: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
In-Reply-To: <4F0EEA9B.3030104@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>
 <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
 <4EEB086A.2050607@ti.com>
 <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
 <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com>
 <87hb03tw8h.fsf@ti.com> <4F0D26DF.1020108@ti.com>
 <alpine.DEB.2.00.1201110619090.31702@utopia.booyaka.com>
 <4F0D9B70.3000309@ti.com>
 <alpine.DEB.2.00.1201110809530.31702@utopia.booyaka.com>
 <4F0EEA9B.3030104@ti.com>
Message-ID: <alpine.DEB.2.00.1201121617300.3659@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Jan 2012, Cousson, Benoit wrote:

> On 1/11/2012 4:22 PM, Paul Walmsley wrote:
> > On Wed, 11 Jan 2012, Cousson, Benoit wrote:
> > 
> > > Something that puzzle me on that point is most architecture does not use
> > > plateform_device and thus does not have any pdata to hack some custom
> > > function
> > > pointers here an there.
> > > It means that there is probably some better solution to handle that.
> > 
> > PCI and USB have their own bus-level device reset functions that are
> > exported from bus code that lives under drivers/.  In a similar fashion,
> > we could export omap_device_reset() from our arch/arm/plat-omap code.
> > But that would require that arch/arm/plat-omap and arch/arm/mach-omap2
> > code to be compiled for any ARM build that includes i2c-omap.c.  This
> > would be good to avoid, under the principle that drivers should be
> > buildable for any architecture.  (This is also why we wish to remove
> > omap_{read,write}*() and cpu_is_omap() from any drivers which contain
> > those.)
> > 
> > The intention a few years ago was to eventually create a a real omap_bus
> > and omap_device, with the bus/device integration code living under
> > drivers.  In such a situation, we'd be able to use something like the
> > PCI/USB approach cleanly, since there wouldn't be dependencies to arch/
> > code.
> 
> For reset, maybe the custom bus is a better approach, since it is something
> that is handled by the OMAP core infrastructure.
> I was referring more to all the other function pointer we have today in driver
> like MMC, DSS that does not necessarily belong to a OMAP core stuff.

Yes, that's right.  In general, cross-device dependencies with no 
infrastructural consequences should be handled by EXPORT_SYMBOL() between 
driver code.


- Paul
