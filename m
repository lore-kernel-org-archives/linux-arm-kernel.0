From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Tue, 17 Dec 2013 13:51:13 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Add exynos5420 cpufreq driver
In-Reply-To: <20131217091456.1af748c3@amdc2363>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
 <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
 <20131209092324.1f8b6502@amdc2363>
 <CALt3h7-25_mW5SnnTbZWjoF0pOZxsU5Gg6FqOdoz1MgdH7gm5w@mail.gmail.com>
 <20131210173208.5083aa1f@amdc2363>
 <CABb+yY0C50va5UAgv5QKGKK6qE1wiDwcUmn54CC7PVQ8vpoEmg@mail.gmail.com>
 <20131217091456.1af748c3@amdc2363>
Message-ID: <CALt3h78Zoabm+1kDNrEEyQ_Nshi2yOFd57NwOq6zTnVijfngJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Tue, Dec 17, 2013 at 1:44 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Jassi,
>
>> On Tue, Dec 10, 2013 at 10:02 PM, Lukasz Majewski
>> <l.majewski@samsung.com> wrote:
>> >>
>> >> Actually these values are not for PLL, but for the dividers.
>> >> If you see below, the PLL rate setting is done through
>> >> clk_set_rate() going via CCF. But I found an issue if the divider
>> >> values are set via clk_set_rate API.
>> >> What I found is, the system goes into freeze if all the divider
>> >> values are not set in one shot. So we cannot call multiple
>> >> clk_set_rate()'s on each divider. Thats why I continued with
>> >> non-CCF way of setting the divider.
>> >
>> > I see. I'm not an expert on common clock framework (CCF), but for me
>> > conceptually clock dividers setting shall be handled by CCF.
>> >
>> > However, I've poked a bit at CCF. There isn't any out of the box
>> > solutions available.
>> >
>> > A "virtual" clock can be defined and inside its implementation we
>> > can atomically set dividers. Another solution would be to hack the
>> > current CCF to provide atomic clock operations
>> >
>> CCF isn't only for clocks that have single divider or gate control
>> register. One could define a clock that manipulates more than one
>> divider/gate in one CCF callback. It is already abstract enough. So
>> implementing a virtual clock is the solution, imho.
>
> Thanks for sharing your experience.
>
>>  BTW, on my platform linux needs to send a 'non-atomic' IPC message to
>> a master co-processor to scale up/down cpufreq. I just define a
>> virtual clock and use the generic bL cpufreq driver
>> drivers/cpufreq/arm_big_little.c
>
> My use case is simpler - cpufreq-cpu0.c or arm_bit_little.c (for bL)
> driver with maybe two virtual clocks to handle divider's update.
>

Is it very simple where 5 different dividers with different divider ratios have
to be set in one shot. Our clk_set_rate() API as such takes only one freq rate
argument. How do you think to combine say 5 divider rates?

Regards
Arun
