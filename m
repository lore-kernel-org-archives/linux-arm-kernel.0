From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 7 Apr 2015 20:08:57 +0530
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <5523E5A9.4080302@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
 <551AFCCE.4050404@collabora.co.uk> <551BD07E.2090506@samsung.com>
 <551BDA0A.7010704@collabora.co.uk> <551C2B6D.4010001@samsung.com>
 <551C71A5.1070903@collabora.co.uk>
 <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
 <5523B878.8040304@collabora.co.uk>
 <5523C5F5.6000604@collabora.co.uk>
 <CA+Ln22FrvQQ_pX7ELG-jYriGkQHmtX3aUHYqsc_-CRXcc4zxbg@mail.gmail.com>
 <5523E5A9.4080302@collabora.co.uk>
Message-ID: <CAM4voamV-TcyqXSu7_HeQvd2aEUXpkjbJ14Otb_MLFMEO_1Vbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, Apr 7, 2015 at 7:41 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Tomasz,
>
> On 04/07/2015 02:46 PM, Tomasz Figa wrote:
>> 2015-04-07 13:56 GMT+02:00 Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk>:
>>> So I disabled the sss clock before trying a S2R:
>>>
>>> # devmem 0x10018800 32 0xFFFFFFFB
>>> (CLK_SSS in CLK_GATE_IP_G2D is gated)
>>>
>>> and S2R worked anyways but I see that CLK_GATE_IP_G2D is reset to
>>> its default value on S2R so maybe that is why it works anyways?
>>
>> Does the driver restore its value on resume (i.e. has it in the
>> save/restore array)? Remember that suspend causes all clock registers
>> to be reset. Then some of them will be configured by the lowest
>
> No, GATE_IP_G2D is not in the exynos5x_gate_clks array so it looses
> the kernel after a suspend/resume cycle.
>
>> bootloader stage after wake-up reset, but the kernel needs to restore
>> all of them.
>>
>
> I see, thanks for the clarification. Then I think that is a bug and
> GATE_IP_G2D needs to be added to the list of clocks to be saved and
> restored right? That's a separate issue from our current S2R problem
> though so it can be done later as a separate patch.
>
>>>
>>> # devmem 0x10018800
>>> 0xFFFFFFFF (all CLK_GATE_IP_G2D clocks enabled including CLK_SSS)
>>>
>>> Does this shed any more light? Could the problem be that the sss
>>> clock parent (aclk266_g2d) is gated during S2R? Is the SSS module
>>> required for S2R or is just that CLK_SSS prevents the parent to
>>> be gated and so it is another red herring?
>>
>> Does the board use secure firmware? If yes, it might require to do
>> some encryption on suspend, so if the firmware is broken and doesn't
>> control the clock itself, it might need the SSS clock to be running,
>> when the SLEEP SMC operation is called.
>>
>
> No, the Chromebooks don't use secure firmware AFAIK.
>
>> Anyway, I just realized that Exynos4 also need several clocks to be
>> ungated on suspend and this is handled by code [1] based on arrays
>> [2].
>>
>> [1] http://lxr.free-electrons.com/source/drivers/clk/samsung/clk-exynos4.c#L309
>> [2] http://lxr.free-electrons.com/source/drivers/clk/samsung/clk-exynos4.c#L276
>>
>
> Yes I noticed that the Exynos5420 driver also does the same but did not
> want to do it there because I didn't know what value should had been used
> for all the other clocks in the CLK_GATE_BUS_TOP register. But if I get
> your explanation right, it is safe to do so since the register is going to
> be reset to its default values anyways.
>
>> Could this method work for your case as well? There would be no need
>> to call any clock API at all, just low level register writes, which is
>> okay, since this is a low level driver anyway.
>>
>
> Yes, the following patch [0] is enough to make S2R working. If you think
> that is correct then I'll post it as a proper patch then.
>
>> Best regards,
>> Tomasz
>>
>
> Best regards,
> Javier
>
> [0]
> From 78aa551ebcb9a4a7ae9d5581c33e0c0f19fe5ad6 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Date: Tue, 7 Apr 2015 15:53:27 +0200
> Subject: [RFC PATCH] clk: exynos5420: Restore GATE_BUS_TOP on suspend
>
> Commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power
> Management support v12") added pm support for the pl330 dma driver but
> it makes the clock for the Exynos5420 MDMA0 DMA controller to be gated
> during suspend and this in turn makes its parent clock aclk266_g2d to
> be gated. But the clock needs to be ungated prior suspend to allow the
> system to be suspend and resumed correctly.
>
> Add GATE_BUS_TOP register to the list of registers to be restored when
> the system enters into a suspend state so aclk266_g2d will be ungated.
>
> Thanks to Abhilash Kesavan for figuring out that this was the issue.
>
> Fixes: ae43b32 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 07d666cc6a29..bea4a173eef5 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -271,6 +271,7 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
>         { .offset = SRC_MASK_PERIC0,            .value = 0x11111110, },
>         { .offset = SRC_MASK_PERIC1,            .value = 0x11111100, },
>         { .offset = SRC_MASK_ISP,               .value = 0x11111000, },
> +       { .offset = GATE_BUS_TOP,               .value = 0xffffffff, },
>         { .offset = GATE_BUS_DISP1,             .value = 0xffffffff, },
>         { .offset = GATE_IP_PERIC,              .value = 0xffffffff, },
>  };

While there could be a concern that we are ungating all the clocks in
BUS_TOP, this looks like the least intrusive fix for the issue. Tested
this on Peach Pi, S2R works fine.

Thanks,
Abhilash
