From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Mar 2016 21:55:55 +0200
Subject: [RFC PATCH 00/45] KVM: arm/arm64: Rework virtual GIC emulation
In-Reply-To: <56FBC16A.7040404@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
 <56FA7F29.4060005@arm.com> <56FBBBC2.6010602@arm.com>
 <56FBC16A.7040404@arm.com>
Message-ID: <20160330195555.GL4126@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 01:07:06PM +0100, Marc Zyngier wrote:
> On 30/03/16 12:42, Vladimir Murzin wrote:
> > On 29/03/16 14:12, Vladimir Murzin wrote:
> >> Hi Andre,
> >>
> >> On 25/03/16 02:04, Andre Przywara wrote:
> >>> Please have a look at the series, review it and give the code some
> >>> serious testing (and possibly debugging). All feedback is appreciated.
> >>
> >> I see that with the new vgic implementation kvmtool starts throwing:
> >>
> >> kvm [1273]: Unable to register VGICv3 redist MMIO regions
> >>
> > 
> > It comes from kvm_io_bus_register_dev()
> > 
> > if (bus->dev_count - bus->ioeventfd_count > NR_IOBUS_DEVS - 1)
> > 	return -ENOSPC;
> > 
> > with bus->dev_count being 1000
> 
> Ouch. That's a consequence of having one "device" per actual register
> set, I believe. So either we bump this limit up by a factor 10 (at
> least), or we switch back to the old way of handling access to the GIC
> regions (big "catch-all", and further demuxing).
> 
> Thoughts?
> 
Since we have to have code to iterate through the individual register
regions for the userland MMIO accesses anyway, I think we should just
revert back to the old way.

-Christoffer
