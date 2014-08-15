From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Fri, 15 Aug 2014 14:42:09 +0000
Subject: [PATCH 1/6] Documentation: DT: Add bindings for FSL NS16550A The
 UART
In-Reply-To: <20140815104606.GB15621@leverpostej>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-2-git-send-email-bhupesh.sharma@freescale.com>
 <20140815104606.GB15621@leverpostej>
Message-ID: <e0350675b3a6462d87cb06a33a1b6dc9@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Friday, August 15, 2014 4:16 PM
> To: Sharma Bhupesh-B45370
> Cc: devicetree-discuss at lists.ozlabs.org; Catalin Marinas; arnd at arndb.de;
> Will Deacon; Yoder Stuart-B08248; grant.likely at secretlab.ca; Basu Arnab-
> B45036; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/6] Documentation: DT: Add bindings for FSL NS16550A
> UART
> 
> On Fri, Aug 15, 2014 at 10:49:10AM +0100, Bhupesh Sharma wrote:
> > This patch addss the device-tree documentation for Freescale's
> > NS16550 UART (also called DUART).
> >
> > There is a specific errata fix required in FSL NS16550 UART which
> > ensures that an random interrupt storm is not observed when a break is
> > provided as an input to the UART.
> 
> Should this not go in
> Documentation/devicetree/bindings/serial/of-serial.txt as with other
> NS16550A variations?
> 
> The only code for handling this string seems to live in
> arch/powerpc/kernel/legacy_serial.c. Is there a patch factoring that out
> into common code? Or is the erratum not applicable to the revision used in
> your ARMv8 SoC?
> 

The FSL specific 8250 (or NS16550A0 driver) at path drivers/tty/serial/8250/8250_fsl.c 
uses this string and provides the code to handle the erratum (see [1])

The NS16550 UART present on our SoC and the corresponding simulator model has this erratum and
hence the specific way in which IRQ are handled (fsl8250_handle_irq) by the driver (in [1])
is applicable here as well.

[1] https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/tty/serial/8250/8250_fsl.c?id=refs/tags/next-20140815

Regards,
Bhupesh

> Thanks,
> Mark.
> 
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > ---
> >  .../devicetree/bindings/serial/fsl-ns16550.txt     |   24
> ++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> >
> > diff --git a/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> > b/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> > new file mode 100644
> > index 0000000..9926e10
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/fsl-ns16550.txt
> > @@ -0,0 +1,24 @@
> > +* Freescale DUART is very similar to the PC16552D (and to a
> > +  pair of NS16550A), albeit with some nonstandard behavior such as
> > +  erratum A-004737 (relating to incorrect BRK handling).
> > +
> > +- compatible: "fsl,ns16550"
> > +
> > +  Represents a single port that is compatible with the DUART found
> > + on many Freescale chips (examples include mpc8349, mpc8548,
> > + mpc8641d, p4080 and ls2085a).
> > +
> > +- reg: The base address of the UART register bank.
> > +
> > +- interrupts: A single interrupt specifier.
> > +
> > +- clock-frequency = Input clock to the baud rate divider.
> > +
> > +Example:
> > +	serial1: serial at 21c4600 {
> > +		compatible = "fsl,ns16550", "ns16550a";
> > +		reg = <0x0 0x21c4600 0x0 0x100>;
> > +		clock-frequency = <0>;
> > +		interrupts = <0 32 0x1>;
> > +	};
> > +
> > --
> > 1.7.9.5
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
