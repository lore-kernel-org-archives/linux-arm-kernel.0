From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jun 2017 23:12:05 +0200
Subject: [PATCH] ARM64: Kconfig: Fix the missing hi655x common clk
In-Reply-To: <20170612093853.GB2261@mai>
References: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
 <1496686434-13181-1-git-send-email-daniel.lezcano@linaro.org>
 <CAPDyKFqWptneK2V7wCR8LGbgU7=U9kBCKkHrtgGmZKmNQJ4s7g@mail.gmail.com>
 <20170609154652.GG2244@mai>
 <CAK8P3a1PsFcqLC95rSQf6EdkqhQ6sE3OXC9gDQ8TLp2mTVO3pw@mail.gmail.com>
 <CALAqxLXtLc16zT9AFaHXbbQp-Vf3GNOJ1nb7PoUJgj22rh=X-w@mail.gmail.com>
 <CAK8P3a0L6QNAJf6DB876DFHf7aGcD=uwxOUB36LKr-AX67VYAA@mail.gmail.com>
 <20170612093853.GB2261@mai>
Message-ID: <CAK8P3a1DbjovHF3QX9OuPA1q4XAEj1KackgKqGvceDWL3f1cJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 11:38 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Fri, Jun 09, 2017 at 10:48:13PM +0200, Arnd Bergmann wrote:
>> On Fri, Jun 9, 2017 at 10:15 PM, John Stultz <john.stultz@linaro.org> wrote:
>> > On Fri, Jun 9, 2017 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> On Fri, Jun 9, 2017 at 5:46 PM, Daniel Lezcano
>> >> <daniel.lezcano@linaro.org> wrote:
>> >>
>> >> Yes, but I'm not sure this is the right patch either. We tend to not
>> >> use 'select' for user-visible drivers, and most hisilicon platforms
>> >> won't need this driver.
>> >>
>> >> I think it would be more consistent to add this to the defconfig
>> >> and regard it as a user error when the driver is disabled on a
>> >> machine that needs it.
>> >
>> > Maybe the select is not exactly in the right place, but I don't really
>> > feel like a pmic on an SoC is a "user-visible driver". I deal with the
>> > board often and when the new dependency was made on the clk, I would
>> > have never have found it on my own w/o Ulf and Daniel pointing out
>> > what I needed to enable.
>>
>> What I meant is that the Kconfig option is user-visible. On a very high
>> level, this is a result of arch/arm64/Kconfig.platforms listing only
>> very broad categories of SoCs, in many cases only the manufacturers
>> of very different chip families, which then control the visibility of the
>> individual Kconfig items for things like pinctrl or clk.
>>
>> I now see that MFD_HI655X_PMIC is the top-level driver that you
>> have to select before enabling COMMON_CLK_HI655X, so the
>> patch is actually broken unless it actually selects both.
>>
>> How about simply adding a 'default MFD_HI655X_PMIC' to
>> COMMON_CLK_HI655X to enable it unless it is explicitly
>> turned off?
>
> Actually, I share John's opinion.
>
> Ideally when we choose a platform, all the relevants devices configuration
> options should be selected automatically from a single topmost node of a tree
> (platform selection) to all the nodes corresponding to the devices, leaving the
> user to select one simple option without knowledge of the SoC hardware
> internals.
>
> If the user is expert in the platform and knows exactly what he does, then he
> can select an _EXPERT_ like option and be able to disable some drivers.
>
> It is how I tend to write the Kconfig options, so the 'default MFD_HI655X_PMIC'
> is confusing for me. Wouldn't make sense to select COMMON_CLK_HI655X when
> MFD_HI655X_PMIC is enabled?

I don't think it's that easy. When you do that, MFD_HI655X_PMIC gains
a dependency on COMMON_CLK and will again cause a warning on
machines that disable that during compile testing.

Using 'select' for user-selectable options generally leads to problems,
and you are better off avoiding it. If you want to make the symbol impossible
to turn off for non-EXPERT configurations, you can write it like

config COMMON_CLK_HI655X
        tristate "Clock driver for Hi655x" if EXPERT
        depends on (MFD_HI655X_PMIC || COMPILE_TEST)
        depends on REGMAP
        default MFD_HI655X_PMIC

That way the option is completely hidden for non-EXPERT,
but still has the right default otherwise, and the dependencies
are tracked right for compile-testing.

     Arnd
