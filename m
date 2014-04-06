From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 06 Apr 2014 20:27:37 +0200
Subject: [PATCH v1 6/8] ARM: hisi: add hip04 SoC support
In-Reply-To: <CAOesGMiKeSvHL8ccjQuANggkA5yg+XyQppQEN0qS=XB=1O+e6w@mail.gmail.com>
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
 <8340307.jkTP7h04Ur@wuerfel>
 <CAOesGMiKeSvHL8ccjQuANggkA5yg+XyQppQEN0qS=XB=1O+e6w@mail.gmail.com>
Message-ID: <5010360.d9VTMQPr6c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 April 2014 19:01:16 Olof Johansson wrote:
> On Fri, Apr 4, 2014 at 8:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> > I think we should actually extend the CPU selection phase for multiplatform,
> > so we have separate symbols for ARCH_MULTI_V7 (non-LPAE) and
> > ARCH_MULTI_V7_LPAE. These would still be selectable at the same time,
> > but you should only be able to turn on CONFIG_LPAE if ARCH_MULTI_V7
> > is disabled.
> >
> > A platform that cannot run without LPAE conversely would have to depend
> > on (ARCH_MULTI_V7_LPAE && !ARCH_MULTI_V7 && !ARCH_MULTI_V6). Once it
> > does this, it can 'select LPAE' without breaking other platforms.
> 
> Why not just have it depend on ARCH_MULTI_V7 && LPAE? LPAE shouldn't
> be possible to enable if MULTI_V6 is enabled.
>
> So, you'd have:
> 
> MULTI_V6
> MULTI_V6 + V7
> MULTI_V7 + LPAE
> 
> as valid options.
> 
> We'd need to annotate existing non-LPAE platforms with depends on
> !LPAE, but that shouldn't be a big deal.

That would work, too. It really depends on how we treat global
options like MMU, SMP, LPAE, SPARSEMEM, etc in combination with
multiplatform kernels. At the moment we are rather inconsistent,
and so far I have always thought we should have them ordered in
the Kconfig menu in the same way as the dependency flow:

1. Pick a platform type (normally ARCH_MULTIPLATFORM)
2. (if ARCH_MULTIPLATFORM), pick architecture level(s): V4, V4T, V5, V6,
   V6K, V6K+SMP, V7, V7+LPAE, V7-M. We may decide to skip some of these.
3. Pick global features that are allowed based on 1. and 2.:
   MMU, SMP, LPAE, SPARSEMEM
4. (again, if MULTIPLATFORM) Pick SoC families, based on 1. and 2.
5. (if necessary) Pick boards.   

I'd like to keep steps 3 and 4 independent of one another, possibly
doing them in the opposite order.

An idea I just had was to essentially always imply compatibility
to later architectures where possible, e.g. selecting v4 would always
enable v4t and v5, and selecting v6k would always enable support for
v6+smp, v7 and v7+lpae, but not to v6. If we do this, the matrix
of possible combinations becomes much simpler, and for all I can tell
we only lose the ones that are not interesting anyway. The cost
of enabling support for a later architecture level is usually much
lower than the cost for enabling an earlier level.

The architecture level selection at that point becomes a simple
'choice' statement, rather than the complex logic I introduced
for multiplatform initially. It would also simplify adding new
levels for v7-m and v7-r.

> And, we should probably change the multi defconfigs to be:
> 
> multi_v6_v7_defconfig which contains what v7_defconfig does today,
> plus the v6 platforms
> multi_lpae_defconfig which contains only v7+lpae platforms (and would
> enable kvm, etc).

I like this part.

	Arnd
