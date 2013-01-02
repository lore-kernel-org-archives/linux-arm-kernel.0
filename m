From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jan 2013 23:15:13 +0000
Subject: [PATCH v2] ARM: Kconfig: Do not force selection of
 ARCH_VEXPRESS by ARCH_MULTI_V7
In-Reply-To: <CAOMZO5CFPh9TsdGKZx=hKqJ-VvUX9sLw1rzR1intMcidEb9nfQ@mail.gmail.com>
References: <1353431918-9326-1-git-send-email-festevam@gmail.com>
 <20130102225921.GH2631@n2100.arm.linux.org.uk>
 <CAOMZO5CFPh9TsdGKZx=hKqJ-VvUX9sLw1rzR1intMcidEb9nfQ@mail.gmail.com>
Message-ID: <20130102231513.GI2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 09:03:52PM -0200, Fabio Estevam wrote:
> On Wed, Jan 2, 2013 at 8:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 20, 2012 at 03:18:38PM -0200, Fabio Estevam wrote:
> >> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> >> index b9f38e3..aa46be8 100644
> >> --- a/arch/arm/kernel/vmlinux.lds.S
> >> +++ b/arch/arm/kernel/vmlinux.lds.S
> >> @@ -310,4 +310,6 @@ SECTIONS
> >>   * binutils is too old (for other reasons as well)
> >>   */
> >>  ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
> >> +#ifndef CONFIG_ARCH_MULTIPLATFORM
> >>  ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
> >> +#endif
> >
> > This is wrong.  So you want a kernel build which produces an unbootable
> > kernel (because it contains absolutely no platform support of any kind,
> > not even any DT platform support) to succeed?
> 
> Ok, what about the first version?
> https://patchwork.kernel.org/patch/1774521/

That seems to be better because it leaves the desire for an unbootable
kernel to be a build failure.

However, it allows the multi-platform case to end up with a configuration
where such a kernel can be generated, which is something Arnd wants to
avoid as it messes up allnoconfig and randconfig builds.

What we need to come up with is some kind of "default platform" which is
always built into the kernel.  Will had some ideas about that for the
virtualization stuff, but I think there were objections to that over it
being modelled on Versatile Express.  If that can be sorted, then we
have a solution to this problem.

We _should_ be aiming to get to that state anyway, where the kernel
doesn't need to know about platform X, Y or Z but just uses the
description in DT which tells it where devices A, B, and C are and how
they relate to the rest of the system.
