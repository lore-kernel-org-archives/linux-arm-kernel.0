From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2015 10:27:57 +0000
Subject: [PATCH] ARM: PJ4: move coprocessor register access sequences to
 iwmmxt.S
In-Reply-To: <CAKv+Gu9tjeMska_1EUwcCgPoX=uXZkv0q+goew3q59T1UwEsyg@mail.gmail.com>
References: <1447397933-13379-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151113184807.GA21047@codeaurora.org>
 <CAKv+Gu9tjeMska_1EUwcCgPoX=uXZkv0q+goew3q59T1UwEsyg@mail.gmail.com>
Message-ID: <20151217102757.GF8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 08:23:34PM +0100, Ard Biesheuvel wrote:
> On 13 November 2015 at 19:48, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 11/13, Ard Biesheuvel wrote:
> >> The PJ4 inline asm sequences in pj4-cp0.c cannot be built in Thumb-2 mode,
> >> due to the way it performs arithmetic on the program counter, so it is
> >> built in ARM mode instead. However, building C files in ARM mode under
> >> CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
> >> by subsystems like ftrace does not expect having to deal with interworking
> >> branches.
> >>
> >> So instead, revert to building pj4-cp0.c in Thumb-2 mode, and move the
> >> offending sequence to iwmmxt.S, which is not instrumented anyway, and is
> >> already built in ARM mode unconditionally.
> >>
> >> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >
> > Tested-by: Stephen Boyd <sboyd@codeaurora.org>
> >
> 
> Thanks.
> 
> I've put this into the patch system (8452/1)

And I've dropped it from my tree because it's broken.

Come on guys, you can do better than this:

arch/arm/kernel/built-in.o: In function `pj4_cp0_init':
arch/arm/kernel/psci-call.o:(.init.text+0x22d0): undefined reference to `pj4_cp_access_write'
arch/arm/kernel/psci-call.o:(.init.text+0x22e0): undefined reference to `pj4_cp_access_write'
arch/arm/kernel/psci-call.o:(.init.text+0x2304): undefined reference to `pj4_cp_access_read'
arch/arm/kernel/psci-call.o:(.init.text+0x2310): undefined reference to `pj4_cp_access_write'
arch/arm/kernel/psci-call.o:(.init.text+0x2314): undefined reference to `pj4_cp_access_read'

Let's look at the makefile:

obj-$(CONFIG_CPU_PJ4)           += pj4-cp0.o
obj-$(CONFIG_CPU_PJ4B)          += pj4-cp0.o
obj-$(CONFIG_IWMMXT)            += iwmmxt.o

Now, you're moving code from pj4-cp0.c to iwmmxt.S, and of course, you
checked that IWMMXT would always be enabled if either PJ4 or PJ4B are
enabled.

config IWMMXT
        bool "Enable iWMMXt support"
        depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
        default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B

Err, no, IWMMXT can be disabled.  Hence the build errors.

Please, take more time when moving code around to ensure that this kind
of build breakage doesn't creep in.  It's *really* easy to check, it
only takes a couple of additional minutes.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
