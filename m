From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 11 Dec 2013 11:20:59 +0800
Subject: [PATCH 1/6] mmc: sdhci: add platfrom get_max_timeout hook
In-Reply-To: <20131211031254.GF18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-2-git-send-email-b29396@freescale.com>
 <20131211015640.GA18380@S2101-09.ap.freescale.net>
 <CAA+hA=ST0fAa2__PaeJqxj2yDWUAr6iaNO4Dj7ABiEWqnYp6Vw@mail.gmail.com>
 <20131211031254.GF18380@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=QrEiwg8+hmEONgP5u6C0_YwQhEeBfDoFQTv=aCaLhqkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 11:12 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 11, 2013 at 11:00:03AM +0800, Dong Aisheng wrote:
>> >> @@ -2930,7 +2930,10 @@ int sdhci_add_host(struct sdhci_host *host)
>> >>       if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>> >>               host->timeout_clk = mmc->f_max / 1000;
>> >>
>> >> -     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>> >> +     if (host->ops->get_max_timeout)
>> >> +             mmc->max_discard_to = host->ops->get_max_timeout(host);
>> >
>> > Does "timeout" conceptually equals to "discard_to"?  If not, we might
>> > want to write it in the either form below to avoid messing these two
>> > concepts.
>> >
>>
>> No, they're two concepts but the max_discard_to equals to the max timeout value
>> the host supports.
>
> Does it?  Shouldn't max_discard_to equals to max_timeout_value / timeout_clk?
>

Yes, you probably are confused that get_max_timeout return timeout in
miliseconds directly.
Do not need to do get_max_timeout(host) /timeout_clk.

>>
>> >         mmc->max_discard_to = host->ops->get_max_timeout(host) / host->timeout_clk;
>> >
>> > or
>> >
>> >         mmc->max_discard_to = host->ops->get_max_discard_to(host);
>> >
>> > I guess you may want to go for the second one.
>> >
>>
>> The original way looks ok to me.
>> Platform host driver does not need to know detail about discard,
>> just tell the max timeout value it supports is ok.
>> Common sdhci driver will handle it well.
>
> Well, looking at the patch #2, esdhc_get_max_timeout() returns
>
>   max_to / (esdhc_pltfm_get_max_clock(host) / 1000)
>
> not just the max timeout value - max_to, so your platform host driver
> is knowing and handling the details about discard_ro, i.e. the
> discard_ro has to be max_timeout_value / timeout_clk.
>

No, the max_to is the max timeout counter value, you need to divide it
by the timeout clock
to get the timeout time.
The defined of this API is return the max timeout value in
miliseconds, so you need to
divide the clock by 1000.
None of these handles the detail bout discard_to.

Regards
Dong Aisheng

> Shawn
>
