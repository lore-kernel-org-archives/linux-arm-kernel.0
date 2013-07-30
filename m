From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 30 Jul 2013 15:42:34 +0100
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
Message-ID: <1375195354.32691.55.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-30 at 15:33 +0100, Stefano Stabellini wrote:
> On Tue, 30 Jul 2013, Mark Rutland wrote:
> > On Tue, Jul 30, 2013 at 01:56:50PM +0100, Mark Rutland wrote:
> > > On Tue, Jul 30, 2013 at 01:42:49PM +0100, Rob Herring wrote:
> > > > On 07/30/2013 04:49 AM, Mark Rutland wrote:
> > > > > On Mon, Jul 29, 2013 at 09:18:43PM +0100, Rob Herring wrote:
> > > > >> On 07/29/2013 05:13 AM, Mark Rutland wrote:
> > > > >>> Hi Rob,
> > > > >>>
> > > > >>> On Sun, Jul 28, 2013 at 10:56:32PM +0100, Rob Herring wrote:
> > > > >>>> From: Rob Herring <rob.herring@calxeda.com>
> > > > 
> > > > [snip]
> > > > 
> > > > >>> One of the things changed in PSCI 0.2 was the SMC calling convention,
> > > > >>> though this isn't clear in the PSCI document. The function IDs for 32bit
> > > > >>> and 64bit callers may differ, and we need to support describing an
> > > > >>> arbitrary configuration of the two (same ID for both, different across
> > > > >>> 32-bit/64-bit, only supported for 64-bit, only supported for 32-bit).
> > > > >>>
> > > > >>> I'd like to ensure the binding can deal with that from the start. We
> > > > >>> could do this by having -32 and -64 variants of each function id (e.g.
> > > > >>> cpu_off-64) , if the IDs actually differ, and use the regular combined
> > > > >>> ID if they don't.
> > > > >>
> > > > >> Uggg. I guess I should have read the SMC calling convention doc... I was
> > > > >> simply documenting what is already in the PSCI doc, but obviously that
> > > > >> is not fully flushed out.
> > > > >>
> > > > >> How about something like this (for the complicated case of both 32 and
> > > > >> 64 bit):
> > > > >>
> > > > >> 	method		= "smc", "smc64";
> > > > >> 	psci_version	= <0x84000000 0xc4000000>;
> > > > >> 	cpu_suspend	= <0x84000001 0xc4000001>;
> > > > >> 	cpu_off		= <0x84000002 0xc4000002>;
> > > > >> 	cpu_on		= <0x84000003 0xc4000003>;
> > > > >>
> > > > >> "smc" is a synonym for smc32 for compatibility. The number and order of
> > > > >> methods determines the number and order of function IDs.
> > > > > 
> > > > > While this may be compatible with the arm implementation, it won't be
> > > > > compatible with the arm64 implementation, which assumes smc64 by
> > > > > default.
> > > > > 
> > > > > As far as I am aware, the implementations currently in use (KVM and Xen)
> > > > > use the same ID for both, so I think "smc" should cover an ID valid for
> > > > > a native register width calling convention, and "smc64" and "smc32"
> > > > > describing values only valid for 64-bit wide and 32-bit wide calling
> > > > > conventions respectively.
> > > > 
> > > > The problem is that does not work for a 32-bit kernel on 64-bit h/w as
> > > > native from the dts perspective is smc64. Just like the cpu bindings,
> > > > the binding cannot change based on 32 or 64 bit OS. I don't think we
> > > > really have to deal with that here. We can simply say "smc" is only for
> > > > "arm,psci" and deprecated for "arm,psci-0.2".
> > > 
> > > Agreed. I'd be happy with only having "smc32" and "smc64" for
> > > "arm,psci-0.2".
> 
> I would be happy with that too (Xen only uses HVC as "method").

Presumably we have the same issues with hvc vs hvc32 vs hvc64 though?

And does smcX imply hvcX or does that also need to be documented here?

> 
> > Actually, from some quick discussion with Marc and Dave, I think we can
> > handle this better, in a way that leaves this backwards compatible.
> > 
> > Rather than relying on the method string to tell us the calling
> > convention, I think we should rely on the function ID, as I proposed
> > earlier. The existing function ids provided in the "arm,psci" binding
> > are implicitly relying on the PSCI implementation to detect the register
> > width and act accordingly. This is trivially true on 32bit hardware, KVM
> > (where the same ID is used for 32-bit and 64-bit guests), and while I'm
> > not entirely sure about Xen I believe it's true there. We can make this
> > explicit as we extend the binding.
> > 
> > Having a -64 and -32 variant of each ID (while not pretty) allows us to
> > add additional IDs for functions that might only have a 32-bit or 64-bit
> > interface implemented, in addition to functions with common IDs:
> > 
> > psci {
> > 	compatible = "$VENDOR,psci-0.2", "arm,psci-0.2", "arm,psci";
> > 	cpu_off = <12345678>;
> > 	cpu_on = <01234567>;
> > 	system_reset-32 = <02222222>;
> > 	system_reset-64 = <12222222>;
> > 	affinity_info-64 = <15555555>;
> > };
> > 
> > This means that hypervisors could update their PSCI implementation while
> > keeping their DTS compatible with existing kernels.
> 
> Are you proposing of getting rid of "method" completely and therefore
> have 4 possible function IDs for each function:
> 
> system_reset-32-HVC
> system_reset-64-SMC
> system_reset-32-HVC
> system_reset-64-SMC
> 
> or are you proposing of choosing just the register width via function
> IDs?
> 
> Honestly I think it would be cleaner to introduce a new field called
> "width" can that be 32 or 64 and represent the register width, rather
> than having an explosion of function IDs.
