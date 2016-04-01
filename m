From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 1 Apr 2016 14:17:43 +0200
Subject: [RFC PATCH 12/45] KVM: arm/arm64: vgic-new: Add MMIO handling
 framework
In-Reply-To: <56FE655A.1040402@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
 <1458871508-17279-13-git-send-email-andre.przywara@arm.com>
 <20160331090824.GR4126@cbox> <56FE655A.1040402@arm.com>
Message-ID: <20160401121743.GB22170@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 01:11:06PM +0100, Andr? Przywara wrote:
> On 31/03/16 10:08, Christoffer Dall wrote:
> > Hi Andre,
> > 
> > [cc'ing Paolo here for his thoughts on the KVM IO bus framework]
> > 
> > On Fri, Mar 25, 2016 at 02:04:35AM +0000, Andre Przywara wrote:
> >> We register each register group of the distributor and redistributors
> >> as separate regions of the kvm-io-bus framework. This way calls get
> >> directly handed over to the actual handler.
> >> This puts a lot more regions into kvm-io-bus than what we use at the
> >> moment on other architectures, so we will probably need to revisit the
> >> implementation of the framework later to be more efficient.
> > 
> > Looking more carefully at the KVM IO bus stuff, it looks like it is
> > indeed designed to be a *per device* thing you register, not a *per
> > register* thing.
> > 
> > My comments to Vladimir's bug report notwithstanding, there's still a
> > choice here to:
> > 
> > 1) Expand/modify the KVM IO bus framework to take an arbitrary number of devices
> > 
> > 2) Build a KVM architectureal generic framework on top of the IO bus
> > framework to handle individual register regions.
> 
> > 
> > 3) Stick with what we had before, do not modify the KVM IO bus stuff,
> > and handle the individual register region business locally within the
> > arm/vgic code.
> 
> I am for either 1) or 2). I consider "the old way" a kludge. We couldn't
> use KVM IO bus when the VGIC was introduced, because it lacked the VCPU
> parameter. Later this was fixed, but introducing the framework all the
> way down to the individual register handlers wasn't feasible without
> rewriting much of the VGIC. Since we now do exactly this, I'd love to
> pimp the KVM IO bus framework to properly cope with the "many register"
> use case. Instead of writing KVM/ARM specific code I'd rather see this
> solved properly for the whole KVM subsystem. The other framework users
> don't seem to have high demands, so adjusting them should be easy.
> If this is considered too much for the first patch incarnation, we could
> consider a temporary wrapper that gets removed later when the KVM IO bus
> framework gets fixed/reworked - but we should keep the VGIC MMIO handler
> prototypes in a way that allows them to be called directly later.
> 
I was somewhere between (2) and (3), but given Paolo leans towards (3),
and that we have plenty of work here already, I think that doing (3) in
a way that allows us to do (2) easily later on if we feel like it is
probably the rigth direction to take at the moment.

Thanks,
-Christoffer
