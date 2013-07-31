From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 31 Jul 2013 09:55:06 +0100
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
 <1375195354.32691.55.camel@kazak.uk.xensource.com>
 <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
Message-ID: <1375260906.32691.93.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 12:48 -0500, Matt Sealey wrote:
> * An AArch64 guest under an AArch32 hypervisor/sm seems pretty weird
> and in any case, the device tree would use the 32-bit convention (any
> SMC64 call in 32-bit state should return "Unknown SMC Function
> Identifier" if that bit is set)

I don't believe 64-bit EL1 under 32-bit EL2 is allowed by the
architecture. Each EL must be at least the width of the one below it.

> TLDR; Supply your (EL1) guests with the preferred method, not a list
> of all possible methods, as above. If you're the vendor and you
> defined any part of EL3 or EL2 you're in complete control of which
> method you want subordinate levels to use by way of implementation,
> right?

I haven't seen the entirety of this discussion, but that seems logical
to me.

> 
> BTW according to the specs you can't have EL2 without EL3 on ARMv7. I
> would think the issues with hvc vs hvc64 need to be thought out;
> hypervisors can trap SMC from their guests and do the right thing
> without the guest ever knowing that a hypervisor is above it.

The issue is that SMC traps don't provide you with the #imm in the
syndrome register so you need to fetch and decode the instruction in the
hypervisor manually, which is possible but faffsome and relatively
costly (mostly due to the need to map guest memory on demand).

> If it is the case that every Xen DomU kernel needs to know that it is
> virtualized and to be told to use HVC instead of SMC? What's the
> benefit of that?

Just the avoidance of a fetch and decode, I think.

I'm also not sure if Secure world can't prevent NS EL2 from tapping SMC,
would need to check the specs.

Ian.
