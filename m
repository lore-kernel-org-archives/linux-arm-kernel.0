From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Apr 2011 09:54:52 +0100
Subject: kirkwood build failure on mainline
In-Reply-To: <87r59lr7ac.fsf@lebrac.rtp-net.org>
References: <87r59lr7ac.fsf@lebrac.rtp-net.org>
Message-ID: <20110402085452.GF8482@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 11:27:55PM +0200, Arnaud Patard wrote:
> Hi,
> 
> Thanks to kautobuild, I've noticed that -rc1 is not building on kirkwood
> with following error [1]:
> 
> arch/arm/kernel/built-in.o: In function `cpu_suspend':
> io.c:(.text+0x4544): undefined reference to `cpu_feroceon_do_suspend'
> io.c:(.text+0x4554): undefined reference to `cpu_feroceon_suspend_size'
> arch/arm/kernel/built-in.o: In function `cpu_resume':
> io.c:(.data+0x1e8): undefined reference to `cpu_feroceon_do_resume'
> 
> After looking at other build logs, there are other platform failing with
> similar error. I guess it's failing since commit
> f6b0fa02e8b0708d17d631afce456524eadf87ff "ARM: pm: add generic CPU
> suspend/resume support". In fact, I would say that this commit only
> shows that there's a problem and is not really the cause.
> A naive explanation would be that ARCH_SUSPEND_POSSIBLE is selected for
> theses systems even if suspend is not supported. Adding a "depends on
> !CPU_FEROCEON" is making the kernel build.
> 
> Would a patch disabling ARCH_SUSPEND_POSSIBLE for all cpu failing to
> build with similar error be accepted/welcome or it's just a really
> stupid idea ? In case of it being a stupid idea, what would be the right
> approach to fix that given that implementing suspend for all failing SoC
> is excluded ?

Or maybe we want the sleep code to depend on CONFIG_PM_SLEEP rather than
CONFIG_PM?

Looks to me like someone changed the meaning of CONFIG_PM (which used to
be "support suspend stuff such as s2ram" to include the new runtime PM
stuff without updating the various ARM makefiles before I consolidated
the sleep assembly code.
