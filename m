From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 04 Mar 2014 13:10:50 +0100
Subject: [PATCH v3 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <CAPdUM4PL9p-fNaim_YFFMV_bA4higxQa6ppSNUGg5nmMc7a6Mw@mail.gmail.com>
References: <1392724570-27977-1-git-send-email-rahul.sharma@samsung.com>	<1392724570-27977-6-git-send-email-rahul.sharma@samsung.com>	<53095A9A.4080606@gmail.com>
 <CAPdUM4PL9p-fNaim_YFFMV_bA4higxQa6ppSNUGg5nmMc7a6Mw@mail.gmail.com>
Message-ID: <5315C2CA.60206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 04.03.2014 05:14, Rahul Sharma wrote:
> On 23 February 2014 07:49, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On 18.02.2014 12:56, Rahul Sharma wrote:
>>> +/*
>>> + * List of parent clocks for muses in CMU_DISP
>>> +*/
>>> +PNAME(mout_phyclk_dptx_phy_ch3_txd_clk_user_p) = {"fin_pll",
>>> +                       "phyclk_dptx_phy_ch3_txd_clk"};
>>> +PNAME(mout_phyclk_dptx_phy_ch2_txd_clk_user_p) = {"fin_pll",
>>> +                       "phyclk_dptx_phy_ch2_txd_clk"};
>>> +PNAME(mout_phyclk_dptx_phy_ch1_txd_clk_user_p) = {"fin_pll",
>>> +                       "phyclk_dptx_phy_ch1_txd_clk"};
>>> +PNAME(mout_phyclk_dptx_phy_ch0_txd_clk_user_p) = {"fin_pll",
>>> +                       "phyclk_dptx_phy_ch0_txd_clk"};
>>
>>
>> Whoa, these clock names are incredibly long. Are they real names from SoC
>> User's Manual?
>>
> Yea, these are same in manual. I kept the name similar, otherwise not easy to
> search them in UM.
>

OK.

>>
>>> +
>>> +PNAME(mout_aclk_disp_222_user_p) = {"fin_pll", "dout_aclk_disp_222"};
>>> +PNAME(mout_sclk_disp_pixel_user_p) = {"fin_pll", "dout_sclk_disp_pixel"};
>>
>>
>> [snip]
>>
>>
>>> +/* fixed rate clocks generated outside the soc */
>>
>>
>> Huh? If they are generated outside the SoC, they shouldn't be registered by
>> this driver, but rather by respective fixed rate clock nodes in DT.
>
> I tried but system doesn't boot if fin_plll is registered from DT as
> "fixed-clock".
> of_fixed_clk_setup hits after the registration of other CMUs. System asserts
> in many places due to div by zero error. It is exactly same for Exynos5420.
> So I took 5420 as example and defined fin_pll as osc clock of compatible type
> "samsung,exynos5260-oscclk". Rest of the ext clocks are registered as
> "fixed-clock". What you say on this ?
>

Hmm, the common clock framework is designed to account for late 
registration of parent clocks. Fixed rate clocks defined from DT seem to 
work fine for S3C64xx and Exynos5410 (patches posted some time ago by 
Tarek Dakhran). I'm not sure why it doesn't work for you.

>>> +       FRATE(ID_NONE, "phyclk_hdmi_link_o_tmds_clkhi", NULL,
>>> +                       CLK_IS_ROOT, 125000000),
>>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_txbyteclkhs", NULL,
>>> +                       CLK_IS_ROOT, 187500000),
>>> +       FRATE(ID_NONE, "phyclk_dptx_phy_o_ref_clk_24m", NULL,
>>> +                       CLK_IS_ROOT, 24000000),
>>> +       FRATE(ID_NONE, "phyclk_dptx_phy_clk_div2", NULL,
>>> +                       CLK_IS_ROOT, 135000000),
>>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_rxclkesc0", NULL,
>>> +                       CLK_IS_ROOT, 20000000),
>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_phyclock", NULL,
>>> +                       CLK_IS_ROOT, 60000000),
>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_freeclk", NULL,
>>> +                       CLK_IS_ROOT, 60000000),
>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_clk48mohci", NULL,
>>> +                       CLK_IS_ROOT, 48000000),
>>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_pipe_pclk", NULL,
>>> +                       CLK_IS_ROOT, 125000000),
>>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_phyclock", NULL,
>>> +                       CLK_IS_ROOT, 60000000),
>>
>>
>> Are these really fixed rate clocks? It looks strange, because it's a bit
>> unlike previous Samsung SoCs, which used to have up 5 fixed rate clocks in
>> average.
>>
>
> These are outputs of various phys. If these are removed we will be left with
> many orphan clocks.
>

OK. Just wanted to make sure that they are real clocks found in the SoC, 
as I don't have access to Exynos 5420 datasheet yet.

