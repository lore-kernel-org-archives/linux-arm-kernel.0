From: geoff@infradead.org (Geoff Levand)
Date: Fri, 29 Aug 2014 14:45:04 -0700
Subject: [PATCH 9/9] arm64: Add new cpu-return-addr device tree binding
In-Reply-To: <20140827083022.GE6968@arm.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <4192d403bb9703063c59a052293faa19d38d2f02.1408736066.git.geoff@infradead.org>
 <20140827083022.GE6968@arm.com>
Message-ID: <1409348704.21254.95.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Wed, 2014-08-27 at 09:30 +0100, Catalin Marinas wrote:
> On Fri, Aug 22, 2014 at 08:49:17PM +0100, Geoff Levand wrote:
> > Add a new arm64 device tree binding cpu-return-addr.  This binding is recomended
> > for all ARM v8 CPUs that have an "enable-method" property value of "spin-table".
> > The value is a 64 bit physical address that secondary CPU execution will transfer
> > to upon CPU shutdown.
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 1fe72a0..42d5d5f 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -201,6 +201,15 @@ nodes to be present and contain the properties described below.
> >  			  property identifying a 64-bit zero-initialised
> >  			  memory location.
> >  
> > +	- cpu-return-addr
> > +		Usage: recomended for all ARM v8 CPUs that have an
> > +		       "enable-method" property value of "spin-table".
> > +		Value type: <prop-encoded-array>
> > +		Definition:
> > +			# On ARM v8 64-bit systems must be a two cell property.
> > +			The value is a 64 bit physical address that secondary
> > +			CPU execution will transfer to upon CPU shutdown.
> 
> As I've been away for most of the past four weeks, I haven't read all
> the threads around this topic. But I don't think we ended up with a
> clearly agreed recommendation for cpu-return-addr. If we do, we also
> need to be clear on what state the CPU should be in when returned to
> such address (ELx, MMU, caches).

Regarding the system state, I think what Mark proposed [1] is what we
should work towards.  I'll add that to the binding's Definition text.

I have not tried to implement it yet though, but once I get it working
and tested we'll be able to say that this is what works and should be
the interface.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/278910.html

> In general, if we need returning to firmware I would strongly recommend
> PSCI but I know there is the Applied board which does not have EL3, so
> something like this may work. But we need to get them into discussion as
> well since I assume cpu-return-addr would be a firmware provided
> address.

Yes, cpu-return-addr will be (optionally) provided by the firmware.

The current kexec_prepare system call implementation I have checks
the return of cpu_ops.cpu_disable() for all CPUs.  I have setup the
spin-table cpu_disable() to check if the device tree defines a
cpu-return-addr for that CPU.  So if there is no cpu-return-addr
kexec_prepare will fail and the user will get an error on a kernel
load from kexec-tools.

Feng Kan of APM has already said that address O will work correctly
for the APM board [2], and Arun Chandran has tested this.

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/273084.html

-Geoff
