From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 31 Jul 2013 14:49:17 +0100
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
 <1375195354.32691.55.camel@kazak.uk.xensource.com>
 <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
Message-ID: <20130731134917.GN29859@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 06:48:59PM +0100, Matt Sealey wrote:
> Isn't this being overthought?
> 
> "method" (I would have re-used model, but that's by-the-by) should
> just determine which call interface to use. Only one should end up in
> a device tree - it doesn't make a lot of sense to specify more than
> one, to me, given my read of the specs and the SMC calling convention.
> 
> For AArch64 chips they should implement 64-bit SMC interface or 32-bit
> SMC interface. Either way you get there, the function number is
> encoded with the type of call anyway so AArch64 secure monitors or
> hypervisors will know which one was intended, given the SMC calling
> convention defines this "64-bit" bit pretty clearly. The "method" is
> an instruction to the "guest OS" in how to fill it's registers more
> than it is in function names.

Implementations may not follow the recommended ID allocations, and thus
we cannot rely on the function ID to provide us with any useful
information. We certainly cannot rely on it for hvcs, where for an
existing implementation (KVM) uses the same IDs for 32-bit and 64-bit
guests.

If we force the use of said bit, then new kernels cannot necessarily
work on existing PSCI implementations (which may not handle the use of
said bit as you expect). If we make the binding for psci-0.2 explicitly
require the use of this bit, then future firmware/virtualisation code
cannot provide new functionality withoot breaking backwards compatiblity
with existing kernels, as an "arm,psci-0.2" node would be incompatible
with an "arm,psci" node (which is all an existing kernel can handle).

> 
> * An AArch64 guest under an AArch32 hypervisor/sm seems pretty weird
> and in any case, the device tree would use the 32-bit convention (any
> SMC64 call in 32-bit state should return "Unknown SMC Function
> Identifier" if that bit is set)

This is not allowed by the architecture.

> * An AArch32 guest under an AArch32  hypervisor/sm would use the
> 32-bit convention
> * An AArch32 guest under an AArch64 hypervisor/sm would use the 32-bit
> convention

Both of these cases are trivially mandated by the architecture.

> * An AArch64 guest under an AArch64 hypervisor/sm would use the 64-bit
> convention or the 32-bit convention depending on how the sm is
> written, but it doesn't matter which is used if both can be
> supported.. but you'd only want to use one of them.

Not all implementation will implement both, so there needs to be a way
to describe that. Which is actually used is up to the OS.

> 
> TLDR; Supply your (EL1) guests with the preferred method, not a list
> of all possible methods, as above. If you're the vendor and you
> defined any part of EL3 or EL2 you're in complete control of which
> method you want subordinate levels to use by way of implementation,
> right?

As far as I can tell, no-one was arguing against this strategy. However,
for those cases where functionality is implemented for only one
register-width, or requires a different ID per register-width, this
needs to be described somehow.

Thanks,
Mark.
