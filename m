From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Jul 2010 08:30:28 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100710071913.GM22845@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
Message-ID: <20100710073028.GN22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 10, 2010 at 08:19:13AM +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 10, 2010 at 01:55:26AM +0200, Linus Walleij wrote:
> > This looks mostly good to me (comments below) but will have as
> > a side effect that all clock frameworks on all platforms using PrimeCells
> > will need to be initialized *before* the PrimeCell devices are added.
> 
> No it doesn't - it needs the clock API to be initialized before the
> first driver is probed.  As drivers are registered during the initcalls,
> later than postcore level

... (to finish this) ...

drivers/amba/bus.c:postcore_initcall(amba_init);

This is the earliest that any driver can be registered, as the AMBA bus
type will not be registered until that point.  So, provided the clk API
is initialized at or before postcore level, AMBA devices are fine.

What we do need to do is add a 'busck' to amba using platforms as the
NULL connection name for the function clock in the clkdev tables will
match.
