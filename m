From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Aug 2014 12:31:39 +0100
Subject: [PATCH 1/6] Documentation: DT: Add bindings for FSL NS16550A The
 UART
In-Reply-To: <a446f06690fd4dcfb3a3f978c52b0d6c@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-2-git-send-email-bhupesh.sharma@freescale.com>
 <20140815104606.GB15621@leverpostej>
 <e0350675b3a6462d87cb06a33a1b6dc9@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140815150344.GA21908@leverpostej>
 <a446f06690fd4dcfb3a3f978c52b0d6c@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <20140820113139.GB21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

[...]

> > > > -----Original Message-----
> > > > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > > > Sent: Friday, August 15, 2014 4:16 PM
> > > > To: Sharma Bhupesh-B45370
> > > > Cc: devicetree-discuss at lists.ozlabs.org; Catalin Marinas;
> > > > arnd at arndb.de; Will Deacon; Yoder Stuart-B08248;
> > > > grant.likely at secretlab.ca; Basu Arnab- B45036;
> > > > linux-arm-kernel at lists.infradead.org
> > > > Subject: Re: [PATCH 1/6] Documentation: DT: Add bindings for FSL
> > > > NS16550A UART
> > > >
> > > > On Fri, Aug 15, 2014 at 10:49:10AM +0100, Bhupesh Sharma wrote:
> > > > > This patch addss the device-tree documentation for Freescale's
> > > > > NS16550 UART (also called DUART).
> > > > >
> > > > > There is a specific errata fix required in FSL NS16550 UART which
> > > > > ensures that an random interrupt storm is not observed when a
> > > > > break is provided as an input to the UART.
> > > >
> > > > Should this not go in
> > > > Documentation/devicetree/bindings/serial/of-serial.txt as with other
> > > > NS16550A variations?
> > > >
> > > > The only code for handling this string seems to live in
> > > > arch/powerpc/kernel/legacy_serial.c. Is there a patch factoring that
> > > > out into common code? Or is the erratum not applicable to the
> > > > revision used in your ARMv8 SoC?
> > > >
> > >
> > > The FSL specific 8250 (or NS16550A0 driver) at path
> > > drivers/tty/serial/8250/8250_fsl.c
> > > uses this string and provides the code to handle the erratum (see [1])
> > 
> > While the workaround itself is in that file, as far as I can see the
> > detection and setup is not. Even in next-20140815 it seems that only
> > happens in arch/powerpc/kernel/legacy_serial.c (see [2]):
> > 
> > [mark at leverpostej:~/src/linux]% git grep fsl8250_handle_irq next-20140815
> > next-20140815:arch/powerpc/kernel/legacy_serial.c:              port-
> > >handle_irq = fsl8250_handle_irq;
> > next-20140815:drivers/tty/serial/8250/8250_fsl.c:int
> > fsl8250_handle_irq(struct uart_port *port) next-
> > 20140815:include/linux/serial_8250.h:extern int fsl8250_handle_irq(struct
> > uart_port *port);
> > 
> > I cannot see any use of the string outside of arch/powerpc:
> > 
> > [mark at leverpostej:~/src/linux]% git grep fsl,ns16550 next-20140815 | wc -l
> > 102
> > [mark at leverpostej:~/src/linux]% git grep fsl,ns16550 next-20140815 --
> > arch/powerpc | wc -l
> > 102
> > 
> > Am I missing something? Perhaps some macro is getting in the way of a
> > simple grep.
> > 
> > > The NS16550 UART present on our SoC and the corresponding simulator
> > > model has this erratum and hence the specific way in which IRQ are
> > > handled (fsl8250_handle_irq) by the driver (in [1]) is applicable here
> > as well.
> > 
> > Assuming I've not missed something, do you need to factor out the
> > detection and setup? Do things just happen to work on the simulator
> > without the workaround?
> 
> You are right. The simulator platform doesn't take into account the
> erratum, however we need to take is into account for the emulator and
> silicon platforms.
> 
> I am currently working to fork this out into a common code base so
> that both PPC and ARM platforms can use the same and a patch for the
> same is in my to-do list.
>
> So, I sent out the DT documentation patch early (as it is equally
> applicable to  both PPC and ARM platforms) and the patch that makes
> this code leg usable for both ARM and PPC platform will follow soon.

Ok.

My only issue with the DT binding is the placement; I think that should
live with the other NS16550A variations.

Cheers,
Mark.
