From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 5 Nov 2018 17:44:22 +0100
Subject: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
In-Reply-To: <8A3A1316-DC7F-4C5A-9DD8-C115EBB613BB@gmail.com>
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
 <20181013160810.88481.14237@resonance>
 <ed6a889eeec4e2809f0840c9e8188b5e4b24fa76.camel@baylibre.com>
 <8A3A1316-DC7F-4C5A-9DD8-C115EBB613BB@gmail.com>
Message-ID: <2fe1510e-13b0-cc3a-a079-e786c5c6beef@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2018 06:54, Christian Hewitt wrote:
> On 15 Oct 2018, at 9:07 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> On Sat, 2018-10-13 at 18:08 +0200, Michael Turquette wrote:
>>> Quoting Christian Hewitt (2018-10-13 12:04:46)
>>>> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
>>>> with reboot; e.g. a ~60 second delay between issuing reboot and the
>>>> board power cycling (and in some OS configurations reboot will fail
>>>> and require manual power cycling).
>>>>
>>>> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
>>>> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
>>>> Co-Processor seems to depend on FCLK_DIV3 being operational.
>>>>
>>>> Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
>>>> meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
>>>> bad commit. This added support for the missing clock gates before the
>>>> fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
>>>> disabled all the unused fixed dividers, thus it disabled a critical
>>>> clock path for the SCPI Co-Processor.
>>>>
>>>> This change simply sets the FCLK_DIV3 gate as critical to ensure
>>>> nothing can disable it.
>>>

[...]

>>
>> Christian, is Ok if I amend your patch, or do you prefer to post a v2 ?
>> Mike, with explained, is this change OK with you ?
> 
> I?m happy for you to amend, it?s easier for me.
> Christian

Gentle ping, could this go into 4.20 fixes ?

Thanks,
Neil

> 
>>>
>>> Regards,
>>> Mike
>>>
>>>>
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> ---
>>>> drivers/clk/meson/gxbb.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>>>> index 86d3ae5..4c8925d 100644
>>>> --- a/drivers/clk/meson/gxbb.c
>>>> +++ b/drivers/clk/meson/gxbb.c
>>>> @@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div = {
>>>>                .ops = &clk_fixed_factor_ops,
>>>>                .parent_names = (const char *[]){ "fixed_pll" },
>>>>                .num_parents = 1,
>>>> +               .flags = CLK_IS_CRITICAL,
>>>>        },
>>>> };
>>>>
>>>> -- 
>>>> 2.7.4
> 
