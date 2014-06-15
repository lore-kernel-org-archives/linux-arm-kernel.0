From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Jun 2014 14:12:37 +0100
Subject: [PATCH v2 1/2] ARM: imx6qdl: switch to use macro for clock ID
In-Reply-To: <1402837204-30474-1-git-send-email-shawn.guo@freescale.com>
References: <1402837204-30474-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140615131237.GU23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 15, 2014 at 09:00:03PM +0800, Shawn Guo wrote:
> Instead of using enum for clock ID, let's switch imx6qdl clock driver to
> use macro.  In this case, device tree can reuse these macros to improve
> readability.

Long overdue.  I recently needed to find out the clocks for the LDB, and
this is the process I followed:

1. Look up the clock names in the imx6qdl.dtsi file.
2. Convert them to clock index.
3. Look in Documentation/devicetree/bindings/imx6q-clock.txt to translate
   the clock index to another name.
4. Look in arch/arm/mach-imx/clk-imx6q.c to find out what register(s) they
   access.
5. Look the registers up in the IMX6 reference manuals to convert the
   register bits which are being manipulated to names that the manuals
   use.
6. Refer to the CCM clock tree diagram to find out where in the heirarchy
   the clock actually sits.

This is incredibly time consuming and error-prone, and really, I wish that
the names used in clk-imx6q.c were as close as possible to those used in
the reference manual to cut down on the number of indirections required to
understand this stuff.

Don't get me wrong - your patch is beneficial to that end, removing two
levels of indirection, but I wish we could get rid of more levels while
we're at it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
