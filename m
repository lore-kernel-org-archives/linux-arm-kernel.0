From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Jul 2013 13:56:50 +0100
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <51F7B4C9.2060500@gmail.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
Message-ID: <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 01:42:49PM +0100, Rob Herring wrote:
> On 07/30/2013 04:49 AM, Mark Rutland wrote:
> > On Mon, Jul 29, 2013 at 09:18:43PM +0100, Rob Herring wrote:
> >> On 07/29/2013 05:13 AM, Mark Rutland wrote:
> >>> Hi Rob,
> >>>
> >>> On Sun, Jul 28, 2013 at 10:56:32PM +0100, Rob Herring wrote:
> >>>> From: Rob Herring <rob.herring@calxeda.com>
> 
> [snip]
> 
> >>> One of the things changed in PSCI 0.2 was the SMC calling convention,
> >>> though this isn't clear in the PSCI document. The function IDs for 32bit
> >>> and 64bit callers may differ, and we need to support describing an
> >>> arbitrary configuration of the two (same ID for both, different across
> >>> 32-bit/64-bit, only supported for 64-bit, only supported for 32-bit).
> >>>
> >>> I'd like to ensure the binding can deal with that from the start. We
> >>> could do this by having -32 and -64 variants of each function id (e.g.
> >>> cpu_off-64) , if the IDs actually differ, and use the regular combined
> >>> ID if they don't.
> >>
> >> Uggg. I guess I should have read the SMC calling convention doc... I was
> >> simply documenting what is already in the PSCI doc, but obviously that
> >> is not fully flushed out.
> >>
> >> How about something like this (for the complicated case of both 32 and
> >> 64 bit):
> >>
> >> 	method		= "smc", "smc64";
> >> 	psci_version	= <0x84000000 0xc4000000>;
> >> 	cpu_suspend	= <0x84000001 0xc4000001>;
> >> 	cpu_off		= <0x84000002 0xc4000002>;
> >> 	cpu_on		= <0x84000003 0xc4000003>;
> >>
> >> "smc" is a synonym for smc32 for compatibility. The number and order of
> >> methods determines the number and order of function IDs.
> > 
> > While this may be compatible with the arm implementation, it won't be
> > compatible with the arm64 implementation, which assumes smc64 by
> > default.
> > 
> > As far as I am aware, the implementations currently in use (KVM and Xen)
> > use the same ID for both, so I think "smc" should cover an ID valid for
> > a native register width calling convention, and "smc64" and "smc32"
> > describing values only valid for 64-bit wide and 32-bit wide calling
> > conventions respectively.
> 
> The problem is that does not work for a 32-bit kernel on 64-bit h/w as
> native from the dts perspective is smc64. Just like the cpu bindings,
> the binding cannot change based on 32 or 64 bit OS. I don't think we
> really have to deal with that here. We can simply say "smc" is only for
> "arm,psci" and deprecated for "arm,psci-0.2".

Agreed. I'd be happy with only having "smc32" and "smc64" for
"arm,psci-0.2".

Thanks,
Mark.
