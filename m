From: simon2012@baatz.info (Simon Baatz)
Date: Sun, 10 Jun 2012 20:09:34 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
Message-ID: <4FD4E2DE.20006@baatz.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Am 08.06.2012 16:09, schrieb Andrew Lunn:
> Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
> nor SPI is used in the system, RUNIT clock gets turned off, and the
> SoC hard locks. It appears something else in the SoC, which is not
> documented, is also using RUNIT. So prepare and enable RUNIT clock in
> kirkwood_clk_init().
>
> +
> +	/* Something other than SPI and NAND needs runit, so make sure
> +	   it never gets turned off. */
> +	clk_prepare_enable(runit);
>

I am experiencing another type of crash caused by the GE0 clock (on a
IB-NAS 6210). I am compiling mv643xx_eth as a module. Thus, GE0 and GE1
get turned off first since they are unused.

When the module loads and it should enable GE0, the box hangs. I haven't
had time to find out why; my guess would be that the clock might already
be needed somewhere in mv643xx_eth_shared_probe(). The box boots again
after I add

clk_prepare_enable(ge0);

to the code above as a quick hack.

- Simon
