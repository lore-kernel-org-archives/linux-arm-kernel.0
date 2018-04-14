From: pawel.mikolaj.chmiel@gmail.com (=?utf-8?B?UGF3ZcWC?= Chmiel)
Date: Sat, 14 Apr 2018 18:27:09 +0200
Subject: [PATCH] pinctrl/samsung: Correct EINTG banks order
In-Reply-To: <CAJKOXPcWQUHHhf2gV3u4fu=wuVf3qxOYwNdj0c_JFc+zqfJUkA@mail.gmail.com>
References: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CA+Ln22FAmBHrxEvQpBPV1p=Kg2g+XCHn=HQJCNSUhFv+Jtf6xA@mail.gmail.com>
 <CAJKOXPcWQUHHhf2gV3u4fu=wuVf3qxOYwNdj0c_JFc+zqfJUkA@mail.gmail.com>
Message-ID: <2132977.nF3rHrDWU5@acerlaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 11, 2018 11:52:44 AM CEST Krzysztof Kozlowski wrote:
> On Wed, Apr 11, 2018 at 10:36 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > 2018-04-10 17:38 GMT+09:00 Tomasz Figa <tomasz.figa@gmail.com>:
> >> 2018-04-10 16:06 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> >>> On Sun, Apr 8, 2018 at 8:07 PM, Pawe? Chmiel
> >>> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >>>> All banks with GPIO interrupts should be at beginning
> >>>> of bank array and without any other types of banks between them.
> >>>> This order is expected by exynos_eint_gpio_irq, when doing
> >>>> interrupt group to bank translation.
> >>>> Otherwise, kernel NULL pointer dereference would happen
> >>>> when trying to handle interrupt, due to wrong bank being looked up.
> >>>> Observed on s5pv210, when trying to handle gpj0 interrupt,
> >>>> where kernel was mapping it to gpi bank.
> >>>
> >>> Thanks for the patch. The issue looks real although one thing was
> >>> missed - there is a gap in SVC group between GPK2 and GPL0 (pointed by
> >>> Marek Szyprowski):
> >>>
> >>> 0x0 - EINT_23 - gpk0
> >>> 0x1 - EINT_24 - gpk1
> >>> 0x2 - EINT_25 - gpk2
> >>> 0x4 - EINT_27 - gpl0
> >>> 0x7 - EINT_8 - gpm0
> >>>
> >>> Maybe this should be done differently - to remove such hidden
> >>> requirement entirely in favor of another parameter of
> >>> EXYNOS_PIN_BANK_EINTG argument?
> >>
> >> Perhaps let's limit this patch to s5pv210 and Exynos5410 alone, where
> >> a simple swap of bank order in the arrays should be okay.
> >>
> >> We might also need to have some fixes on 4x12, because I noticed that
> >> in exynos4x12_pin_banks0[] there is a hole in eint_offsets between
> >> gpd1 and gpf0 and exynos4x12_pin_banks1[] starts with gpk0 that has
> >> eint_offset equal to 0x08 (not 0).
> >
> > To close the loop, after talking offline and checking the
> > documentation, Exynos4x12 is fine, because the group numbers in SVC
> > register actually match what is defined in bank arrays.
> 
> Great! Thanks for checking.
> 
> Best regards,
> Krzysztof
> 

Thanks for all comments. I'll prepare new version of patches, with all fixes and documentation.

Best regards
Pawe?
