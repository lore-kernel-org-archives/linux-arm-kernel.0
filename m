From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Feb 2016 10:41:03 +0100
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <CABGGisxORFOxLVQiTZ=gEr6j2JnVcjQxTLJFPa7uG93g46CKwg@mail.gmail.com>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <20160210125936.GD31506@lukather>
 <CABGGisxORFOxLVQiTZ=gEr6j2JnVcjQxTLJFPa7uG93g46CKwg@mail.gmail.com>
Message-ID: <20160211094103.GI31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 08:02:45AM -0600, Rob Herring wrote:
> On Wed, Feb 10, 2016 at 6:59 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Fri, Feb 05, 2016 at 05:59:23PM +0000, Andre Przywara wrote:
> >> Hi Maxime,
> >>
> >> just found this while looking at your current git branch, so sorry for
> >> the late reply.
> >>
> >> CC:ing DT people, since you touch both existing DTs(!) and the binding doc.
> 
> [...]
> 
> >> So are you really breaking all those systems by changing the DT and the
> >> driver in an incompatible way?
> >
> > Yes.
> >
> >> Please correct me if this assessment is wrong, but to me it looks like
> >> any user out there is either stuck with 4.5 at best _or_ will only be
> >> able to run 4.6 and later (depending on which version of the DT she is
> >> using)? And no, switching DTs along with the kernel is _not_ an option.
> >
> > It is. And it is one that every other ARM platform chose. And so did
> > every distribution.
> 
> I do leave it to platform maintainers judgement (perhaps that should
> be reconsidered), but it should still be case by case basis not an all
> out disregard for the ABI. If you decide to ignore the ABI, then there
> is no decision for the distros or other users.
> 
> >> That is not how I understand DT.
> >
> > I'm sorry for that. This has never been something we said was
> > happening.
> >
> >> Also this totally ignores any other DT user (U-Boot, FreeBSD, you
> >> name it).
> >
> > Which all have their own DT copies, with their own bindings, that we
> > (ie Linux) never agreed on.
> 
> That is not really true. There are some differences ATM, but they are
> largely derivatives of the kernel copy and the goal is to align them.
> If we don't maintain an ABI, that will never happen.

At least for us, this is definitely true. The SoCs impacted by this
change are not supported by FreeBSD at all, and the one that are
supported have bindings that do not match the one we have in the
kernel:
https://github.com/freebsd/freebsd/blob/master/sys/boot/fdt/dts/arm/sun4i-a10.dtsi

Over the 10 compatibles used there, 3 are totally different (watchdog,
the SRAM controller and the clock hardware block) and two deviates in
incompatible ways (timer and pinctrl) and one has property that we'd
probably deny (UART, and its current-speed). 6 out of 10 overall.

And U-boot never had any issue in the past with that policy. Tom said
it on several occasions, and it worked for us too, with some minor
compromises we needed, such as keeping some node pathes that U-Boot
was using, even though it turned out to be wrong.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun7i-a20.dtsi#n615

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/e0c1cd6a/attachment.sig>
