From: dianders@chromium.org (Doug Anderson)
Date: Wed, 12 Nov 2014 10:04:31 -0800
Subject: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for
 vqmmc
In-Reply-To: <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
Message-ID: <CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf,

On Tue, Nov 11, 2014 at 12:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 11 November 2014 05:02, Addy Ke <addy.ke@rock-chips.com> wrote:
>> SD2.0 cards need vqmmc and vmmc to be the same.
>
> No, that's not correct.
>
> If I remember the spec correctly, the bus signal threshold is 0.75 * VDD.

As usual, I will first state my utter lack of knowledge of all things mmc.

Now that's out of the way, on two separate board with two separate
SoCs I've heard stories of cards that don't work when there's a big
gap between vmmc and vqmmc.

If my memory serves, previously I heard of problems with vmmc=3.3V and
vqmmc=2.8V.  That means there were problems with .85 * VDD.  Certainly
Addy seems to have a card that has problems with vmmc=3.3V and
vqmmc=2.7V (but worked with vmmc=3.3V and vqmmc=2.8V).  That is .82 *
VDD.

I have no idea if these old cards are "to spec", but they exist and it
would be nice to support them.

It seems like the absolute safest thing would be to try to keep vmmc
and vqmmc matching if possible, especially during card probe.  Once
voltage negotiation happened then the vqmmc could go down.


>> But vqmmc call regulator_set_voltage to set min_uv(2.7v) as far as possible.
>
> I guess you want to do that to save as much power as possible.

I don't think it's Addy wanting it, I think it's the regulator framework.

If a regulator is current 1.8V and you request 2.7 - 3.3V, the
framework needs to pick one of those voltages.  I believe it will pick
2.7V.

...so I think we get into trouble only when the 2.0 card is plugged in
after a UHS card has negotiated down the voltage, but I could be
wrong.  Maybe Addy can clarify.


>> @@ -1163,8 +1163,14 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>>          */
>>         uhs = mci_readl(host, UHS_REG);
>>         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>> -               min_uv = 2700000;
>> -               max_uv = 3600000;
>> +               /* try pick the exact same voltage as vmmc for vqmmc */
>
> This seems like a generic SD protocol issue.
>
> Should we maybe provide some helper function from the mmc core, which
> in principle take the negotiated card->ocr into account while
> calculating the signal voltage level. Typically min_uv should be 0.75
> x (card->ocr), for these cases.

Yes, if there are ways to make the solution more generic I would
certainly support that.

-Doug
