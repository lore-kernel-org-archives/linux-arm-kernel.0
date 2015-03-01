From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 1 Mar 2015 21:54:09 +0900
Subject: [PATCH] clk: samsung: Add CLKOUT driver support for Exynos3250
 SoC.
In-Reply-To: <20150225191312.303ba10d@songinha-Samsung-DeskTop-System>
References: <1424769751-4633-1-git-send-email-ideal.song@samsung.com>
 <CA+Ln22Hb9vx707=smWZwGqc9-JuSYvQ_dPcRbpPFZOF=ZgzUbQ@mail.gmail.com>
 <20150225191312.303ba10d@songinha-Samsung-DeskTop-System>
Message-ID: <CA+Ln22EAGDBa9ZJYGyKYqNzsTTb6QYGKA7bbGq7ZBoh8Y0-x_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-25 19:13 GMT+09:00 Inha Song <ideal.song@samsung.com>:
> Hi, Tomasz,
>
> Thanks for you comment :)
>
> On Wed, 25 Feb 2015 09:54:02 +0900
> Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>> Hi Inha,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> 2015-02-24 18:22 GMT+09:00 Inha Song <ideal.song@samsung.com>:
>> > This patch add CLKOUT driver support for Exynos3250 SoC.
>>
>> Could you please add a little more information? I know that it might
>> be pretty obvious to people familiar with this driver and/or hardware,
>> but it might be a good idea to explicitly say that the CLKOUT
>> controller is compatible with Exynos4, so only a new compatible string
>> is added.
>>
>> On the other hand, do you really need to add a new compatible string
>> if an existing one can be reused? The reason why the DT property is
>> called "compatible" is to be able to use the same compatible strings
>> on different devices, because they are compatible, even though the
>> string might have its name after only one of them. If there is some
>> additional reason to add a new compatible string, please write this in
>> commit message.
>
> In in PMU document(Document/devicetree/bindgins/arm/samsung/pmu.txt),
> "samsung,exynos3250-pmu" compatible string had been added.
>
> So I add this compatible in driver.
>

Ah, right, the whole PMU block is not compatible with Exynos4, so a
new compatible string is needed indeed. It should be said in patch
description, though.

>>
>> >
>> > Signed-off-by: Inha Song <ideal.song@samsung.com>
>> > ---
>> >  drivers/clk/samsung/clk-exynos-clkout.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
>> > index 3a7cb25..1c02e73 100644
>> > --- a/drivers/clk/samsung/clk-exynos-clkout.c
>> > +++ b/drivers/clk/samsung/clk-exynos-clkout.c
>> > @@ -142,6 +142,8 @@ CLK_OF_DECLARE(exynos4212_clkout, "samsung,exynos4212-pmu",
>> >                 exynos4_clkout_init);
>> >  CLK_OF_DECLARE(exynos4412_clkout, "samsung,exynos4412-pmu",
>> >                 exynos4_clkout_init);
>> > +CLK_OF_DECLARE(exynos3250_clkout, "samsung,exynos3250-pmu",
>> > +               exynos4_clkout_init);
>>
>> Are you sure that the PMU DEBUG register on Exynos3250 is indeed
>> compatible with Exynos4 and not with newer SoCs? AFAIR, the only
>> difference was the number of bits (4 on Exynos4 and 5 on Exynos5?) of
>> the main mux.
>
> Exynos3250 PMU_DEBUG register is same with Exynos4. So I just use exynos4_clkout_init function.
> But, on second thought, It looks good to add exynos3_clkout_init function for Exynos3 SoC even though it's the same with exynos4_clkout_init.
>
> what is your opinion?

Well, if there is no need then I don't see any reason why having a
separate function doing the same things could have any benefits. If
some differences are discovered in future it can be always modified in
a separate patch.

Best regards,
Tomasz
