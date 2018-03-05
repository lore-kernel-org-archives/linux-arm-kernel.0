From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 5 Mar 2018 10:47:21 +0100
Subject: [PATCH] serial: mvebu_uart: fix tx lost characters
In-Reply-To: <3B588D51285A4A4D8D39C94212E07826271B70@SPQCMBX02.exfo.com>
References: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
 <20180227141255.177ea751@xps13>
 <3B588D51285A4A4D8D39C94212E07826271B70@SPQCMBX02.exfo.com>
Message-ID: <20180305104721.311a02c2@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

On Tue, 27 Feb 2018 21:56:03 +0000, Gabriel Matni
<gabriel.matni@exfo.com> wrote:

> Hi Miqu?l,
> 
> > -----Original Message-----
> > From: Miquel Raynal [mailto:miquel.raynal at bootlin.com]
> > Sent: February 27, 2018 8:13 AM
> > To: Gabriel Matni <gabriel.matni@exfo.com>
> > Cc: linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org;
> > Gr?gory Clement <gregory.clement@bootlin.com>; Thomas Petazzoni
> > <thomas.petazzoni@bootlin.com>
> > Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters
> > 
> > Hi Gabriel,
> > 
> > On Thu, 22 Feb 2018 20:30:56 +0000, Gabriel Matni
> > <gabriel.matni@exfo.com> wrote:
> >   
> > > From: Gabriel Matni <gabriel.matni@exfo.com>
> > >
> > > Fixes missing characters on kernel console at low baud rates (i.e.9600).
> > > The driver should poll TX_RDY instead of TX_EMPTY to ensure that the
> > > transmitter holding is ready to receive a new byte. Polling TX_EMPTY
> > > isn't enough as the hardware buffer can become empty but not yet ready
> > > for CPU to write the next byte.  
> > 
> > I am kind of sceptic with the explanation. My understanding is that:
> > - TX_EMPTY means the FIFO is empty

I had a deeper look into the spec : TX_EMPTY != TX_FIFO_EMPTY. I was
referring to TX_FIFO_EMPTY here so my understanding of your solution was
wrong.

> > - TX_RDY means the FIFO is not full, neither empty, it is a "half
> >   loaded" state.
> > Polling TX_RDY instead of TX_EMPTY should work too, but I don't see why it
> > would fix the loss of character by filling the FIFO when there are bytes in it
> > rather than when it is fully empty.  
> 
> TX_READY is set whenever the UART Transmitter Holding register is ready to
> receive a new byte. It gets cleared as soon as a new byte is written to the
> register. If the FIFO is empty or still has room, the ready will be set.
> 
> TX_EMPTY tells us when it is possible to send a break sequence via
> SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
> empty, it does not guarantee that a new byte can be written just yet.

I do agree with this statement. You are right that polling on TX_EMPTY
looks wrong and we should definitively poll on TX_READY instead.

> I am
> unsure about the FIFO status in this case as I can encounter TX_FIFO_EMP=0
> while TX_EMP=1, which suggests that the FIFO isn't necessarily empty when
> TX_EMP is set.

That is weird but maybe the TX_FIFO_EMPTY is asserted only when all
bits have been shifted, which is a 10-bit period after TSR is
cleared, while TX_EMPTY would not wait for these bits to be actually
shifted out and would be asserted a bit earlier, as soon as TSR is
cleared. That is just and idea.

> 
> Therefore, the driver can either poll TX_FIFO_EMP or TX_READY to know
> whether it can output a new byte. I personally like TX_READY as it takes
> advantage of the FIFO.

True.

> 
> > >
> > > Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
