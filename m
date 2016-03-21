From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Mar 2016 21:50:26 +0100
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <56EC01D7.2050609@foss.arm.com>
References: <201603101013.04618.arnd@arndb.de>
 <CALT56yO4mg3AtgASyo64G61w0tiztubyDRi0hSzn7km0jLLnew@mail.gmail.com>
 <56EC01D7.2050609@foss.arm.com>
Message-ID: <3736000.gcRqYnZUVK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 March 2016 13:25:43 Ramana Radhakrishnan wrote:
> > 
> > Removing armv4 support means also removing -mtune support for those
> > chips (I'm especially concerned about strongarm1100).
> > Would it be possible to remove armv4 support, but leave performance
> > settings/tunings intact?
> 
> I'm not sure how ugly the end result will be if we went down the route, the simplest egregious hack would be to treat strongarm as v4t but then relying on the linker to fix things up. However ...

At that point, you could simply define armv4 to be synonymous with armv4t
and leave the bx fixup up to the user.
 
> Are you able to compare performance by tuning for arm9 on strongarm as I see that is the closest in terms of tuning to strongarm ? The only differences are in the number of instructions to conditionalize 3 for sa vs 5 for arm9 and the latency of multiplies being 3 rather than 4 in the legacy scheduler.

It also depends on whether Dmitry wants to build just the kernel with
gcc >= 7.0 or also user space. The kernel has very little code that really
benefits from optimizing for a specific core, and we don't really try to
pick the best tuning options: For ARMv7 we just use the default of the
compiler even when we know which core we have, and for both fa526
and arm926ejs, we explicitly set -mtune=arm9tdmi, even though both
have their own pipeline descriptions in gcc.

I couldn't find out from the gcc source, but is there any noticeable
difference between building with -mtune=arm9tdmi and mtune=arm926ejs?

Also, for a combined armv6/v7 kernel that might run on any Cortex-A
(including the 64-bit ones) as well as ARM11, Krait, Scorpion and PJ4,
is there an option that works better overall than -mtune=arm1136?
We currently use that whenever some ARMv6 target is enabled, and
I don't think anyone has even touched those options in the last 10
years.

	Arnd
