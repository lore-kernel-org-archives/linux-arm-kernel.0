From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 18 Mar 2015 09:57:27 +0100
Subject: [PATCH v2] ARM: EXYNOS: Fix failed second suspend on Exynos4
In-Reply-To: <55086CE0.6080905@kernel.org>
References: <1426069206-13667-1-git-send-email-k.kozlowski@samsung.com>
 <1426069765.30407.7.camel@AMDC1943> <55086CE0.6080905@kernel.org>
Message-ID: <1426669047.29565.9.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2015-03-18 at 03:05 +0900, Kukjin Kim wrote:
> On 03/11/15 19:29, Krzysztof Kozlowski wrote:
> > On ?ro, 2015-03-11 at 11:20 +0100, Krzysztof Kozlowski wrote:
> >> On Exynos4412 boards (Trats2, Odroid U3) after enabling L2 cache in
> >> 56b60b8bce4a ("ARM: 8265/1: dts: exynos4: Add nodes for L2 cache
> >> controller") the second suspend to RAM failed. First suspend worked fine
> >> but the next one hang just after powering down of secondary CPUs (system
> >> consumed energy as it would be running but was not responsive).
> >>
> >> The issue was caused by enabling delayed reset assertion for CPU0 just
> >> after issuing power down of cores. This was introduced for Exynos4 in
> >> 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off").
> >>
> >> The whole behavior is not well documented but after checking with vendor
> >> code this should be done like this (on Exynos4):
> >> 1. Enable delayed reset assertion when system is running (for all CPUs).
> >> 2. Disable delayed reset assertion before suspending the system.
> >>    This can be done after powering off secondary CPUs.
> >> 3. Re-enable the delayed reset assertion when system is resumed.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Fixes: 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off")
> >> Cc: <stable@vger.kernel.org>
> >> Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > 
> > Dear Kukjin,
> > 
> > This patch was first sent on 3rd of February. It could enter before
> > opening 4.0 merge window. I did not receive any response from you in
> > that time.
> > 
> > So let me point next steps:
> > 1. The Exynos4412 suspend on 4.0 is broken and now this patch applies as
> > a fix.
> > 2. I resent it on 18th of February.
> > 3. I received tested-by from Bartlomiej and Chanwoo.
> > 4. Bartlomiej pinged you on 3rd March.
> > 
> > Still no response. If the patch does not look good then please share
> > your comments. I'll fix it.
> > If this patch looks good, why does it take so much time?
> > 
> 
> Please use another way something like check ARM core rather than use
> 'soc_is_xxx()', as you know it is not acceptable now even it is just
> moving/modifying exist function though.

Probably of_machine_is_compatible() could be used here but such change
should be done in separate patch. This is fix for wrong usage of
use_delayed_assertion so it should not mix with other changes in the
code. This fixes one thing at a time. Fixing many things in one patch
often leads to new errors or difficulties in debugging.

I can prepare a separate patch for changing this to
of_machine_is_compatible().

> 
> And please make sure your updates don't hurt other exynos5 stuff. Any
> tests on exynos5 platforms would be helpful.
> 
> And I don't think the fix should be sent to 'stable' because I can't see
> the 'add node for L2$ controller' in v3.19...looks applied from v4.0-rc...

You're right. git-describe gave me 3.19-rc1 but this was tag for the
specific commit, not for merge-commit. The stable can be removed if this
comes during this RC-cycle.

> 
> One more if you have any doubts, I'd like to ask you to contact S.LSI
> guys who have created the vendor codes not assume with the code because
> maybe the vendor code you mentioned cannot cover all exynos stuff I
> think. Then we could make more clear pm codes in mainline. To be honest
> I'm not a Power Management hardware guy so I don't know every regarding
> PM stuff in exynos SoCs, I can contact them easier though...I mean
> please don't assume any hardware behavior with just vendor code. Please
> ask, you have an access in Samsung intranet before posting something
> like this...Hope let's make a better fix together during -rc.

As you probably know I work in completely different company within
Samsung Electronics than System LSI. I don't have access to the LSI
intranet. I don't have access to guys from LSI. I'll try contacting them
through my HQ partners.

Thanks for feedback!

Best regards,
Krzysztof
