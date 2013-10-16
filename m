From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 09:26:56 +0200
Subject: [PATCH v10 3/7] ARM: dts: enable hi4511 with device tree
In-Reply-To: <201310152018.10908.arnd@arndb.de>
References: <1381828577-27998-1-git-send-email-haojian.zhuang@linaro.org>
 <1381828577-27998-4-git-send-email-haojian.zhuang@linaro.org>
 <201310152018.10908.arnd@arndb.de>
Message-ID: <CACRpkdZ5qWiM7xp-Wc1jtQYvEOGyA11pvR80ds6NtHXP-U6AtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 8:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 October 2013, Haojian Zhuang wrote:

> Since all clocks are in the fc802000 page, I would prefer using a non-empty
> ranges to map the clocks into their own address space, like
>
>                 ranges = <0 0xfc802000 0x1000>;
>
>
>> +             timer4_mux: timer4_mux at fc802018 {
>> +                     compatible = "hisilicon,clk-mux";
>> +                     #clock-cells = <0>;
>> +                     clocks = <&osc32k &timerclk45>;
>> +                     clock-output-names = "timer4_mux";
>> +                     reg = <0xfc802018 0x4>;
>> +                     clkmux-mask = <0x3>;
>> +                     clkmux-table = <0 0x1>;
>> +             };
>
> which would turn this into
>
>                 timer4_mux: timer4_mux at 18 {
>                         ...
>                         reg = <0x18 0x4>;
>                         ...
>                 };
>
> The code would not be impacted by this.

I'd rather question the addition of a reg =<>; specifier
for each and every clock.

Knowing the offsets of each and every register in a
memory-mapped device is usually overdesign, and
goes from specifying register base to specifying
register offsets and to me that is overspecifying.

I'd rather give each clock a unique ID or something,
then let the driver know the offsets, and specify the
base and size in the top node.

This becomes more obvious with a second silicon
revision moving the registers around - with this
design all of the clocks need updating, but if you're
lucky with less knowledge in the DTS you only need
a new compatible string and the knowledge of the new
whereabout for the regs is kept in the driver.

Yours,
Linus Walleij
