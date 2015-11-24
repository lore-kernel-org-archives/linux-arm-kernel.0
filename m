From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 10:37:16 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124001306.GI19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151124001306.GI19156@codeaurora.org>
Message-ID: <20151124103715.GY8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:13:06PM -0800, Stephen Boyd wrote:
> On 11/23, Arnd Bergmann wrote:
> > 
> > Ok, thanks for the confirmation.
> > 
> > Summarizing what we've found, I think we can get away with just
> > introducing two Kconfig symbols ARCH_MULTI_V7VE and CPU_V7VE.
> > Most CPUs fall clearly into one category or the other, and then
> > we can allow LPAE to be selected for V7VE-only build but not
> > for plain V7, and we can unconditionally build the kernel with
> > 
> > arch-$(CONFIG_CPU_32v7VE)  = -D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-march=armv7-a -mcpu=cortex-a15)
> > 
> 
> This causes compiler spew for me:
> 
>   warning: switch -mcpu=cortex-a15 conflicts with -march=armv7-a switch
> 
> Removing -march=armv7-a from there makes it quiet.
> 
> Also, it's sort of feels wrong to have -mcpu in a place where
> we're exclusively doing -march. Perhaps the fallback should be
> bog standard -march=armv7-a? (or the fallback for that one
> "-march=armv5t -Wa$(comma)-march=armv7-a")?

How it was explained to me years ago is that -march selects the
instruction set, -mtune selects the instruction scheduling, and -mcpu
selects both.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
