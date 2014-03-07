From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 07 Mar 2014 16:20:44 +0100
Subject: [PATCH v3 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <CAPdUM4Of1ZxWysqHaDMqrNUKzXAvEMnWfgz9yBdHVTXpqEqsyA@mail.gmail.com>
References: <1392724570-27977-1-git-send-email-rahul.sharma@samsung.com>	<1392724570-27977-6-git-send-email-rahul.sharma@samsung.com>	<53095A9A.4080606@gmail.com>	<CAPdUM4PL9p-fNaim_YFFMV_bA4higxQa6ppSNUGg5nmMc7a6Mw@mail.gmail.com>	<5315C2CA.60206@gmail.com>
 <CAPdUM4Of1ZxWysqHaDMqrNUKzXAvEMnWfgz9yBdHVTXpqEqsyA@mail.gmail.com>
Message-ID: <5319E3CC.3050802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.03.2014 09:47, Rahul Sharma wrote:
> Hi Tomasz,
>
> On 4 March 2014 17:40, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Rahul,
>>
>>
>> On 04.03.2014 05:14, Rahul Sharma wrote:
>>>
>>> On 23 February 2014 07:49, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>>
>>>> On 18.02.2014 12:56, Rahul Sharma wrote:
>>>>>
>>>>> +/*
>>>>> + * List of parent clocks for muses in CMU_DISP
>>>>> +*/
>>>>> +PNAME(mout_phyclk_dptx_phy_ch3_txd_clk_user_p) = {"fin_pll",
>>>>> +                       "phyclk_dptx_phy_ch3_txd_clk"};
>>>>> +PNAME(mout_phyclk_dptx_phy_ch2_txd_clk_user_p) = {"fin_pll",
>>>>> +                       "phyclk_dptx_phy_ch2_txd_clk"};
>>>>> +PNAME(mout_phyclk_dptx_phy_ch1_txd_clk_user_p) = {"fin_pll",
>>>>> +                       "phyclk_dptx_phy_ch1_txd_clk"};
>>>>> +PNAME(mout_phyclk_dptx_phy_ch0_txd_clk_user_p) = {"fin_pll",
>>>>> +                       "phyclk_dptx_phy_ch0_txd_clk"};
>>>>
>>>>
>>>>
>>>> Whoa, these clock names are incredibly long. Are they real names from SoC
>>>> User's Manual?
>>>>
>>> Yea, these are same in manual. I kept the name similar, otherwise not easy
>>> to
>>> search them in UM.
>>>
>>
>> OK.
>>
>>
>>>>
>>>>> +
>>>>> +PNAME(mout_aclk_disp_222_user_p) = {"fin_pll", "dout_aclk_disp_222"};
>>>>> +PNAME(mout_sclk_disp_pixel_user_p) = {"fin_pll",
>>>>> "dout_sclk_disp_pixel"};
>>>>
>>>>
>>>>
>>>> [snip]
>>>>
>>>>
>>>>> +/* fixed rate clocks generated outside the soc */
>>>>
>>>>
>>>>
>>>> Huh? If they are generated outside the SoC, they shouldn't be registered
>>>> by
>>>> this driver, but rather by respective fixed rate clock nodes in DT.
>>>
>>>
>>> I tried but system doesn't boot if fin_plll is registered from DT as
>>> "fixed-clock".
>>> of_fixed_clk_setup hits after the registration of other CMUs. System
>>> asserts
>>> in many places due to div by zero error. It is exactly same for
>>> Exynos5420.
>>> So I took 5420 as example and defined fin_pll as osc clock of compatible
>>> type
>>> "samsung,exynos5260-oscclk". Rest of the ext clocks are registered as
>>> "fixed-clock". What you say on this ?
>>>
>>
>> Hmm, the common clock framework is designed to account for late registration
>> of parent clocks. Fixed rate clocks defined from DT seem to work fine for
>> S3C64xx and Exynos5410 (patches posted some time ago by Tarek Dakhran). I'm
>> not sure why it doesn't work for you.
>>
>>
>>>>> +       FRATE(ID_NONE, "phyclk_hdmi_link_o_tmds_clkhi", NULL,
>>>>> +                       CLK_IS_ROOT, 125000000),
>>>>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_txbyteclkhs", NULL,
>>>>> +                       CLK_IS_ROOT, 187500000),
>>>>> +       FRATE(ID_NONE, "phyclk_dptx_phy_o_ref_clk_24m", NULL,
>>>>> +                       CLK_IS_ROOT, 24000000),
>>>>> +       FRATE(ID_NONE, "phyclk_dptx_phy_clk_div2", NULL,
>>>>> +                       CLK_IS_ROOT, 135000000),
>>>>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_rxclkesc0", NULL,
>>>>> +                       CLK_IS_ROOT, 20000000),
>>>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_phyclock", NULL,
>>>>> +                       CLK_IS_ROOT, 60000000),
>>>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_freeclk", NULL,
>>>>> +                       CLK_IS_ROOT, 60000000),
>>>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_clk48mohci", NULL,
>>>>> +                       CLK_IS_ROOT, 48000000),
>>>>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_pipe_pclk", NULL,
>>>>> +                       CLK_IS_ROOT, 125000000),
>>>>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_phyclock", NULL,
>>>>> +                       CLK_IS_ROOT, 60000000),
>>>>
>>>>
>>>>
>>>> Are these really fixed rate clocks? It looks strange, because it's a bit
>>>> unlike previous Samsung SoCs, which used to have up 5 fixed rate clocks
>>>> in
>>>> average.
>>>>
>>>
>>> These are outputs of various phys. If these are removed we will be left
>>> with
>>> many orphan clocks.
>>>
>>
>> OK. Just wanted to make sure that they are real clocks found in the SoC, as
>> I don't have access to Exynos 5420 datasheet yet.
>>
>>
>>>>> +};
>>>>> +
>>>>> +/*
>>>>> + * List of Gate clocks for CMU_DISP
>>>>> +*/
>>>>> +struct samsung_gate_clock exynos5260_disp_gate_clks[] __initdata = {
>>>>> +       GATE(DISP_CLK_SMMU_TV, "clk_smmu3_tv",
>>>>> "mout_aclk_disp_222_user",
>>>>> +                       EN_IP_DISP, 25, 0, 0),
>>>>> +       GATE(DISP_CLK_SMMU_FIMD1M1, "clk_smmu3_fimd1m1",
>>>>> +                       "mout_aclk_disp_222_user",
>>>>> +                       EN_IP_DISP, 23, 0, 0),
>>>>> +       GATE(DISP_CLK_SMMU_FIMD1M0, "clk_smmu3_fimd1m0",
>>>>> +                       "mout_aclk_disp_222_user",
>>>>> +                       EN_IP_DISP, 22, 0, 0),
>>>>> +       GATE(ID_NONE, "clk_pixel_mixer", "mout_aclk_disp_222_user",
>>>>> +                       EN_IP_DISP, 13, CLK_IGNORE_UNUSED, 0),
>>>>> +       GATE(ID_NONE, "clk_pixel_disp", "mout_aclk_disp_222_user",
>>>>> +                       EN_IP_DISP, 12, CLK_IGNORE_UNUSED, 0),
>>>>
>>>>
>>>>
>>>> Why CLK_IGNORE_UNUSED?
>>>
>>>
>>> these clocks are required for correct representation of clock tree but
>>> they are
>>> not enabled by the drivers. like sclk_uart clock is only used for set rate
>>> and
>>> never enable by the driver. Second category is clock like lpddr which will
>>> be
>>> used by mif dvfs for lpddr only. These needs to left ingnored for Non
>>> lpddr
>>> boards. I treid to kept them to minimum.
>>>
>>
>> It's OK for core system peripherals, such as lpddr, monocnt, mif, drex,
>> intmem, etc. I'm not sure about the two display clocks. Respective drivers
>> should be fixed to gate them correctly, but for now maybe it's OK to keep
>> them enabled. However I believe it's wrong for sclk_uart's.
>>
>> Looking at the code, Samsung serial driver enables selected baud clock
>> properly, so I don't see any reason why sclk_uart clocks should have this
>> flag set. Are you sure you have correct clock look-up in your DT?
>>
>
> I checked. sclk_uart is enabled properly by serial driver. But for some reason,
> if I remove INGNORE flag, system throws "imprecise external abort (0x1406) at
> 0x00000000".
>
>      1.870000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> [    1.870000] Internal error: : 1406 [#1] SMP ARM
> [    1.870000] Modules linked in:
> [    1.870000] CPU: 0 PID: 72 Comm: init Not tainted 3.14.0-rc4+ #49
> [    1.870000] task: ed81d140 ti: ed84e000 task.ti: ed84e000
> [    1.870000] PC is at s3c64xx_serial_startup+0xa8/0xbc
> [    1.870000] LR is at _raw_spin_unlock+0x18/0x1c
> [    1.870000] ffa0: c000e280 c00fec14 01797b29 00000005 01797b29
> 00020802 00000000 00000000
> [    1.870000] ffc0: 01797b29 00000005 00000802 00000005 01797b29
> 00000000 b6eed000 00000000
> [    1.870000] ffe0: 000a23f4 be969c08 0006d780 b6e706c4 60000010
> 01797b29 e7f7fb3f ffffffff
> [    1.870000] [<c027ecdc>] (s3c64xx_serial_startup) from [<c02790b0>]
> (uart_startup.part.3+0x78/0x1a0)
> [    1.870000] [<c02790b0>] (uart_startup.part.3) from [<c0279bb0>]
> (uart_open+0xe4/0x13c)
> [    1.870000] [<c0279bb0>] (uart_open) from [<c025f120>] (tty_open+0x39c/0x544)
> [    1.870000] [<c025f120>] (tty_open) from [<c01034fc>]
> (chrdev_open+0x140/0x16c)
> [    1.870000] [<c01034fc>] (chrdev_open) from [<c00fd598>]
> (do_dentry_open+0x1c4/0x284)
> [    1.870000] [<c00fd598>] (do_dentry_open) from [<c00fd964>]
> (finish_open+0x48/0x5c)
> [    1.870000] [<c00fd964>] (finish_open) from [<c010cbe0>]
> (do_last.isra.19+0x958/0xb44)
>
> But it is completely fine with sclk_uartX are declared with IGNORE
> flag. I am not
> able to find any clue at software level. Probably we can accept Uart clocks with
> this flag for exynos5260.

This looks to me like masking a bug somewhere else. I don't think this 
is a good idea, because such bug forgotten may strike again later with 
worse and hard to debug effects. I'd insist on fixing it instead.

> I have already posted V4 for this series where I addressed most of
> your review comments.
> Please review.

Well, you have not addressed the comment about using generic fixed rate 
clock bindings. The old vendor-specific bindings are deprecated and must 
not be used anymore by new code. Please fix it.

I'll see how v4 looks, though.

Best regards,
Tomasz
