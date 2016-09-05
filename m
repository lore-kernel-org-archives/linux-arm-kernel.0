From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Sep 2016 17:04:20 +0100
Subject: [PATCH 2/3] ARM: pxa: lubbock: add pcmcia clock
In-Reply-To: <877faqjtuk.fsf@belgarion.home>
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
 <1473015587-15589-2-git-send-email-robert.jarzmik@free.fr>
 <20160904200827.GL1041@n2100.armlinux.org.uk>
 <877faqjtuk.fsf@belgarion.home>
Message-ID: <20160905160420.GQ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 04:37:23PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> 
> > On Sun, Sep 04, 2016 at 08:59:46PM +0200, Robert Jarzmik wrote:
> >> Add the clock provided to the PCMCIA block so that sa1111_pcmcia_add()
> >> doesn't end up on error while probing "1800" device.
> >
> > I don't think this is correct - SA1111 is not really the PCMCIA
> > controller - it's a load of logic which sits between the host
> > device and the PCMCIA sockets to manage buffers and the PCMCIA
> > socket control signals.
> 
> Gah I was naively thinking the SA1111 clock was used in the SA1111 to
> sample the CF lines, and as a consequence, that the asynchronous
> nPIOWait, nPIORead, nPIOWrite were derived from it.
> 
> I suppose the SA1111 takes 2 clocks, one for PS/2 etc ..., and SDCLK<1>
> for the PCMCIA operations, while I was thinking SDCLK<1> input to SA1111
> was only for alternate bus-master operations.

>From what I remember, the SA1111 takes the 3.6864MHz clock input as an
input to its own PLL to generate the clocks it needs internally.  All
the PCMCIA timing is handled by the SA1110 or PXA.

The reason that we need to tell the SA1111 PCMCIA device about the PXA
clock is not because the SA1111 uses it, but because the driver needs it
to work out the correct timing information to program the SA1110 or PXA
access times.

This means that the current driver structure does _not_ fit the DT model
at all - I hope that no one has plans to construct a DT model based on
the current code structure, because that would be totally wrong.

> > The quick fix here is to add a clock for the SA1111 PCMCIA sub-device,
> > but it still needs to be the SoC memory clock - iow, what
> > get_memclk_frequency_10khz() would have returned as that's what
> > pxa2xx_base.c wants.
> Right.
> 
> Would grant your sign-off to your patch in [1], if the commit message
> is good enough for you (I can fix it up if the wording is too ... french) ?

Thanks, the commit message is mostly fine, I think it ought to also
point out that it's used by the driver to derive the timing information,
and doesn't physically exist to the SA1111.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
