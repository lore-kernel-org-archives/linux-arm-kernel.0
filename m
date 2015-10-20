From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Oct 2015 18:25:40 +0100
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <56266F7E.6030404@amd.com>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
Message-ID: <20151020172539.GB4943@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 11:44:46AM -0500, Brijesh Singh wrote:
> Hi Mark,
> 
> Thanks for review. 
> 
> -Brijesh
> 
> On 10/19/2015 03:52 PM, Mark Rutland wrote:
> > Hi,
> > 
> > Please Cc the devicetree list (devicetree at vger.kernel.org) when sending
> > binding patches. I see you've added the people from the MAINTAINERS
> > entry; the list should also be Cc'd.
> > 
> Noted.
> > On Mon, Oct 19, 2015 at 02:23:17PM -0500, Brijesh Singh wrote:
> >> Add support for the AMD Seattle SoC EDAC driver.
> >>
> >> Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
> >> ---
> >>  .../devicetree/bindings/edac/amd-seattle-edac.txt  |  15 +
> >>  drivers/edac/Kconfig                               |   6 +
> >>  drivers/edac/Makefile                              |   1 +
> >>  drivers/edac/seattle_edac.c                        | 306 +++++++++++++++++++++
> >>  4 files changed, 328 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/edac/amd-seattle-edac.txt
> >>  create mode 100644 drivers/edac/seattle_edac.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/edac/amd-seattle-edac.txt b/Documentation/devicetree/bindings/edac/amd-seattle-edac.txt
> >> new file mode 100644
> >> index 0000000..a0354e8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/edac/amd-seattle-edac.txt
> >> @@ -0,0 +1,15 @@
> >> +* AMD Seattle SoC EDAC node
> >> +
> >> +EDAC node is defined to describe on-chip error detection and reporting.
> >> +
> >> +Required properties:
> >> +- compatible: Should be "amd,arm-seattle-edac"
> >> +- poll-delay-msec: Indicates how often the edac check callback should be called.
> >> +  Time in msec.
> > 
> > This second property doesn't describe the hardware in any way. It should
> > be runtime-configurable and dpesn't belong in the DT.
> > 
> > Regardless, the binding is wrong. This is in no way specific to AMD
> > Seattle, and per the code is actually used to imply the presence of a
> > Cortex-A57 feature. No reference to AMD Seattle belongs in the DT
> > binding (with the exception of the example, perhaps), nor in the driver.
> > 
> > NAK while this pretends to be something that it isn't. At minimum, you
> > need to correctly describe the feature you are trying to add support
> > for.
> > 
> I will remove AMD specific string in compatibility field and make the
> poll-delay-msec optional. Will also expose this as module parameter as
> you suggested below.

I don't think it should be optional; I don't think it should be there at
all.

I'm not sure if we even need a DT binding if we can derive the presence
of the feature from the MIDR.

> >> + * The driver polls CPUMERRSR_EL1 and L2MERRSR_EL1 registers to logs the 
> > 
> > These are IMPLEMENTATION DEFINED registers which are specific to
> > Cortex-A57, and I note that L2MERRSR_EL1 changed in r1p0.
> > 
> > Which revisions of Cortex-A57 does this work with?
> > 
> I have tested my code on r1p2.
> 
> > Generally we avoid touching IMPLEMENTATION DEFINED registers as they may
> > not exist in some configurations or revisions, and could trap or undef.
> > Is it always safe to access these registers (in current revisions of
> > Cortex-A57)?
> > 
> So far I have not ran into any trap error, was able to read/write
> registers from EL1 all the times. I looked at TRM but could not find
> reference that it would fail. As per doc the register should be
> available at all EL's except EL0.

Ok.

> >> + * non-fatal errors. Whereas the single bit and double bit ECC erros are 
> >> + * handled by firmware.
> > 
> > I had expected this would be all be left for firmware, given that this
> > feature may change in any revision of the CPU.
> > 
> > What precisely does the AMD Seattle firmware do for double-bit ECC
> > errors, and how is it triggered?
> > 
> The error handling firmware is work in progress. I believe the
> approach is: Configure the platform to trigger a firmware handler when
> the error occurs, trusted firmware will receive the fatal error
> interrupt and take the action and will generate APEI objects; if error
> requires a SoC warm reset then it will communicate with SCP to warm
> reset the SoC. The SCP firmware will then need to provide the ACPI
> BERT error logging information back when the A57 restarts. 

Can signalling of single-bit errors not happen in the same way via APEI?
Or is APEI handled fatally?

Thanks,
Mark.
