From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 17 Mar 2012 00:47:06 +0100
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
 <201203161218.05125.arnd.bergmann@linaro.org>
 <201203162057.58706.arnd@arndb.de>
 <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
Message-ID: <20120316234706.GJ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Mar 16, 2012 at 04:21:17PM -0600, Paul Walmsley wrote:
> Hi
> 
> On Fri, 16 Mar 2012, Arnd Bergmann wrote:
> 
> 
> If the common clock code is to go upstream now, it should be marked as 
> experimental.

No, please don't do this. This effectively marks the architectures using
the generic clock framework experimental. We can mark drivers as 'you
have been warned', but marking an architecture as experimental is the
wrong sign for both its users and people willing to adopt the framework.
Also we get this:

warning: (ARCH_MX1 && MACH_MX21 && ARCH_MX25 && MACH_MX27) selects COMMON_CLK which has unmet direct dependencies (EXPERIMENTAL)

(and no, I don't want to support to clock frameworks in parallel)

> This is because we know the API is not well-defined, and 
> that both the API and the underlying mechanics will almost certainly need 
> to change for non-trivial uses of the rate changing code (e.g., DVFS with 
> external I/O devices).

Please leave DVFS out of the game. DVFS will use the clock framework for
the F part and the regulator framework for the V part, but the clock
framework should not get extended with DVFS features. The notifiers we
currently have in the clock framework should give enough information
for DVFS implementations. Even if they don't and we have to change
something here this will have no influence on the architectures
implementing their clock tree with the common clock framework.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
