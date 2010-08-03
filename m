From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Aug 2010 22:23:34 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <083DF309106F364B939360100EC290F80AC39A091A@eu1rdcrdc1wx030.exi.nxp.com>
References: <20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC392ACFC@eu1rdcrdc1wx030.exi.nxp.com>
	<20100730070943.GA29746@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC39A091A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100803212334.GC28048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 02:40:39AM +0200, Kevin Wells wrote:
> One more item I noted. These changes want to keep the clock enabled
> after the probe - only disabling the clock on amba_remove. Both the
> AMBA peripheral driver (ie, the LCD or MMCI driver) and the amba_remove
> function now disable the clocks.

Absolutely correct.  If we enable the clock for the probe call, and then
disable it afterwards, then what do AMBA bus drivers which have registered
interrupt routines in their probe function do when they receive an
interrupt and want to access their statuc register?

Do we just let them go ahead and fault?  That's just stupid.

No, what we do is create a setup where existing drivers continue to work
without modification - and that means ensuring that the bus clock is
enabled for the duration that the driver is active.

As I've already said, if drivers then want to achieve greater power savings,
they need to use the supplied functions to manage the bus clock - with the
assumption that they will be called with the bus clock already enabled.
If a driver doesn't participate in managing the APB clock, then they don't
need to be modified.

> Wouldn't drivers that use clk_disable in their xxx_suspend functions
> have some problems with this as multiple clk_enables have been called?

Probably, and I left this intentionally open for the time being because
it wasn't clear whether the right action was to disable the bus clock
across a suspend.

However, thinking about it some more, it's probably safe to disable the
bus clock _after_ the driver specific suspend call has successfully
completed, and re-enable it before calling the resume method.  So let's
do this...
