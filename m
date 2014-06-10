From: shaik.samsung@gmail.com (Shaik Ameer Basha)
Date: Tue, 10 Jun 2014 12:18:33 +0530
Subject: exynos5420-peach-pi: linux-next boot fails unless mau_epll left
 enabled?
In-Reply-To: <CAGa+x86ko1N+T+QAqnY+md4+nyzza_cDt0wa-s06TdCX+27fSA@mail.gmail.com>
References: <7hoay6sxjl.fsf@paris.lan>
 <CAGa+x86ko1N+T+QAqnY+md4+nyzza_cDt0wa-s06TdCX+27fSA@mail.gmail.com>
Message-ID: <CAOD6ATpZWEg9d7WnZ8tg9_uQJ29vMoucaOwh0_tbdRSDRj25cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

We tested on 3 "peach-pi" boards. We are not observing this issue.

Even I tried with the below defconfig mentioned by you. No issues observed.
https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/eclass/cros-kernel/exynos5_defconfig

This is the u-boot version currently we are using.
U-Boot 2013.04 (Feb 13 2014 - 16:35:03) for Peach

Can you provide us more inputs like uboot version or any extra patches
you applied?
Also try removing all power domain nodes from exynos5420.dtsi and
check whether it is reproduced.

Regards,
Shaik Ameer Basha



On Tue, Jun 10, 2014 at 3:21 AM, Kevin Hilman <khilman@linaro.org> wrote:
> ping for any Samsung folks that might be able to explain this.
>
> On Thu, Jun 5, 2014 at 5:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> Hello,
>>
>> I'm trying to boot next-20140605[1] on my recently arrived Chromebook2
>> (peach-pi) and was not getting to userspace.  Comparing notes with Doug
>> Anderson, his was booting just fine, so after some debugging and adding
>> 'clk_ignore_unused' to the command-line, it started booting fine.
>>
>> So then, I tracked it down to which clock was causing the problems and
>> found that it's the mau_epll clock gating that's causing the problem,
>> and leaving it enabled[1] allows me to boot again.
>>
>> Any ideas what's going on here?
>>
>> And in particular, any ideas why it would affect my board and not other
>> boards like Doug's?
>>
>> Thanks,
>>
>> Kevin
>>
>> [1] Using this defconfig:
>> https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/eclass/cros-kernel/exynos5_defconfig
>>
>> [2]
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c
>> b/drivers/clk/samsung/clk-exynos5420.c
>> index 61eccf0dd72f..ed175088ee7e 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -911,7 +911,7 @@ static struct samsung_gate_clock
>> exynos5x_gate_clks[] __initdata = {
>>                         SRC_MASK_TOP2, 24, 0, 0),
>>
>>         GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
>> -                       SRC_MASK_TOP7, 20, 0, 0),
>> +                       SRC_MASK_TOP7, 20, CLK_IGNORE_UNUSED, 0),
>>
>>         /* sclk */
>>         GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
