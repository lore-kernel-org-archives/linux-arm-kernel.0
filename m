From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Sep 2016 10:35:26 +0100
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160907092901.GC13903@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <20562703.Glp77l1PBf@wuerfel>
 <20160907074428.GB13903@b29397-desktop>
 <4780626.ofOZnpf19s@wuerfel>
 <20160907092901.GC13903@b29397-desktop>
Message-ID: <20160907093525.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 05:29:01PM +0800, Peter Chen wrote:
> On Wed, Sep 07, 2016 at 10:52:46AM +0200, Arnd Bergmann wrote:
> > On Wednesday, September 7, 2016 3:44:28 PM CEST Peter Chen wrote:
> > > 
> > > The pre-condition of DT function at USB HCD core works is the host
> > > controller device has of_node, since it is the root node for USB tree
> > > described at DT. If the host controller device is not at DT, it needs
> > > to try to get its of_node, the chipidea driver gets it through its
> > > parent node [1]
> > 
> > > 
> > > [1] https://lkml.org/lkml/2016/8/8/119
> > > 
> > 
> > Ah, this is what I was referring to in the other mail.
> > 
> > However, the way you set the of_node might be dangerous too:
> > We should generally not have two platform_device structures with
> > the same of_node pointer, most importantly it may cause the
> > child device to be bound to the same driver as the parent
> > device since the probing is done by compatible string.
> > 
> > As you tested it successfully, it must work at the moment on your
> > machine, but it could easily break depending on deferred probing
> > or module load order.
> > 
> 
> Currently, I work around above problems by setting core device of_node
> as NULL at both probe error path and platform driver .remove routine.
> 
> I admit it is not a good way, but if we only have of_node at device's
> life periods after probe, it seems ok currently. It is hard to create
> of_node dynamically when create device, and keep some contents
> of parent's of_node, and some are not.

How about turning dwc3 into a library which can be used by a range of
platform devices?  Wouldn't that solve all the current problems, and
completely avoid the need to copy resources from one platform device
to another?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
