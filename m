From: carlo@caione.org (Carlo Caione)
Date: Tue, 24 May 2016 10:03:28 +0200
Subject: [PATCH v3 4/4] documentation: Add secure monitor binding
 documentation
In-Reply-To: <20160523171159.GH4976@leverpostej>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
 <1464021024-29380-5-git-send-email-carlo@caione.org>
 <20160523163815.GE4976@leverpostej>
 <20160523165931.GA31299@mephisto>
 <20160523171159.GH4976@leverpostej>
Message-ID: <20160524080328.GA18935@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/16 18:11, Mark Rutland wrote:
> On Mon, May 23, 2016 at 06:59:31PM +0200, Carlo Caione wrote:
> > On 23/05/16 17:38, Mark Rutland wrote:
> > > > +Required properties for the secure monitor node:
> > > > +- compatible: Should be "amlogic,meson-sm"
> > > > +- amlogic,sm-cmd-input-base: SMC32 function identifier to read the physical
> > > > +                             address of the input buffer
> > > > +- amlogic,sm-cmd-output-base: SMC32 function identifier to read the physical
> > > > +                              address of the output buffer
> > > 
> > > Do the IDs for these actually differ per board?
> > 
> > I expect these to differ per SoC (GXBB in this case), not per board. The
> > driver is generic enough to be (hopefully) used for several SoCs just
> > changing the related header file that defines the SCM commands.
> > 
> > > Are some functions simply not implemented on some boards?
> > 
> > I don't think this is possible.
> 
> Given that, I think it may be better to just have a
> "amlogic,meson-gxbb-sm" compatible string, and derive the set of
> functions and associated IDs from that.

I can reference a specific SMC function using an index in the DT, the
same index for all the SoCs. The index is then associated to the actual
SoC-specific command ID in the driver according to the compatible string
used for the secure-monitor node.

Something like:

  // Not SoC-specific
  #include <dt-bindings/firmware/meson.h>

  sm: sm {
  	compatible = "amlogic,meson-gxbb-sm";
  };
  
  efuse {
  	compatible = "amlogic,meson-gxbb-efuse";
  	secure-monitor = <&sm>;
  	amlogic,cmd-read-efuse = <READ_EFUSE>;
  	...
  };

Is this any better?

At this point I wonder if it makes sense having the driver-specific
function IDs (like 'amlogic,cmd-read-efuse' above) defined in the DT.

> That is, unless you know that future revisions have functions with the
> exact same semantics but differing IDs.

This is most probably the case.

Also the driver exports really generic functions to access the
secure-monitor on purpose, so that the driver using it can define the
semantic of the SMC call. I really would like to avoid fixing the
semantic in the SM driver itself since we will end up with: different
semantics for each SMC call and for each SoC.

> Regardless, it would make sense to have a GXBB-specific compatible
> string prepended to the list. That way in the future we can handle
> anything specific to the GXBB variant of the secure monitor if
> necessary.

Agree on this.

Cheers,

-- 
Carlo Caione
