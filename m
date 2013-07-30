From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Jul 2013 10:49:20 +0100
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <51F6CE23.30306@gmail.com>
Message-ID: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 09:18:43PM +0100, Rob Herring wrote:
> On 07/29/2013 05:13 AM, Mark Rutland wrote:
> > Hi Rob,
> > 
> > On Sun, Jul 28, 2013 at 10:56:32PM +0100, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> The PSCI spec from ARM has been updated to 0.2 version. Update the
> >> binding document to reflect the spec changes. For the binding, the
> >> major changes are addition of system reset and poweroff functions.
> >> The recommended function id numbering has also changed.
> >>
> >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >> Cc: devicetree at vger.kernel.org
> >> ---
> >>  Documentation/devicetree/bindings/arm/psci.txt | 25 +++++++++++++++++++------
> >>  1 file changed, 19 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
> >> index 433afe9..b8b4d9f 100644
> >> --- a/Documentation/devicetree/bindings/arm/psci.txt
> >> +++ b/Documentation/devicetree/bindings/arm/psci.txt
> >> @@ -21,7 +21,7 @@ to #0.
> >>  
> >>  Main node required properties:
> >>  
> >> - - compatible    : Must be "arm,psci"
> >> + - compatible    : Must be "arm,psci-0.2" or "arm,psci"
> > 
> > For the purposes of handling different firmware implementations (which
> > may have different bugs to work around and may require different
> > arguments to cpu_suspend), it may be better to state "must contain"
> > rather than "must be". 
> > 
> >>  
> >>   - method        : The method of calling the PSCI firmware. Permitted
> >>                     values are:
> >> @@ -32,6 +32,9 @@ Main node required properties:
> >>                     "hvc" : HVC #0, with the register assignments specified
> >>  		           in this binding.
> >>  
> >> + - psci_version  : Function ID for PSCI_VERSION operation. Required for
> >> +                   "arm,psci-0.2" compatible version or later.
> >> +
> >>  Main node optional properties:
> >>  
> >>   - cpu_suspend   : Function ID for CPU_SUSPEND operation
> > 
> > The low bits of CPU_SUSPEND's power_state argument are platform specific
> > and we'll need to deal with them if an implementation actually uses them
> > for something. We can probably associate this with a specific
> > implementation's compatible string, as we'll almost certainly need
> > special code to handle the differences between them.
> 
> I'm not a fan of

Me neither. The only alternative I can think of would rely on platform
information from elsewhere to let you know how to call cpu_suspend,
(e.g. a board's compatible string).

As far as I can see, without some knowledge of the platform you can't
use CPU_SUSPEND safely.

> 
> > If we have a compatible string for the first platform that ignores the
> > argument (or just uses zero), that can be shared by all those
> > implementations that don't give any fine-grained control here.
> > 
> >> @@ -42,14 +45,24 @@ Main node optional properties:
> >>  
> >>   - migrate       : Function ID for MIGRATE operation
> >>  
> >> + - system_reset  : Function ID for SYSTEM_RESET operation
> >> +
> >> + - system_off    : Function ID for SYSTEM_OFF operation
> >> +
> >>  
> >>  Example:
> >>  
> >>  	psci {
> >> -		compatible	= "arm,psci";
> >> +		compatible	= "arm,psci-0.2";
> >>  		method		= "smc";
> >> -		cpu_suspend	= <0x95c10000>;
> >> -		cpu_off		= <0x95c10001>;
> >> -		cpu_on		= <0x95c10002>;
> >> -		migrate		= <0x95c10003>;
> >> +		psci_version	= <0x84000000>;
> >> +		cpu_suspend	= <0x84000001>;
> >> +		cpu_off		= <0x84000002>;
> >> +		cpu_on		= <0x84000003>;
> >> +		affinity_info	= <0x84000004>; 
> >> +		migrate		= <0x84000005>;
> >> +		migrate_info_type = <0x84000006>; 
> >> +		migrate_info_up_cpu = <0x84000007>; 
> >> +		system_off	= <0x84000008>; 
> >> +		system_reset	= <0x84000009>; 
> >>  	};
> > 
> > One of the things changed in PSCI 0.2 was the SMC calling convention,
> > though this isn't clear in the PSCI document. The function IDs for 32bit
> > and 64bit callers may differ, and we need to support describing an
> > arbitrary configuration of the two (same ID for both, different across
> > 32-bit/64-bit, only supported for 64-bit, only supported for 32-bit).
> > 
> > I'd like to ensure the binding can deal with that from the start. We
> > could do this by having -32 and -64 variants of each function id (e.g.
> > cpu_off-64) , if the IDs actually differ, and use the regular combined
> > ID if they don't.
> 
> Uggg. I guess I should have read the SMC calling convention doc... I was
> simply documenting what is already in the PSCI doc, but obviously that
> is not fully flushed out.
> 
> How about something like this (for the complicated case of both 32 and
> 64 bit):
> 
> 	method		= "smc", "smc64";
> 	psci_version	= <0x84000000 0xc4000000>;
> 	cpu_suspend	= <0x84000001 0xc4000001>;
> 	cpu_off		= <0x84000002 0xc4000002>;
> 	cpu_on		= <0x84000003 0xc4000003>;
> 
> "smc" is a synonym for smc32 for compatibility. The number and order of
> methods determines the number and order of function IDs.

While this may be compatible with the arm implementation, it won't be
compatible with the arm64 implementation, which assumes smc64 by
default.

As far as I am aware, the implementations currently in use (KVM and Xen)
use the same ID for both, so I think "smc" should cover an ID valid for
a native register width calling convention, and "smc64" and "smc32"
describing values only valid for 64-bit wide and 32-bit wide calling
conventions respectively.

I've added Christoffer, Marc, and Stefano to Cc in case they have any
comments.

> 
> A variation on this would be keep method as is and add a "#psci-cells"
> property to specify the number of function IDs. You can determine the
> 64-bit vs. 32-bit support based on the function ID itself.

I don't think that's a good idea - part of the reasoning for specifying
the IDs is to cater for those not aligned with the ID guidelines in the
spec, so we can't assume their choice of ID value gives us any useful
information as to how they may be used.

Thanks,
Mark.
