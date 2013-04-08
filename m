From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Apr 2013 15:16:01 +0200
Subject: [PATCH 1/3] clk: exynos: register audio subsystem clocks using
 common clock framework
In-Reply-To: <CAAgF-Bcpaef_uTWjw6or_uonFN9HU=xSEhxFFTyiA+mu+7iYpw@mail.gmail.com>
References: <1365143029-16936-1-git-send-email-padma.v@samsung.com>
 <515ED757.9070708@samsung.com>
 <CAAgF-Bcpaef_uTWjw6or_uonFN9HU=xSEhxFFTyiA+mu+7iYpw@mail.gmail.com>
Message-ID: <5162C311.4050706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/06/2013 12:13 PM, Padma Venkat wrote:
> On Fri, Apr 5, 2013 at 7:23 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 04/05/2013 08:23 AM, Padmavathi Venna wrote:
>>> Audio subsystem is introduced in exynos platforms. This has seperate
>>> clock controller which can control i2s0 and pcm0 clocks. This patch
>>> registers the audio subsystem clocks with the common clock framework.
>>>
>>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>>> ---
>>>  drivers/clk/samsung/Makefile           |    1 +
>>>  drivers/clk/samsung/clk-exynos-audss.c |  139 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 140 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/clk/samsung/clk-exynos-audss.c
[...]
>>> diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
>>> new file mode 100644
>>> index 0000000..d7f9aa8
>>> --- /dev/null
>>> +++ b/drivers/clk/samsung/clk-exynos-audss.c
[...]
>>> +/* register exynos_audss clocks */
>>> +void __init exynos_audss_clk_init(struct device_node *np)
>>> +{
>>
>> Isn't it better to just do
>>
>>         if (np == NULL)
>>                 return;
>>
>> i.e. just skip the initialization altogether ? panic() seems
>> unreasonable here.
> 
> Ok. I will change this.
> 
>>
>>> +     if (np) {
>>> +             reg_base = of_iomap(np, 0);
>>> +             if (!reg_base)
>>> +                     panic("%s: failed to map registers\n", __func__);
>>> +     } else
>>> +             panic("%s: unable to determine soc\n", __func__);
>>> +
>>> +     clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>>> +     if (!clk_table)
>>> +             panic("could not allocate clock lookup table\n");
>>> +
>>> +     clk_data.clks = clk_table;
>>> +     clk_data.clk_num = nr_clks;
>>> +     of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>>> +
>>> +     clk_table[mout_audss] = clk_register_mux(NULL, "mout_audss",
>>> +                             mout_audss_p, ARRAY_SIZE(mout_audss_p), 0,
>>> +                             reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
>>> +     clk_register_clkdev(clk_table[mout_audss], "mout_audss", NULL);
>>> +
>>> +     clk_table[mout_i2s] = clk_register_mux(NULL, "mout_i2s", mout_i2s_p,
>>> +                             ARRAY_SIZE(mout_i2s_p), 0,
>>> +                             reg_base + ASS_CLK_SRC, 2, 2, 0, &lock);
>>> +     clk_register_clkdev(clk_table[mout_i2s], "mout_i2s", NULL);
>>> +
>>> +     clk_table[dout_srp] = clk_register_divider(NULL, "dout_srp",
>>> +                             "mout_audss", 0, reg_base + ASS_CLK_DIV, 0, 4,
>>> +                             0, &lock);
>>> +
>>> +     clk_table[dout_bus] = clk_register_divider(NULL, "dout_bus",
>>> +                             "dout_srp", 0, reg_base + ASS_CLK_DIV, 4, 4, 0,
>>> +                             &lock);
>>> +
>>> +     clk_table[dout_i2s] = clk_register_divider(NULL, "dout_i2s",
>>> +                             "mout_i2s", 0, reg_base + ASS_CLK_DIV, 8, 4, 0,
>>> +                             &lock);
>>> +
>>> +     clk_table[srp_clk] = clk_register_gate(NULL, "srp_clk", "dout_srp",
>>> +                             CLK_SET_RATE_PARENT, reg_base + ASS_CLK_GATE, 0,
>>> +                             0, &lock);
>>> +
>>> +     clk_table[i2s_bus] = clk_register_gate(NULL, "i2s_bus", "dout_bus",
>>> +                             CLK_SET_RATE_PARENT, reg_base + ASS_CLK_GATE, 2,
>>
>> Don't we need to handle also bit 3 of the ASS_CLK_GATE register ?
> 
> Bit 3 is handled below as sclk_i2s0.

Oops, sorry, my fault.

>> In some kernels I saw PCM special/PCM Bus and I2S special/I2S Bus bits
>> associated with same clocks. So there were 2-bit wide masks for each clock.
>>
>> Tomasz had an idea to add a flag to the clock framework that would be passed
>> to clk_register_gate() and would indicate that the sixth argument is a bitmask,
>> rather than a bit index.
> 
> For I2S there are separate clock instances and bits in the clock
> controller named as busclk[bit:2] and i2s_clk[bit:3].

Indeed.

> But PCM case there are two bits available[bit 4 and 5] but I think
> only one clock instance available(need to check
> clk controller diagram). But anyway having the bitmask in the
> clk_register_gate may be useful.

Yes, from the diagram there seems to be only one clock (SCLK_PCM0) but there 
are 2 in the clock gate register (PCM Special, PCM bus). I guess it's best to
describe those as 2 clocks, and handle them in the driver this way. Instead 
of merging presumably two separate physical clocks in a single clock object.

I suppose "PCM Special" (SCLK_PCMx) is only shown on the Audio Subsystem
diagrams, since it's mostly related to the sound data flow. And the PCM bus
is the PCM IP block bus clock, which is important for inter-working of the
PCM bus with rest of the system.

One option would be to provide a dummy clock for the second PCM clock, for 
systems where it is not available. So the driver always handles two clocks.

>> Perhaps we could just specify each bit of ASS_CLK_GATE as a separate clock.
>> Then the drivers would need to be modified. I'm not sure what's best approach.
>> And if it is really necessary to be enabling/disabling both special/bus clock
>> gate bits simultaneously. I'm adding Mike to Cc, so perhaps he could provide
>> us with some pointers.
>>
>>> +                             0, &lock);
>>> +
>>> +     clk_table[sclk_i2s0] = clk_register_gate(NULL, "sclk_i2s0", "dout_i2s",
>>> +                             CLK_SET_RATE_PARENT, reg_base + ASS_CLK_GATE, 3,
>>> +                             0, &lock);
>>> +#ifdef CONFIG_PM_SLEEP
>>> +     register_syscore_ops(&exynos_audss_clk_syscore_ops);
>>> +#endif
>>> +     pr_info("Exynos: Audss: clock setup completed\n");
>>> +}
>>> +CLK_OF_DECLARE(exynos_audss_clk, "samsung,exynos-audss-clock", exynos_audss_clk_init);
>>
>>
>> [1] http://www.spinics.net/lists/linux-kbuild/msg07616.html

Regards,
Sylwester
