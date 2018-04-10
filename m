From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 Apr 2018 09:06:26 +0200
Subject: [PATCH] pinctrl/samsung: Correct EINTG banks order
In-Reply-To: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPdckxVfwU60=e7e6trbiB78ETE=G2vuY1kCrcKHaU2CzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 8, 2018 at 8:07 PM, Pawe? Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
> All banks with GPIO interrupts should be at beginning
> of bank array and without any other types of banks between them.
> This order is expected by exynos_eint_gpio_irq, when doing
> interrupt group to bank translation.
> Otherwise, kernel NULL pointer dereference would happen
> when trying to handle interrupt, due to wrong bank being looked up.
> Observed on s5pv210, when trying to handle gpj0 interrupt,
> where kernel was mapping it to gpi bank.

Thanks for the patch. The issue looks real although one thing was
missed - there is a gap in SVC group between GPK2 and GPL0 (pointed by
Marek Szyprowski):

0x0 - EINT_23 - gpk0
0x1 - EINT_24 - gpk1
0x2 - EINT_25 - gpk2
0x4 - EINT_27 - gpl0
0x7 - EINT_8 - gpm0

Maybe this should be done differently - to remove such hidden
requirement entirely in favor of another parameter of
EXYNOS_PIN_BANK_EINTG argument? Anyway if such hidden requirement
stays, then please document it in the source code (it maybe next to
PIN order... or next macro... or also in exynos_eint_gpio_irq()).

Beside that please add cc-stable and appropriate fixes tag,

Best regards,
Krzysztof
