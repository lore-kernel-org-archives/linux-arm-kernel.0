From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 6 Jan 2016 10:37:31 +0800
Subject: [PATCH] soc: mediatek: PMIC wrap: Enable STAUPD_PRD before
 WDT_SRC_EN enabled.
In-Reply-To: <1451876703.11408.10.camel@mtksdaap41>
References: <1451478961-5668-1-git-send-email-henryc.chen@mediatek.com>
 <CAGS+omBc2XVESu1t+_iKj1gTk-7JVDK1KDoQEJR_-wcL4m0qWg@mail.gmail.com>
 <1451876703.11408.10.camel@mtksdaap41>
Message-ID: <CAGS+omBAa_n2zk0-tCyV_g3D1Nxu4j1A4q_5eRBJ-xT=PUv1sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 4, 2016 at 11:05 AM, Henry Chen <henryc.chen@mediatek.com> wrote:
> On Thu, 2015-12-31 at 22:19 +0800, Daniel Kurtz wrote:
>> On Wed, Dec 30, 2015 at 8:36 PM, Henry Chen <henryc.chen@mediatek.com> wrote:
>> >
>> > The STAUPD_TRIG will be enable when WDT_INT enable on probe function, if
>> > doesn't enable STAUPD_PRD together, interrupt will be triggered because
>> > STAUPD timeout. To avoid unexpected interrupt, enable periodic status
>> > update which will be updated to PMIC every selected time period.
>>
>> Sorry, I don't really understand this.
>>
>> What exactly is triggering the unexpected watchdog interrupt (WDT_INT)?
>>
>> How does setting STAUPD_PRD disable this "unexpected interrupt"?
>>
> Yes, WDT_INT was triggered because the bit[25] of WDT_SRC_EN was
> enabled:
>
> bit[25] STAUPD_TRIG: STAUPD trigger signal timeout monitor
>
> Setting STAUPD_PRD will update the status of PMIC periodic to avoid this
> watchdog timeout.

Sorry, I still don't understand.

IIUC, setting STAUPD_PRD sets the period at which status updates are
reported (announced via the shared STAUPD/WDT interrupt).

So, setting STAUPD_PRD=5 should set the reporting period to 98.5 us.
But, how does changing this period fix the "unexpected interrupt"?
I can understand how it might change the timing of the interrupt, but
why does it make the interrupt no longer occur?
We are still triggering the interrupt when we write bit[25]
(STAUPD_TRIG) of WDT_SRC_EN, two lines later.

Isn't this still requesting a STAUPD interrupt 98.5 us later?  (which,
since STAUPD interrupts aren't handled, is an "unexpected interrupt")
Wouldn't a better fix be to just clear the STAUPD_TRIG bit of
WDT_SRC_EN, and just not trigger STAUPD in the first place if we can't
handle them?

-Dan

>> From the MT8173 Datasheet, I can see that the value written to
>> STAUPD_PRD is the "periodic status update timing (period)".
>>
>> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>> > ---
>> >  drivers/soc/mediatek/mtk-pmic-wrap.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > index a8cde17..6e5c20f 100644
>> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > @@ -904,6 +904,11 @@ static int pwrap_probe(struct platform_device *pdev)
>> >                 return -ENODEV;
>> >         }
>> >
>> > +       /*
>> > +        * Enable periodic status update which will be updated to PMIC
>> > +        * every selected time period.
>> > +        */
>> > +       pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
>>
>> nit: Perhaps use a define for 5, and specify the real period value.
>> Something like this:
>>
>> #define PWRAP_STAUPD_98_5US  5
>>
> ok.
>
>>
>> >         /* Initialize watchdog, may not be done by the bootloader */
>> >         pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
>> >         pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
>> > --
>> > 1.9.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> > the body of a message to majordomo at vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
