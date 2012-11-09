From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 Nov 2012 19:09:43 +0900
Subject: [PATCH 2/4] gpio: samsung: Skip registration if pinctrl driver is
 present on Exynos4x12
In-Reply-To: <CACRpkdaOpzFvs_wqy9sdrmx1=wEs5uxqfh_rOrKxLTXV-q1K2Q@mail.gmail.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <1351089457-8205-3-git-send-email-t.figa@samsung.com>
 <CACRpkdYNDSp0K3wpvUem9ecsW-JQ9L6aKqaOmHNUR65DQTMNHA@mail.gmail.com>
 <0c5301cdbca2$30320240$909606c0$%kim@samsung.com>
 <CACRpkdaOpzFvs_wqy9sdrmx1=wEs5uxqfh_rOrKxLTXV-q1K2Q@mail.gmail.com>
Message-ID: <0e8301cdbe62$56a1d010$03e57030$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Wed, Nov 7, 2012 at 5:41 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> > A commit 1b6056d6 ("pinctrl: samsung: Include bank-specific eint offset
> in
> > bank struct") which is in your pinctrl tree (samsung branch) changed
> > macro(EXYNOS_PIN_BANK_EINTG) to add offset. Eventually, this series(due
> to
> > 3rd patch, pinctrl: samsung: Add support for Exynos4x12) breaks
> compilation
> > without the commit. So if you don't have a plan to rebase samsung branch
> of
> > your pinctrl tree, I'd like to merge it in my tree. Is it ok to you?
> 
> Sure tell me when you've merged it and I'll drop commit 1b6056d6
> from my tree.
> 

Thanks :-)

(- some guys in Cc...)

But having a problem, the 'it' means the commit 1b6056d6? If so, I couldn't
cherry-pick only that because of dependency with other commits 40ba622 and
3a232ba.

$ git cherry-pick -s 40ba622
[next/dt-exynos4x12 3b1977c] pinctrl: samsung: Assing pin numbers
dynamically
 Author: Tomasz Figa <t.figa@samsung.com>
 3 files changed, 62 insertions(+), 54 deletions(-)

$ git cherry-pick -s 3a232ba
[next/dt-exynos4x12 7fa08a4] pinctrl: samsung: Remove static pin
enumerations
 Author: Tomasz Figa <t.figa@samsung.com>
 1 files changed, 96 insertions(+), 215 deletions(-)
 rewrite drivers/pinctrl/pinctrl-exynos.h (66%)

$ git cherry-pick -s 1b6056d
[next/dt-exynos4x12 86010aa] pinctrl: samsung: Include bank-specific eint
offset in bank struct
 Author: Tomasz Figa <t.figa@samsung.com>
 3 files changed, 30 insertions(+), 29 deletions(-)

I could cherry-pick clearly with 2 more commits.

Can you drop above 3 commits in your tree? If many conflicts happens during
rebasing, how about that I merge your pinctrl/samsung branch into Samsung
tree?...

$ git log --oneline pinctrl/samsung v3.7-rc1..pinctrl/samsung
b33ef91 Documentation: Update samsung-pinctrl device tree bindings
documentation
a19fe2d pinctrl: samsung: Add GPIO to IRQ translation
22b9ba0 pinctrl: exynos: Set pin function to EINT in irq_set_type of wake-up
EINT
a04b07c pinctrl: samsung: Use per-bank IRQ domain for wake-up interrupts
d3a7b9e pinctrl: samsung: Use one GPIO chip per pin bank
595be72 pinctrl: exynos: Use one IRQ domain per pin bank
1b6056d pinctrl: samsung: Include bank-specific eint offset in bank struct
6defe9a pinctrl: samsung: Hold pointer to driver data in bank struct
ab66378 pinctrl: samsung: Match pin banks with their device nodes
a7a8241 ARM: dts: exynos4210-pinctrl: Add nodes for pin banks
724e56a pinctrl: samsung: Distinguish between pin group and bank nodes
3a232ba pinctrl: samsung: Remove static pin enumerations
40ba622 pinctrl: samsung: Assing pin numbers dynamically
62f14c0 pinctrl: samsung: Do not pass gpio_chip to pin_to_reg_bank
7c367d3 pinctrl: samsung: Detect and handle unsupported configuration types

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
