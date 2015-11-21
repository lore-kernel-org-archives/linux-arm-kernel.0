From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Nov 2015 22:00:16 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <5239BA2A-BCD9-4A8C-BC34-F48603137E08@mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <7199523.6J0A1gxY4q@wuerfel> <5239BA2A-BCD9-4A8C-BC34-F48603137E08@mansr.com>
Message-ID: <6160413.CulAvzVaQj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 November 2015 20:45:38 M?ns Rullg?rd wrote:
> On 21 November 2015 20:39:58 GMT+00:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >On Friday 20 November 2015 17:23:14 Stephen Boyd wrote:
> >> This is a respin of a patch series from about a year ago[1]. I
> >realized
> >> that we already had most of the code in recordmcount to figure out
> >> where we make calls to particular functions, so recording where
> >> we make calls to the integer division functions should be easy enough
> >> to add support for in the same codepaths. Looking back on the thread
> >> it seems like Mans was thinking along the same lines, although it
> >wasn't
> >> obvious to me back then or even over the last few days when I wrote
> >this.
> >
> >Shouldn't we start by allowing to build the kernel for -march=armv7ve
> >on platforms that allow it? That would seem like a simpler change
> >and likely generate better code for most people, except when you
> >actually
> >care about running the same binary kernel on older platforms.
> >
> >I tried to get a complete list of CPU cores with idiv, lpae and
> >virtualization support at some point, but I don't remember the
> >details for all Qualcomm and Marvell cores any more, to create the
> >complete configuration matrix. IIRC, all CPUs that support
> >virtualization also do lpae (they have to) and all CPUs that
> >do lpae also do idiv, but the opposite is not true.
> >
> 
> The ARM ARM says anything with virt has idiv, lpae doesn't matter.

Ok, and anything with virt also has lpae by definition. The question is
whether we care about using idiv on cores that do not have lpae, or that
have neither lpae nor virt.

We have a related problem at the moment where we don't handle configuration
of lpae correctly in Kconfig: you can simply turn that on for any
ARMv7-only kernel, but it breaks running on Cortex-A8, Cortex-A9
and at least some subset of PJ4/Scorpion/Krait (not sure which).

If we add a way to configure idiv support, we should do it right and
handle lpae correctly too. If we are lucky, each CPU we support
either has both or neither, and then we just need one additional
Kconfig option. We don't need another option for virt, because KVM
support can be handled in a way that it doesn't break on cores with
lpae but without virt (it requires lpae).

> ARMv7-R also has idiv. I've no idea if anyone runs Linux on those though.

Not mainline at least. There were patches at some point, but they
never got merged.

	Arnd
