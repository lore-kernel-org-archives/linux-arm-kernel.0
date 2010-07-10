From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Jul 2010 08:19:13 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
Message-ID: <20100710071913.GM22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 10, 2010 at 01:55:26AM +0200, Linus Walleij wrote:
> This looks mostly good to me (comments below) but will have as
> a side effect that all clock frameworks on all platforms using PrimeCells
> will need to be initialized *before* the PrimeCell devices are added.

No it doesn't - it needs the clock API to be initialized before the
first driver is probed.  As drivers are registered during the initcalls,
later than postcore level

> > - ? ? ? id = amba_lookup(pcdrv->id_table, pcdev);
> > + ? ? ? ? ? ? ? ret = pcdrv->probe(pcdev, id);
> > + ? ? ? ? ? ? ? if (ret == 0)
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> 
> So this means you always turn on the block clock at
> probe, and then leave it on if the probe was successful.

Correct, which is what drivers currently expect.  This is also why
two additional amba_* callbacks are supplied - if it is appropriate
for a driver to disable their bus clock after being probed, they can
do that but they have to participate in that.

Basically, they have to call amba_bus_clk_disable() on successful
probe, and then amba_bus_clk_enable() each time that they want to
access their registers, followed by an amba_bus_clk_disable() when
they've finished.  Finally, they must call amba_bus_clk_enable()
in their remove method and avoid amba_bus_clk_disable() before
returning.

> For drivers that need to conserve power, also the block
> clock has to be gated when the device is not in use,
> sometimes since that affects some hardware that keep
> track of the usecount of the clock tree for a larger region of
> silicon, so the power savings can be drastic.

You can't have the core code doing that.  If you unconditionally turn
the bus clock off after probe, what happens when a driver receives an
interrupt and tries to access its registers?

Hint: the core code can't know that the driver has registered an IRQ
handler.
