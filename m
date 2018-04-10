From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 10 Apr 2018 17:38:29 +0900
Subject: [PATCH] pinctrl/samsung: Correct EINTG banks order
In-Reply-To: <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
References: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
Message-ID: <CA+Ln22Eabq0HH6YmCSFwLd68w3DU4xTX2BiNAeLe_tnG6282Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-10 16:06 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Sun, Apr 8, 2018 at 8:07 PM, Pawe? Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
>> All banks with GPIO interrupts should be at beginning
>> of bank array and without any other types of banks between them.
>> This order is expected by exynos_eint_gpio_irq, when doing
>> interrupt group to bank translation.
>> Otherwise, kernel NULL pointer dereference would happen
>> when trying to handle interrupt, due to wrong bank being looked up.
>> Observed on s5pv210, when trying to handle gpj0 interrupt,
>> where kernel was mapping it to gpi bank.
>
> Thanks for the patch. The issue looks real although one thing was
> missed - there is a gap in SVC group between GPK2 and GPL0 (pointed by
> Marek Szyprowski):
>
> 0x0 - EINT_23 - gpk0
> 0x1 - EINT_24 - gpk1
> 0x2 - EINT_25 - gpk2
> 0x4 - EINT_27 - gpl0
> 0x7 - EINT_8 - gpm0
>
> Maybe this should be done differently - to remove such hidden
> requirement entirely in favor of another parameter of
> EXYNOS_PIN_BANK_EINTG argument?

Perhaps let's limit this patch to s5pv210 and Exynos5410 alone, where
a simple swap of bank order in the arrays should be okay.

We might also need to have some fixes on 4x12, because I noticed that
in exynos4x12_pin_banks0[] there is a hole in eint_offsets between
gpd1 and gpf0 and exynos4x12_pin_banks1[] starts with gpk0 that has
eint_offset equal to 0x08 (not 0).

> Anyway if such hidden requirement
> stays, then please document it in the source code (it maybe next to
> PIN order... or next macro... or also in exynos_eint_gpio_irq()).
>
> Beside that please add cc-stable and appropriate fixes tag,

Agreed. Probably the only safe way of documenting this is to put it
inside each bank array, so that when someone creates a copy/paste for
new SoC, the comment is clearly visible... Perhaps something like:

/* Must start with EINTG banks, ordered by EINT group number. */

Best regards,
Tomasz
