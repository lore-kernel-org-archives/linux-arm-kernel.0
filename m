From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 17:18:52 +0200
Subject: [PATCH 8/9] ARM: SPMP8000: Add support for the Letcool board
In-Reply-To: <CAGVye5PNhQpdZ9QP-s1EM_Vm22fWC0sW+jV9=CbFivaTMTvkjQ@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<201110111609.37425.arnd@arndb.de>
	<CAGVye5PNhQpdZ9QP-s1EM_Vm22fWC0sW+jV9=CbFivaTMTvkjQ@mail.gmail.com>
Message-ID: <201110111718.53031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 October 2011, Zoltan Devai wrote:
> >
> > Hi Zoltan,
> >
> > We basically stopped doing board files for new platforms. Please get
> > rid of this and make sure that the spmp8000-letcool.dts describes
> > everything you need to get this board running. The DT_MACHINE_START
> > part should just be part of the core.c file and not mention the
> > board name, since its intended to apply to all boards with this
> > SOC.
> Hi,
> 
> The board file only contains platform data for drivers which don't handle DT.
> Should I strip those off ?

Well, ideally you should add support for DT probing to those drivers.
With all the new helpers we recently added, that should not require more
code than what you have in the board file that you lose in the process.

> Does that also mean that no fully working ARM board will be allowed into
> mainline until all required drivers do DT ?

Yes, sorry that this causes more work for you.

The overall strategy is more complex, it depends a lot on the state that
the platform is in:

1. For new platforms (prima2, zynq, picoxcell, highbank, spmp8000, ...),
there is a single machine description and all devices are probed through
the device tree. Board files are no longer allowed.

2a For actively maintained platforms (omap, pxa, msm, samsung, at91, imx,
...), the expectation is that the maintainers work on converting the
drivers to device tree probing, but they can still add the occasional
board file for important boards. Once all on board (not necessarily
on-chip) devices can be probed using device tree, new boards files are
not allowed any more, and existing board files should be removed
(either all at once or gradually as dts files get added).

2b After an existing platform has lost its board files, we also want
to remove the on-soc devices from platform files by moving them into
the device tree. The method is the same: you get to add new socs only
if you work on infrastructure to get rid of the code again and move
it into dts files. Once the infrastructure is there, the existing
soc descriptions should gradually go away.

3. For legacy platforms (rpc, sa1100, h720x, ...), I don't expect
anyone to realistically work on device tree conversion. If someone
sends a new board file, that would likely be accepted. Those platforms
are also simple enough that doing everything using board files is
not a signficant overhead.

	Arnd
