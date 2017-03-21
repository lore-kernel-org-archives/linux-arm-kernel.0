From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 21 Mar 2017 10:31:37 +0900
Subject: [PATCH] pinctrl: samsung: fix segfault when using external
 interrupts on s3c24xx
In-Reply-To: <CAJKOXPdUQ8DSPR_4cDs8WyrV9Mmy6isncW72BNiTyiRb79qf7g@mail.gmail.com>
References: <1488489799-18136-1-git-send-email-sergio.prado@e-labworks.com>
 <20170304081504.unv6sihbmp76ynfy@kozik-lap> <20170306131516.GA6095@n1>
 <20170308163434.obhtg6fwmjwqv7jm@kozik-lap>
 <CA+Ln22FEYfO2EmvLKTRSHNFPpKSOw38vSDvg-nPv_j08cApqCw@mail.gmail.com>
 <CAJKOXPdUQ8DSPR_4cDs8WyrV9Mmy6isncW72BNiTyiRb79qf7g@mail.gmail.com>
Message-ID: <CA+Ln22E55XD92vzG=+3DYxozQiXc=DOEzSg655fYY5gVep6Diw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-09 15:42 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Thu, Mar 9, 2017 at 7:56 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> 2017-03-09 1:34 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
>>> On Mon, Mar 06, 2017 at 09:15:16AM -0400, Sergio Prado wrote:
>>>> Hi Krzysztof,
>>>>
>>>> > > This is a regression from commit 8b1bd11c1f8f529057369c5b3702d13fd24e2765.
>>>> >
>>>> > Checkpatch should complain here about commit format.
>>>> >
>>>> > >
>>>> > > Tested on FriendlyARM mini2440.
>>>> > >
>>>> >
>>>> > Please add:
>>>> >   Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank")
>>>> >   Cc: <stable@vger.kernel.org>
>>>> >
>>>>
>>>> OK.
>>>>
>>>> > > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>>>> > > ---
>>>> > >  drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 4 ++--
>>>> > >  1 file changed, 2 insertions(+), 2 deletions(-)
>>>> > >
>>>> > > diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
>>>> > > index b82a003546ae..1b8d887796e8 100644
>>>> > > --- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
>>>> > > +++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
>>>> > > @@ -356,8 +356,8 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
>>>> > >  {
>>>> > >   struct s3c24xx_eint_data *data = irq_desc_get_handler_data(desc);
>>>> > >   struct irq_chip *chip = irq_desc_get_chip(desc);
>>>> > > - struct irq_data *irqd = irq_desc_get_irq_data(desc);
>>>> > > - struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
>>>> > > + struct samsung_pinctrl_drv_data *d = data->drvdata;
>>>> > > + struct samsung_pin_bank *bank = d->pin_banks;
>>>> >
>>>> > I think 'pin_banks' point to all banks of given controller not to the
>>>> > currently accessed one.
>>>>
>>>> Understood. I think it worked in my tests because on s3c2440 all banks
>>>> have the same eint base address.
>>>>
>>>> So what do you think is the best approach to solve this problem?
>>>
>>> Maybe you can get to this through:
>>>         s3c24xx_eint_domain_data = s3c24xx_eint_data->domains[virq].host_data;
>>>         s3c24xx_eint_domain_data->bank
>>>
>>> It is getting slightly more complicated...
>>
>> How about the suggestions I made in my reply from March 4 (JST)?
>
> Yes, this also looks like solution. I am not sure how much you would
> like to revert but wouldn't it create duplicated members in pinctrl
> structures? One for Exynos and other for S3C?

I would actually lean towards introducing one duplicated member
(drvdata->pctl_base) versus adding unnecessarily complex special ways
of calculating the addresses from current (unsuitable) set of data.


By the way, I think I just found yet another bug introduced by that
patch. In exynos_irq_request_resources() and
exynos_irq_release_resources(), the address of CON register is
calculated from bank->eint_base, while I believe it should be
calculated from bank->pctl_base (which is also what
samsung_pinmux_setup() uses).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pinctrl/samsung/pinctrl-exynos.c?id=refs/tags/next-20170320#n174

Ehh, I think I regret letting that patch be merged as it made some of
the code quite messy and we actually found a better way to support
those strange banks later (group banks by their pctl_base and only
allow eint_base to be selectable per bank; then we could just keep
drvdata->pctl_base constant over all related banks).

Best regards,
Tomasz
