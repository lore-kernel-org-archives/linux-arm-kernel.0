From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 09:07:40 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <4C3A950F.5040900@st.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<4C3A950F.5040900@st.com>
Message-ID: <20100712080740.GB22138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 09:37:43AM +0530, Viresh KUMAR wrote:
> This issue is different from the issue i raised which was common to
> all amba devices. This is just for this GPIO driver, we need to enable clk
> before using any gpio pin.

PL061 does not have any other clock signal other than PCLK, the APB (AMBA
peripheral bus) clock.  This clock needs to be running to access any
register in an APB peripheral.  The primecell drivers and AMBA support
is currently implemented with the assumtion that this clock is
permanently running.

If you need to enable a clock before using any GPIO pin, and it's not the
APB clock, then that's a platform extension that is outside of the PL061
domain, and probably also affects alternate functions of the GPIO pins as
well.  That means the PL061 code shouldn't manage that clock signal as it
won't know what's going on with the alternate functions.
