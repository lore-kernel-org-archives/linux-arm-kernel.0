From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 16:52:39 -0600
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific descriptions
 for pin controllers
In-Reply-To: <1634883.GDdJlvHhnl@flatron>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <6920043.WDO1laKTfY@flatron> <5061F64B.5@wwwdotorg.org>
 <1634883.GDdJlvHhnl@flatron>
Message-ID: <506235B7.7020507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 12:35 PM, Tomasz Figa wrote:
> On Tuesday 25 of September 2012 12:22:03 Stephen Warren wrote:
...
>> BTW, how does the driver know what register addresses to use; I can see
>> the base for each pin controller bank is in samsung,pctl-offset, but
>> what describes the offset for each of the func, pud, drv, ... registers
>> from there? Are the offsets the same for all current Samsung SoCs?
> 
> The offsets are defined as constants in the driver.
> 
> They are the same in all cases, but the "4bit2" bank type of S3C64xx, which 
> can have up to 16 pins with 4-bit function specifiers, so two registers are 
> required for function configuration. In this case all the remaining 
> registers are offset by 0x04.
> 
> I couldn't think about any good solution for this special case, but still, 
> I haven't been thinking a lot about it, as the driver is targetted at 
> current Exynos SoCs primarily.

I suppose if you always assume that the registers will appear in a
specific order, and never have gaps between them, then you can simply
always calculate the addresses as e.g.:

reg_func = reg_base
reg_pud = reg_func + round_up(num_pins / (32 / func_width))
reg_drv = reg_pud + round_up(num_pins / (32 / func_width))
...

Then, there wouldn't ever be any special cases - that calculation would
always work.

An alternative would be to put each register's address in DT rather than
just the base of the register block. It'd certainly be more
future-flexible, even if not strictly necessary.
