From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 17 Dec 2013 14:49:10 +0800
Subject: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
In-Reply-To: <20131211060413.GL18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-4-git-send-email-b29396@freescale.com>
 <20131211021646.GC18380@S2101-09.ap.freescale.net>
 <CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
 <20131211031853.GG18380@S2101-09.ap.freescale.net>
 <CAA+hA=STB-M5H9VsFjx4bqgbdPAAzgbChVY4JrsGdBKqYnmGkA@mail.gmail.com>
 <20131211034824.GH18380@S2101-09.ap.freescale.net>
 <CAA+hA=Q2Q18LtN14_D-JjULBFDQ1Nt8PNmyhc6FwQd5fe3R7_g@mail.gmail.com>
 <20131211060413.GL18380@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=R4BsfmWYZ3juX1Ubd2fzcewcKw1HmTpP0JgyzXVPChPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 2:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 11, 2013 at 01:03:43PM +0800, Dong Aisheng wrote:
>> On Wed, Dec 11, 2013 at 11:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > On Wed, Dec 11, 2013 at 11:35:17AM +0800, Dong Aisheng wrote:
>> >> This actually is the register value, not the max timeout counter value.
>> >> Then you may want define the API as:
>> >> unsigned int    (*get_max_timeout_val)(struct sdhci_host *host);
>> >
>> > Yes, something like that.
>> >
>> >> But i don't think it's necessary to do the max timeout setting in two steps.
>> >> First, deinfe a API to get the max timeout counter val,
>> >> Second, write this val into register.
>> >> Why not simply implement .set_timeout and handle the details in
>> >> platform specific
>> >> host driver respectively?
>> >
>> > Well, that's how sdhci host driver is structured.  Doing so leaves the
>> > least details to platform driver, and calling sdhci_writeb() to access
>> > SDHCI_TIMEOUT_CONTROL in sdhci-esdhc-imx seems a layer violation to me.
>> >
>>
>> The current sdhci-esdhci-imx already does something like that.
>> You can search SDHCI_* in the code.
>> It just reuses the register offset definition in sdhci,
>> It's not the layer violation.
>
> I do not understand why we have to do this SDHCI_TIMEOUT_CONTROL setup
> in our sdhci-esdhc-imx driver, when sdhci driver is already structured
> to do it in its way.  All we need is a hook to give the correct
> max_timeout_val.
>

Because i don't think sdhci_calc_timeout is still meaningful anymore for a
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL anymore.
The only thing you reply sdhci to do is set a max_timeout.

And i don't think it's necessary to use a hook to get max_timeout_val first,
then use this val to write into register later to do the max_timeout
setting work.
It's perfect fine to let the platform .set_timeout to do it directly.
And we already have .get_max_timeout_count hook, i don't want
.get_max_timeout_val again.

There's another important reason that .set_timeout provides other platforms
host controller ability to set timeout based on their way if they want.
The sdhci should have this capability since it is common case just like
.set_clock and etc.
e.g. imx5. the timeout count setting is different when DDR is enabled.
(Though we still not add DDR support for mx5)
Then we must need such hook to do specific IMX timeout setting instead
of using common sdhci timeout setting.

Regards
Dong Aisheng

> Shawn
>
