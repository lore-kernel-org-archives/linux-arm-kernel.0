From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 28 Jul 2015 15:53:37 -0700
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <CAAtXAHejK2vL2qSdhqrtHmkV_RBfkLzQNM8ZbDvREvienNqzXw@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
 <20150728025833.GQ2650@xsjsorenbubuntu>
 <CAAtXAHejK2vL2qSdhqrtHmkV_RBfkLzQNM8ZbDvREvienNqzXw@mail.gmail.com>
Message-ID: <20150728225337.GF2650@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-27 at 09:52PM -0700, Moritz Fischer wrote:
> Hi S?ren,
> 
> thanks for your feedback.
> 
> On Mon, Jul 27, 2015 at 7:58 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> > Hi Moritz,
> >
> > On Fri, 2015-07-24 at 05:21PM -0700, Moritz Fischer wrote:
> >> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> >> ---
> >>  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> >> new file mode 100644
> >> index 0000000..ac4499e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> >> @@ -0,0 +1,13 @@
> >> +Xilinx Zynq PL Reset Manager
> >> +
> >> +Required properties:
> >> +- compatible: "xlnx,zynq-reset-pl"
> >> +- syscon <&slcr>;
> >> +- #reset-cells: 1
> >> +
> >> +Example:
> >> +     rstc: rstc at 240 {
> >> +             #reset-cells = <1>;
> >> +             compatible = "xlnx,zynq-reset-pl";
> >> +             syscon = <&slcr>;
> >> +     };
> >
> > I think you also have to add the outputs and make them part of the
> > binding. Otherwise you'd have to read the implementation to find
> > out what device should be hooked up to which output of the reset-controller.
> 
> Is something like this what you had in mind? I had that prepared for
> the next round of patches:
> 
> Reset outputs:
>  0  : soft reset
>  32 : ddr reset
>  64 : topsw reset
>  96 : dmac reset
>  128: usb0 reset
>  129: usb1 reset
>  160: gem0 reset
>  161: gem1 reset
>  164: gem0 rx reset
>  165: gem1 rx reset
>  166: gem0 ref reset
>  167: gem1 ref reset
>  192: sdio0 reset
>  193: sdio1 reset
>  196: sdio0 ref reset
>  197: sdio1 ref reset
>  224: spi0 reset
>  225: spi1 reset
>  226: spi0 ref reset
>  227: spi1 ref reset
>  256: can0 reset
>  257: can1 reset
>  258: can0 ref reset
>  259: can1 ref reset
>  288: i2c0 reset
>  289: i2c1 reset
>  320: uart0 reset
>  321: uart1 reset
>  322: uart0 ref reset
>  323: uart1 ref reset
>  352: gpio reset
>  384: lqspi reset
>  385: qspi ref reset
>  416: smc reset
>  417: smc ref reset
>  448: ocm reset
>  512: fpga0 out reset
>  513: fpga1 out reset
>  514: fpga2 out reset
>  515: fpga3 out reset
>  544: a9 reset 0
>  545: a9 reset 1
>  552: peri reset

Basically, yes. I guess the gaps are due to directly mapping this number
to bank and bit instead of doing some more complex mapping in between?
I'm not sure whether I like this :) I guess if a number is off the
driver would still toggle the addressed bit? I'm not sure, is it worth
to do some explicit mapping from logical outputs to a physical reset? It
seems it would be a little safer since it would be easy to check that
the addressed reset is valid and there wouldn't be any reserved/invalid
bits be toggled. Also, it would make the outputs in here a continuous
series of numbers without these gaps. Not sure though whether
it's worth the additional complexity in the implementation.

	Thanks,
	S?ren
