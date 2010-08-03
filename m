From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 3 Aug 2010 15:00:15 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <083DF309106F364B939360100EC290F80AC39A091A@eu1rdcrdc1wx030.exi.nxp.com>
References: <20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC392ACFC@eu1rdcrdc1wx030.exi.nxp.com>
	<20100730070943.GA29746@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC39A091A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <AANLkTi=mtdcsr+KBUuK2rA1zrbcRRdCj1PvuSDrUjke-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/3 Kevin Wells <kevin.wells@nxp.com>:

> Wouldn't drivers that use clk_disable in their xxx_suspend functions
> have some problems with this as multiple clk_enables have been called?

Russell already answered that, all drivers have to be augmented
in the following way (this is for PL011, the same will be valid for
any other PrimeCell with aggressive clocking):

[Russell King]
> 1. add an amba_bus_clk_disable() at the end of the successful probe
>  function
> 2. add amba_bus_clk_enable() at the beginning of the remove function.
> 3. add amba_bus_clk_enable()/amba_bus_clk_disable() around each of the
> suspend(), resume(), pl011_console_write(), and
>  pl011_console_get_options() functions.
> 4. amba_bus_clk_enable() at the start of the startup method.
> 5. amba_bus_clk_disable() at the end of the shutdown method.

> AMBA enables clock in amba_probe() <<< clock use count = 1
> pl022 driver enables clock in mmci_probe <<< clock use count = 2
> ...SPI stuff happens...
> ...Linux enters suspend mode...
> pl022 driver enters suspend mode, disables clock <<< clock use count = 1

OK I feel some responsibility for that driver so I will try to fix it,
maybe I can take a round@PL011 and perhaps MMCI as well.

Yours,
Linus Walleij
