From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 09 May 2017 18:32:19 +0200
Subject: [PATCH] PCI: imx6: remove LTSSM disable workaround
In-Reply-To: <CAJ+vNU1LqNRNEEX4NH3uyiw-xS-07zU94drhGOewwYM5UOs87Q@mail.gmail.com>
References: <20170120155837.2874-1-l.stach@pengutronix.de>
 <CAJ+vNU1LqNRNEEX4NH3uyiw-xS-07zU94drhGOewwYM5UOs87Q@mail.gmail.com>
Message-ID: <1494347539.2322.37.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 09.05.2017, 09:24 -0700 schrieb Tim Harvey:
> On Fri, Jan 20, 2017 at 7:58 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > This causes CPU hangs when the system is reset by the watchdog, as
> > the GPRs aren't cleared, but the clocks are back to disabled state.
> >
> > If the bootloader uses PCIe, it must take care to bring it down
> > into a safe state, before passing control to the Linux kernel.
> > This is the only way to get a properly operating system at all
> > times and circumstances.
> >
> 
> Lucas,
> 
> I missed this patch when it came through.
> 
> Can you give some details about what you consider a 'safe state' for
> the bootloader to bring PCI to before passing control to the kernel
> (with respect to PERST#, PCI CLK, and the various host controller
> registers)? I would like to investigate making PCI available in the
> bootloader as well as the kernel reliable on IMX6.

The bootloader needs to reset the LTSSM state, disable LTSSM and disable
the PCIe core and PHY clocks before jumping to the kernel image. This is
already done in Barebox [1] (where it works well with PCIe used both in
the BL and kernel) and I gave advance warning to multiple people using
U-Boot that they need to implement a similar shutdown hook there. Sadly
it seems that nothing has emerged yet.

Regards,
Lucas

[1]
https://git.pengutronix.de/cgit/barebox/commit/?id=f1da98da2760c21487bbba8f7fb957c843a22896
