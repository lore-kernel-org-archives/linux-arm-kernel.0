From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 28 Mar 2017 23:30:52 +0200
Subject: [RFC PATCH] clk: meson: gxbb: remove the "cpu_clk"
In-Reply-To: <m2mvc6d5a3.fsf@baylibre.com>
References: <20170326110602.23379-1-martin.blumenstingl@googlemail.com>
 <1490550707.29739.21.camel@baylibre.com> <m2mvc6d5a3.fsf@baylibre.com>
Message-ID: <CAFBinCBwoXQC3_C6u-3Oqa9c7sbRKq6waN-eRHpZRwKKHSuruA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome, Hi Kevin,

On Mon, Mar 27, 2017 at 6:59 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> On Sun, 2017-03-26 at 13:06 +0200, Martin Blumenstingl wrote:
>>> It seems that the "cpu_clk" was carried over from the meson8b clock
>>> controller driver. On Meson GX (GXBB/GXL/GXM) the registers which are
>>> used by the cpu_clk have a different purpose (in other words: they don't
>>> control the CPU clock anymore). HHI_SYS_CPU_CLK_CNTL1 bits 31:24 are
>>> reserved according to the public S905 datasheet, while bit 23 is the
>>> "A53_trace_clk_DIS" gate (which according to the datasheet should only
>>> be used in case a silicon bug is discovered) and bits 22:20 are a
>>> divider (A53_trace_clk). The meson clk-cpu code however expects that
>>> bits 28:20 are reserved for a divider (according to the public S805
>>> datasheet this "SCALE_DIV: This value represents an N+1 divider of the
>>> input clock.").
>>>
>>> The CPU clock on Meson GX SoCs is provided by the SCPI DVFS clock
>>> driver instead. Two examples from a Meson GXL S905X SoC:
>>> - vcpu (SCPI DVFS clock 0) rate: 1000000000 / cpu_clk rate: 708000000
>>> - vcpu (SCPI DVFS clock 0) rate: 1512000000 / cpu_clk rate: 708000000
>>>
>>
>> Thanks for catching this Martin! Looking at the difference between the S805 and
>> S905 register description, it makes no sense that we used the same clock driver
>> for what's behind HHI_SYS_CPU_CLK_CNTL1. I agree, it should be removed from the
>> gxbb clock controller.
you're welcome - I always like removing code :)

>>> Unfortunately the CLKID_CPUCLK was already exported (but is currently
>>> not used) to DT.
>>>
>>> This is an RFC because I would like to hear other people's opinion on
>>> how to clean up the CLKID_CPUCLK (as it leaves a "hole" in
>>> gxbb_hw_onecell_data and changes the DT API (by removing a currently
>>> unused #define).
>>>
>>
>> In general the DT ABI should be stable but since no one is using this ID, and
>> what it refers to is clearly wrong, I don't think we would disrupt anything by
>> removing it.
>>
>> For the "hole" in the ids, Neil and I had similar problem while working other
>> topics. We managed to dodge it but I think it was only a matter of time ...
>>
>> In the end, it is not a big deal if there is holes in the onecell_data, as long
>> as we take care to avoid it when we register the clocks:
>
> Agreed.  It's better to have holes in the clkid space than to introduce
> DT incompatibility.
perfect, thanks for your opinion. and special thanks to Jerome who
already prepared a patch which allows holes in the _hw_onecell_data.

I will rebase this on the meson-clk branch and re-send a non-RFC patch
in the next few days.


Regards,
Martin
