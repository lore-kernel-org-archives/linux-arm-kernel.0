From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 1 Sep 2015 13:54:57 +0100
Subject: [STLinux Kernel] [PATCH v2 2/4] remoteproc: dt: Provide bindings
 for ST's Remote Processor Controller driver
In-Reply-To: <20150901085825.GC30542@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
 <1440757911-9120-3-git-send-email-lee.jones@linaro.org>
 <20150901085825.GC30542@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150901125457.GU4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keeping interested parties in the loop.

Peter and I had a discussion with ST.  Here is the result.

On Tue, 01 Sep 2015, Peter Griffin wrote:
> On Fri, 28 Aug 2015, Lee Jones wrote:
> 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/remoteproc/st-rproc.txt    | 35 ++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> 
> The patch documening the DT bindings should be ordered before the patch which adds
> the DT node to aid reviewing.

I've always thought this was a silly rule, but I will re-order
nonetheless.

> > diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> > new file mode 100644
> > index 0000000..fbd7d78
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> > @@ -0,0 +1,35 @@
> > +STMicroelectronics Remote Processor
> > +-----------------------------------
> > +
> > +This binding provides support for adjunct processors found on ST SoCs.
> > +
> > +The remote processors can be controlled from the bootloader or the primary OS.
> > +If the bootloader starts a remote processor processor the primary OS must detect
> > +its state and act accordingly.
> > +
> > +Required properties:
> > +- compatible		Should be one of:
> > +				"st,st231-rproc"
> > +				"st,st40-rproc"
> 
> st40-proc isn't used anywhere. The stih407 doesn't have a ST40 copro, and
> looking in the vendor tree remoteproc support isn't present for stih415/6 which
> are the the only upstream SoC's to have a ST40 co-pro.
> 
> So I think st40-rproc support can be removed.

Agreed that the current state of platforms present in Mainline do not
warrant support for more than one type of co-processor; however,
platforms exist which are either not going upstream, or aren't
upstreamable *yet*, which will require support for a) different types
of co-processors and/or b) the capability to configure which reset
lines, if any, are present.

I'm keen to keep this option for two reasons.  Firstly, it allows ST
to use the driver in Mainline for existing platforms and secondly,
this driver will not have to be heavily modified when new platforms
are added.

> > +- reg			Size and length of reserved co-processor memory
> > +- resets		Reset lines (See: ../reset/reset.txt)
> > +- reset-names		Must be "sw_reset" and "pwr_reset"
> 
> pwr_reset isn't used by any of the st231 co-processors. It seems to
> be related to ST40 support which I don't think is required upstream.
> Removing it would make the driver a fair bit smaller.
> 
> > +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
> > +- clock-names		Must be "rproc_clk"
> 
> I can't see any co-pro which uses more than one clock, so clock-names looks
> superflous.

Sounds reasonable.  I will remove it.

> > +- clock-frequency	Clock frequency to set co-processor at if the bootloader
> > +			hasn't already done so
> > +- st,syscfg-boot	The register that holds the boot vector for the co-processor
> 
> I would prefer to see this binding match how most other sti drivers reference syscfg
> registers which is: -
> 
> st,syscfg       = <&syscfg_core 0xf4>;

Agreed.  Will change.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
