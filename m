From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 20:35:16 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124200730.GA25963@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
 <20151124103948.GZ8644@n2100.arm.linux.org.uk>
 <20151124200730.GA25963@codeaurora.org>
Message-ID: <20151124203516.GH8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 12:07:30PM -0800, Stephen Boyd wrote:
> Ok. Presumably the order of arch-$(CONFIG) lines in the Makefile
> are done in an order to allow the build to degrade to the lowest
> common denominator among architecture support.

Correct.  Make processes the directives in the order listed in the
makefile, which means that a variable final value results from its
last assignment.

> CPU_V7 selects
> CPU_32v7 and we're using that config to select -march=armv7-a in
> the Makefile. The patch currently uses CPU_32v7VE to select
> -march=armv7ve. If CPU_V7VE selects CPU_V7 we'll never be able to
> use -march=armv7ve because CPU_V7 will be selecting CPU_32v7 and
> that will come after CPU_32v7VE in the Makefile.

Right, but look at how the V6K stuff is handled:

arch-$(CONFIG_CPU_32v6)         =-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
# Only override the compiler option if ARMv6. The ARMv6K extensions are
# always available in ARMv7
ifeq ($(CONFIG_CPU_32v6),y)
arch-$(CONFIG_CPU_32v6K)        =-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6k,-march=armv5t -Wa$(comma)-march=armv6k)
endif

We'd need to do something similar for v7VE as well.  As we're getting
more of this, I'd suggest we move to:

arch-v7a-y			=$(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
arch-v7a-$(CONFIG_CPU_32v7VE)	=... whatever it was...
arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 $(arch-v7a-y)
arch-v6-y			=$(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
arch-v6-$(CONFIG_CPU_32v6K)	=$(call cc-option,-march=armv6k,-march=armv5t -Wa$(comma)-march=armv6k)
arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 $(arch-v6-y)

> My understanding is that we want to support CPU_V7VE without
> CPU_V7 enabled so that it uses the idiv instructions in that
> configuration. When V7VE and V7 are both enabled, we should
> degrade to the aeabi functions, and the same is true for when
> V7VE is disabled.

Let me have another look at this, it's been a while since I touched these
options...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
