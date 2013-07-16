From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 16 Jul 2013 12:25:26 +0100
Subject: [RFC PATCH v4 03/18] Documentation: devicetree: arm: cpus/cpu
 nodes bindings updates
In-Reply-To: <CAL_JsqLANi5UoVyRMsa6XoQ+_KnmTQDfTz++shEh-dZ3FQGZaQ@mail.gmail.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368804061-4421-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqLANi5UoVyRMsa6XoQ+_KnmTQDfTz++shEh-dZ3FQGZaQ@mail.gmail.com>
Message-ID: <20130716112520.GA3428@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 09:47:17AM -0500, Rob Herring wrote:
> On Fri, May 17, 2013 at 10:20 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > In order to extend the current cpu nodes bindings to newer CPUs
> > inclusive of AArch64 and to update support for older ARM CPUs this
> > patch updates device tree documentation for the cpu nodes bindings.
> 
> Sorry for the long delay on this, but I'm still not happy with the binding here.
> 
> > Main changes:
> >     - adds 64-bit bindings
> >     - define usage of #address-cells
> >     - define 32/64 dts compatibility settings
> >     - defines behaviour on pre and post v7 uniprocessor systems
> >     - adds ARM 11MPcore specific reg property definition
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 459 ++++++++++++++++++++++---
> >  1 file changed, 412 insertions(+), 47 deletions(-)
> 
> [snip]
> 
> > +                       # On ARM v8 64-bit systems, where the reg property
> > +                         size can be 1 or 2 cells (as defined by cpus node's
> > +                         #address-cells property), this property is
> > +                         required and matches:
> > +
> > +                         - On systems running the OS in AArch32:
> 
> The DTS cannot change based on 32-bit or 64-bit OS.
> 
> > +
> > +                           * If the cpus node's #address-cells value is 2:
> > +
> > +                             The first reg cell must be set to 0.
> > +
> > +                             The second reg cell bits [23:0] must be set to
> > +                             bits [23:0] of MPIDR_EL1.
> > +
> > +                             All other bits in the reg cells must be set to 0.
> > +
> > +                           * If the cpus node's #address-cells value is 1:
> > +
> > +                             Bits [23:0] in the reg cell must be set to
> > +                             bits [23:0] in MPIDR_EL1.
> > +
> > +                             All other bits in the reg cell must be 0.
> > +
> > +                         - On systems running the OS in AArch64:
> > +
> > +                           * If the cpus node's #address-cells value is 2:
> > +
> > +                             The first reg cell bits [7:0] must be set to
> > +                             bits [39:32] of MPIDR_EL1.
> > +
> > +                             The second reg cell bits [23:0] must be set to
> > +                             bits [23:0] of MPIDR_EL1.
> > +
> > +                             All other bits in the reg cells must be set to 0.
> > +
> > +                           * If the cpus node's #address-cells value is 1:
> > +
> > +                             MPIDR_EL1[63:32] is 0 on all processors in the
> > +                             system.
> 
> Your logic is backwards here. If the MPIDR_EL1[63:32] is 0, then
> #address-cells can be 1. You could say the upper bits are ignored and
> treated as 0. However, you should simplify all this and just mandate
> that #address-cells must be 2 for ARMv8 or more generally must match
> the size of the MPIDR. If we want to boot a 32-bit kernel, then the
> kernel will have to adapt to support this.

I'd support this, opting for a clean split.

Strictly speaking, it should be this:

AArch64-capable hardware: #address-cells = 2
non-AArch64-capable hardware: #address-cells = 1

The only time it is valid to have #address-cells = 1 on AArch64-capable
hardware is in an AArch32 virtual machine (in which case, the DT anyway
describes the VM and not the real hardware).


However, due to the awkwardness of defining precisely what "AArch64-
capable hardware" means in a world containing firmware and hypervisors,
it might be better (if slightly less correct) to go with:

v8 hardware: #address-cells must be 2
<=v7 hardware: #address-cells must be 1


If the firmware boots an AArch32 payload natively on AArch64-capable
v8 hardware, it's the firmware's job to ensure that non-addressable
CPUs are properly quiesced and shut down, otherwise the setup is
pretty broken -- DT can't solve that one, nor can Linux, so we shouldn't
try.  Linux just needs to discard the non-addressable CPUs and maybe
print out a warning.


Cheers
---Dave
