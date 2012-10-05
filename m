From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Oct 2012 10:12:37 +0900
Subject: [PATCH] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <506D52D2.9060105@ti.com>
References: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
 <506D52D2.9060105@ti.com>
Message-ID: <20121005011237.GA17182@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 02:41:46PM +0530, Santosh Shilimkar wrote:
> On Thursday 04 October 2012 02:20 PM, Stephen Boyd wrote:
> >The TWD and SCU configs are selected by default as long as
> >SCORPIONMP is false and/or MCT is false. Implementing the logic
> >this way certainly saves lines in the Kconfig but it precludes
> >those machines which select SCORPIONMP or MCT from participating
> >in the single zImage effort because when those machines are
> >combined with other SMP capable machines the TWD and SCU are no
> >longer selected.
> >
> >Push the select out to the machine entries so that we can compile
> >these machines together and still select the appropriate configs.
> >
> >Signed-off-by: Stephen Boyd<sboyd@codeaurora.org>
> >Cc: David Brown<davidb@codeaurora.org>
> >Cc: Kukjin Kim<kgene.kim@samsung.com>
> >Cc: Linus Walleij<linus.walleij@linaro.org>
> >Cc: Pawel Moll<pawel.moll@arm.com>
> >Cc: Rob Herring<rob.herring@calxeda.com>
> >Cc: Russell King<linux@arm.linux.org.uk>
> >Cc: Sascha Hauer<kernel@pengutronix.de>
> >Cc: Shiraz Hashim<shiraz.hashim@st.com>
> >Cc: Simon Horman<horms@verge.net.au>
> >Cc: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>
> >Cc: Stephen Warren<swarren@wwwdotorg.org>
> >Cc: Tony Lindgren<tony@atomide.com>
> >Cc: Viresh Kumar<viresh.linux@gmail.com>
> >---
> >
> >Does OMAP5 need to select TWD? I suspect not if it uses the
> >architected timers.
> >
> Nope. OMAP5 don't use TWD. Infact the external SCU is also used
> for A9 SOCs. You might want to check other A15 SOCS for SCU as
> well.

In that case I am a bit confused by the following result:

# git checkout v3.6
# ARCH=arm make omap2plus_defconfig
# grep '(SOC_OMAP5|_SCU|_TWD|CONFIG_SMP|CONFIG_LOCAL_TIMERS)=' .config
CONFIG_SOC_OMAP5=y
CONFIG_SMP=y
CONFIG_HAVE_ARM_SCU=y
CONFIG_HAVE_ARM_TWD=y
CONFIG_LOCAL_TIMERS=y
