From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 10:24:32 -0600
Subject: [PATCH V3 3/5] ARM: tegra: decouple uncompress.h and debug-macro.S
In-Reply-To: <20121022081830.GH3196@tbergstrom-lnx.Nvidia.com>
References: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
 <1350686507-3022-3-git-send-email-swarren@wwwdotorg.org>
 <20121022081830.GH3196@tbergstrom-lnx.Nvidia.com>
Message-ID: <50857340.4010403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 02:18 AM, Peter De Schrijver wrote:
>> +
>> +#define checkuart(rp, rv, lhu, bit, uart) \
>> +               /* Load address of CLK_RST register */ \
>> +               movw    rp, #TEGRA_CLK_RST_DEVICES_##lhu & 0xffff ; \
>> +               movt    rp, #TEGRA_CLK_RST_DEVICES_##lhu >> 16 ; \
>> +               /* Load value from CLK_RST register */ \
>> +               ldr     rp, [rp, #0] ; \
>> +               /* Test UART's reset bit */ \
>> +               tst     rp, #(1 << bit) ; \
>> +               /* If set, can't use UART; jump to save no UART */ \
>> +               bne     90f ; \
>> +               /* Load address of CLK_OUT_ENB register */ \
>> +               movw    rp, #TEGRA_CLK_OUT_ENB_##lhu & 0xffff ; \
>> +               movt    rp, #TEGRA_CLK_OUT_ENB_##lhu >> 16 ; \
>> +               /* Load value from CLK_OUT_ENB register */ \
>> +               ldr     rp, [rp, #0] ; \
>> +               /* Test UART's clock enable bit */ \
>> +               tst     rp, #(1 << bit) ; \
>> +               /* If clear, can't use UART; jump to save no UART */ \
>> +               beq     90f ; \
>> +               /* Passed all tests, load address of UART registers */ \
>> +               movw    rp, #TEGRA_UART##uart##_BASE & 0xffff ; \
>> +               movt    rp, #TEGRA_UART##uart##_BASE >> 16 ; \
>> +               /* Jump to save UART address */ \
>> +               b 91f
>>
> 
> Maybe make this a subroutine?

The addruart macro (which in turn uses the checkuart macro) is only
allowed to use 3 registers; rp, rv, rtmp. I'm also not 100% sure if the
stack is guaranteed to be set up when addruart is called either. So, I
don't think making this a function is possible.
