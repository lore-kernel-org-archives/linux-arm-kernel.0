From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Jun 2012 22:13:10 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <4FD4E2DE.20006@baatz.info>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
 <4FD4E2DE.20006@baatz.info>
Message-ID: <20120610201310.GB22507@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 08:09:34PM +0200, Simon Baatz wrote:
> Hi Andrew,
> 
> Am 08.06.2012 16:09, schrieb Andrew Lunn:
> > Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
> > nor SPI is used in the system, RUNIT clock gets turned off, and the
> > SoC hard locks. It appears something else in the SoC, which is not
> > documented, is also using RUNIT. So prepare and enable RUNIT clock in
> > kirkwood_clk_init().
> >
> > +
> > +	/* Something other than SPI and NAND needs runit, so make sure
> > +	   it never gets turned off. */
> > +	clk_prepare_enable(runit);
> >
> 
> I am experiencing another type of crash caused by the GE0 clock (on a
> IB-NAS 6210). I am compiling mv643xx_eth as a module. Thus, GE0 and GE1
> get turned off first since they are unused.

O.K. never tried that. I only tested with kirkwood_defconfig.

> When the module loads and it should enable GE0, the box hangs. I haven't
> had time to find out why; my guess would be that the clock might already
> be needed somewhere in mv643xx_eth_shared_probe(). The box boots again
> after I add

It is probably infer_hw_params(). 

> 
> clk_prepare_enable(ge0);
> 
> to the code above as a quick hack.

The correct fix is going to be interesting. I assume that either ge0
or ge1 is sufficient to make the shared hardware work. So one option
would be to register a clock with name MV643XX_ETH_SHARED_NAME, which
is ge0. The shared probe code can turn it on/off during the shared
probe function.  When the specific interface is probed, the correct
clock for that interface will be enabled, and it will also driver the
shared hardware.

I will try this out tomorrow.

Do you have any other drivers built as modules? I was conservative and
turned the clock on in the probe function, so i expect that most work
as modules. However XOR has a similar sort of structure, so might also
be broken...

	Thanks
		Andrew
