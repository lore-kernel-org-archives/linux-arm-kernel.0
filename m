From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 12 Jun 2017 11:38:53 +0200
Subject: [PATCH] ARM64: Kconfig: Fix the missing hi655x common clk
In-Reply-To: <CAK8P3a0L6QNAJf6DB876DFHf7aGcD=uwxOUB36LKr-AX67VYAA@mail.gmail.com>
References: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
 <1496686434-13181-1-git-send-email-daniel.lezcano@linaro.org>
 <CAPDyKFqWptneK2V7wCR8LGbgU7=U9kBCKkHrtgGmZKmNQJ4s7g@mail.gmail.com>
 <20170609154652.GG2244@mai>
 <CAK8P3a1PsFcqLC95rSQf6EdkqhQ6sE3OXC9gDQ8TLp2mTVO3pw@mail.gmail.com>
 <CALAqxLXtLc16zT9AFaHXbbQp-Vf3GNOJ1nb7PoUJgj22rh=X-w@mail.gmail.com>
 <CAK8P3a0L6QNAJf6DB876DFHf7aGcD=uwxOUB36LKr-AX67VYAA@mail.gmail.com>
Message-ID: <20170612093853.GB2261@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 10:48:13PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 9, 2017 at 10:15 PM, John Stultz <john.stultz@linaro.org> wrote:
> > On Fri, Jun 9, 2017 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Fri, Jun 9, 2017 at 5:46 PM, Daniel Lezcano
> >> <daniel.lezcano@linaro.org> wrote:
> >>> On Tue, Jun 06, 2017 at 04:17:40PM +0200, Ulf Hansson wrote:
> >>>> On 5 June 2017 at 20:13, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>>> > With the addition of the hi655x common clock, the config option is missing
> >>>> > for the ARM64's hi6220 platform. That leads to a non functionnal WiFi because
> >>>> > the hi655x clock driver misses when initializing the power sequence via DT.
> >>>> >
> >>>> > Cc: John Stultz <john.stultz@linaro.org>
> >>>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> > Cc: Wei Xu <xuwei5@hisilicon.com>
> >>>> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>>
> >>>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>
> >>>> Would be nice to get this trivial fix in for 4.12 rcs to make the WiFi
> >>>> work for Hikey.
> >>>>
> >>>
> >>> I'm wondering if I submitted this patch for the right path.
> >>>
> >>> Shall it go through arm-soc ?
> >>
> >> Yes, but I'm not sure this is the right patch either. We tend to not
> >> use 'select' for user-visible drivers, and most hisilicon platforms
> >> won't need this driver.
> >>
> >> I think it would be more consistent to add this to the defconfig
> >> and regard it as a user error when the driver is disabled on a
> >> machine that needs it.
> >
> > Maybe the select is not exactly in the right place, but I don't really
> > feel like a pmic on an SoC is a "user-visible driver". I deal with the
> > board often and when the new dependency was made on the clk, I would
> > have never have found it on my own w/o Ulf and Daniel pointing out
> > what I needed to enable.
> 
> What I meant is that the Kconfig option is user-visible. On a very high
> level, this is a result of arch/arm64/Kconfig.platforms listing only
> very broad categories of SoCs, in many cases only the manufacturers
> of very different chip families, which then control the visibility of the
> individual Kconfig items for things like pinctrl or clk.
> 
> I now see that MFD_HI655X_PMIC is the top-level driver that you
> have to select before enabling COMMON_CLK_HI655X, so the
> patch is actually broken unless it actually selects both.
> 
> How about simply adding a 'default MFD_HI655X_PMIC' to
> COMMON_CLK_HI655X to enable it unless it is explicitly
> turned off?

Actually, I share John's opinion.

Ideally when we choose a platform, all the relevants devices configuration
options should be selected automatically from a single topmost node of a tree
(platform selection) to all the nodes corresponding to the devices, leaving the
user to select one simple option without knowledge of the SoC hardware
internals.

If the user is expert in the platform and knows exactly what he does, then he
can select an _EXPERT_ like option and be able to disable some drivers.

It is how I tend to write the Kconfig options, so the 'default MFD_HI655X_PMIC'
is confusing for me. Wouldn't make sense to select COMMON_CLK_HI655X when
MFD_HI655X_PMIC is enabled?



-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
