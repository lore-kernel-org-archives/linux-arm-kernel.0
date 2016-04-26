From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 26 Apr 2016 18:10:00 +0300
Subject: [PATCH V17 1/3] dmaengine: qcom_hidma: implement lower level
 hardware interface
In-Reply-To: <571F8397.5000803@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-2-git-send-email-okaya@codeaurora.org>
 <20160426032805.GA2274@localhost> <571F8397.5000803@codeaurora.org>
Message-ID: <CAHp75VeZQnhaiSDuGJtgcKtek7yUwgQWd3J5QSJbdisehmBGqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 6:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/25/2016 11:28 PM, Vinod Koul wrote:
>> On Mon, Apr 11, 2016 at 10:21:11AM -0400, Sinan Kaya wrote:

>>> +    while (cause) {
>>> +            if ((cause & BIT(HIDMA_IRQ_TR_CH_INVALID_TRE_BIT_POS)) ||
>>> +                (cause & BIT(HIDMA_IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS)) ||
>>> +                (cause & BIT(HIDMA_IRQ_EV_CH_WR_RESP_BIT_POS)) ||
>>> +                (cause & BIT(HIDMA_IRQ_TR_CH_DATA_RD_ER_BIT_POS)) ||
>>> +                (cause & BIT(HIDMA_IRQ_TR_CH_DATA_WR_ER_BIT_POS))) {
>>
>> Switch please
>
> Cause is a combined status register. Let's say it contains 0x41. I need to check
> if bit 0 or bit 6 is set in this value for each case condition. The value is not 0x40
> or 0x1.
>
> I created macro like this instead.
>
> +#define HIDMA_IS_ERR_INTERRUPT(cause)                          \
> +       (cause & BIT(HIDMA_IRQ_TR_CH_INVALID_TRE_BIT_POS))   || \
> +       (cause & BIT(HIDMA_IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS)) || \
> +       (cause & BIT(HIDMA_IRQ_EV_CH_WR_RESP_BIT_POS))       || \
> +       (cause & BIT(HIDMA_IRQ_TR_CH_DATA_RD_ER_BIT_POS))    || \
> +       (cause & BIT(HIDMA_IRQ_TR_CH_DATA_WR_ER_BIT_POS))

This looks overheaded.

#define HIDMA_XXX (BIT(a) | BIT (b) ... BIT(n))

>
> and replaced the if statement as follows
>
> if (HIDMA_IS_ERR_INTERRUPT(cause)) {

if (cause & HIDMA_XXX) {

-- 
With Best Regards,
Andy Shevchenko
