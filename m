From: andy@warmcat.com (Andy Green)
Date: Mon, 14 Dec 2009 14:10:26 +0000
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091214135722.CBCBF4C026@gemini.denx.de>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>	<20091211234714.GT28375@buzzloop.caiaq.de>
	<20091214135722.CBCBF4C026@gemini.denx.de>
Message-ID: <4B264752.1080709@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/09 13:57, Somebody in the thread at some point said:

Hi Wolfgang -

> In Linux, the kernel hangs here:
>
> 	/* read SREV register from IIM module */
> 	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);

In iMX31 IIM is very strangely a specifically 8-bit peripheral on a 
32-bit bus.  I wrote some code to read and write the fuses recently.

Maybe it's required to change it to __raw_readb; mine are already byte 
operations.

> In U-Boot, I can read this register just fine:
>
> 	=>  md 5001c024 1
> 	5001c024: 00000028    (...
>
> In Linux, the IO_ADDRESS() makes this a read from 0xFC11C024, which
> hangs.
>
> So if this is a clock thing, then it must be a clock being disabled by
> Linux.

Around my (working) IIM operations I have this code:

	iim_clk = clk_get(NULL, "iim");
	if (IS_ERR(iim_clk)) {
		pr_err("No IIM clock defined\n");
		return -EINVAL;
	}
	clk_enable(iim_clk);

...

	clk_disable(iim_clk);
	clk_put(iim_clk);

-Andy
