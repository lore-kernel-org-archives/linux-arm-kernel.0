From: mreimer@sdgsystems.com (Matt Reimer)
Date: Mon, 25 Oct 2010 09:26:35 -0400
Subject: [PATCH] pxafb: correct the vertical back porch macro
In-Reply-To: <AANLkTinb3hNdp5evit9Ga0Z-gLCfPrPzE1VdCvwQVB3o@mail.gmail.com>
References: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
	<AANLkTinb3hNdp5evit9Ga0Z-gLCfPrPzE1VdCvwQVB3o@mail.gmail.com>
Message-ID: <AANLkTinPnchw4uad9M9dQXPPMR43qr7i6YHp6mqk3QfB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 9:07 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sat, Oct 23, 2010 at 5:26 AM, Matt Reimer <mreimer@sdgsystems.com> wrote:
>> Fix an off-by-one bug in the LCCR2_BegFrmDel() macro. The vertical back porch
>> knob LCCR2[BFW] specifies the number of clock periods minus one, but the
>> macro wasn't doing the subtraction.
>> ---
>> ?arch/arm/mach-pxa/include/mach/regs-lcd.h | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
>> index f82dcea..5074d18 100644
>> --- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
>> +++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
>> @@ -107,7 +107,7 @@
>> ?#define LCCR2_EndFrmDel(Tln) ? ((Tln) << FShft (LCCR2_EFW))
>>
>> ?#define LCCR2_BFW ? ? ?Fld (8, 24) ? ? /* Beginning-of-Frame line clock */
>> -#define LCCR2_BegFrmDel(Tln) ? ((Tln) << FShft (LCCR2_BFW))
>> +#define LCCR2_BegFrmDel(Tln) ? (((Tln) - 1) << FShft (LCCR2_BFW))
>
> Nothing in the spec suggests that this minus 1 is necessary. Could you please
> double check?

The docs I have describing this bit (vol 3 rev 1.0) say, "If LCCR6[29]
is set for LCD panels with an internal frame buffer, BFW specifies the
pulse width of the read signal (L_FCLK_RD), which is equal to
(BFW+1)*LCD_CLK_PERIOD."

I saw the "+1" in the docs and that the macro didn't match. But I
hadn't read closely enough to see that BFW gets different meanings
depending on what mode the controller is in. Because of this, I agree
it should stay as it is, so I withdraw this patch.

Matt