>>> +};
>>> +
>>> +/*
>>> + * List of Gate clocks for CMU_DISP
>>> +*/
>>> +struct samsung_gate_clock exynos5260_disp_gate_clks[] __initdata = {
>>> +       GATE(DISP_CLK_SMMU_TV, "clk_smmu3_tv", "mout_aclk_disp_222_user",
>>> +                       EN_IP_DISP, 25, 0, 0),
>>> +       GATE(DISP_CLK_SMMU_FIMD1M1, "clk_smmu3_fimd1m1",
>>> +                       "mout_aclk_disp_222_user",
>>> +                       EN_IP_DISP, 23, 0, 0),
>>> +       GATE(DISP_CLK_SMMU_FIMD1M0, "clk_smmu3_fimd1m0",
>>> +                       "mout_aclk_disp_222_user",
>>> +                       EN_IP_DISP, 22, 0, 0),
>>> +       GATE(ID_NONE, "clk_pixel_mixer", "mout_aclk_disp_222_user",
>>> +                       EN_IP_DISP, 13, CLK_IGNORE_UNUSED, 0),
>>> +       GATE(ID_NONE, "clk_pixel_disp", "mout_aclk_disp_222_user",
>>> +                       EN_IP_DISP, 12, CLK_IGNORE_UNUSED, 0),
>>
>>
>> Why CLK_IGNORE_UNUSED?
>
> these clocks are required for correct representation of clock tree but they are
> not enabled by the drivers. like sclk_uart clock is only used for set rate and
> never enable by the driver. Second category is clock like lpddr which will be
> used by mif dvfs for lpddr only. These needs to left ingnored for Non lpddr
> boards. I treid to kept them to minimum.
>

It's OK for core system peripherals, such as lpddr, monocnt, mif, drex, 
intmem, etc. I'm not sure about the two display clocks. Respective 
drivers should be fixed to gate them correctly, but for now maybe it's 
OK to keep them enabled. However I believe it's wrong for sclk_uart's.

Looking at the code, Samsung serial driver enables selected baud clock 
properly, so I don't see any reason why sclk_uart clocks should have 
this flag set. Are you sure you have correct clock look-up in your DT?

>>> +
>>> +/*
>>> +* Applicable for all 2550 Type PLLS for Exynos5260, listed below
>>> +* DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL,
>>> +* BUS_PLL, MEDIA_PLL, G3D_PLL.
>>> +*/
>>> +static const struct samsung_pll_rate_table exynos5260_pll2550_24mhz_tbl[]
>>> = {
>>> +       PLL_35XX_RATE(1700000000, 425, 6, 0),
>>> +       PLL_35XX_RATE(1600000000, 200, 3, 0),
>>> +       PLL_35XX_RATE(1500000000, 250, 4, 0),
>>> +       PLL_35XX_RATE(1400000000, 175, 3, 0),
>>> +       PLL_35XX_RATE(1300000000, 325, 6, 0),
>>> +       PLL_35XX_RATE(1200000000, 400, 4, 1),
>>> +       PLL_35XX_RATE(1100000000, 275, 3, 1),
>>> +       PLL_35XX_RATE(1000000000, 250, 3, 1),
>>> +       PLL_35XX_RATE(933000000, 311, 4, 1),
>>> +       PLL_35XX_RATE(900000000, 300, 4, 1),
>>> +       PLL_35XX_RATE(800000000, 200, 3, 1),
>>> +       PLL_35XX_RATE(733000000, 733, 12, 1),
>>> +       PLL_35XX_RATE(700000000, 175, 3, 1),
>>> +       PLL_35XX_RATE(667000000, 667, 12, 1),
>>> +       PLL_35XX_RATE(633000000, 211, 4, 1),
>>> +       PLL_35XX_RATE(620000000, 310, 3, 2),
>>> +       PLL_35XX_RATE(600000000, 400, 4, 2),
>>> +       PLL_35XX_RATE(543000000, 362, 4, 2),
>>> +       PLL_35XX_RATE(533000000, 533, 6, 2),
>>> +       PLL_35XX_RATE(500000000, 250, 3, 2),
>>> +       PLL_35XX_RATE(450000000, 300, 4, 2),
>>> +       PLL_35XX_RATE(400000000, 200, 3, 2),
>>> +       PLL_35XX_RATE(350000000, 175, 3, 2),
>>> +       PLL_35XX_RATE(300000000, 400, 4, 3),
>>> +       PLL_35XX_RATE(266000000, 266, 3, 3),
>>> +       PLL_35XX_RATE(200000000, 200, 3, 3),
>>> +       PLL_35XX_RATE(160000000, 160, 3, 3),
>>
>>
>> Are all of those exact values, without any (incorrect) rounding? This is
>> imporant for the rate setting code to work correctly.
>>
>
> I verfied; all of them are correct other than this:
> PLL_36XX_RATE(394216000, 459, 7, 2, 49282),
>
> Its computed values is coming to be 394073128. I will replace
> 394216000 with 394073128 in the above entry.
>

OK.

>>> +struct of_device_id __clk_of_table_exynos5260[]
>>> +               __used __section(__clk_of_table) = {
>>
>>
>> I don't think this is a good idea. This construct should not be used
>> directly. This is what CLK_OF_DECLARE() macro is for.
>>
>> If you define a struct as mentioned above for every CMU, then you should end
>> up with following code:
>>
>> static const struct exynos5260_cmu_type cmu_xxx = {
>>          // ...
>> };
>>
>> static void __init cmu_xxx_init(struct device_node *np)
>> {
>>          exynos5260_cmu_register_one(np, &cmu_xxx);
>> }
>> CLK_OF_DECLARE(cmu_xxx, "samsung,exynos5260-clock-xxx", cmu_xxx_init);
>>
>
> I will be filling cmu_xxx struct in cmu_xxx_init. I hope that is fine.

Should be fine.

Best regards,
Tomasz
