From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 15 Feb 2017 20:58:32 -0800
Subject: [PATCH v2] reset: Add i.MX7 SRC reset driver
In-Reply-To: <1487150153.2433.11.camel@pengutronix.de>
References: <20170213153338.13518-1-andrew.smirnov@gmail.com>
 <1487004643.2873.97.camel@pengutronix.de>
 <CAHQ1cqFXiu03902jWLkg8X6jdQ3+TiLj02dSDFBAVH98ABo70A@mail.gmail.com>
 <1487089919.2305.22.camel@pengutronix.de>
 <CAHQ1cqGHujsDsC5dtXk3_1u0kKme8k96jgSctp5XFSHuYKeE=A@mail.gmail.com>
 <1487150153.2433.11.camel@pengutronix.de>
Message-ID: <CAHQ1cqGhUFNQ=q6gTXRnkm3QRCstiPtpDQBtCfwZ+Fua+rbrxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 1:15 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Tue, 2017-02-14 at 12:11 -0800, Andrey Smirnov wrote:
> [...]
>> > Arguably, the A7 resets should not be handled by the peripheral reset
>> > controller, but at least for the others I see no reason not to leave
>> > space for them in the index table.
>>
>> If for some bizarre reason one was to run Linux on M4 and use A7 as
>> applications processor, resetting A7 might be useful. But that's a
>> very unlikely use-case.
>>
>> > In fact, since unused reset controls
>> > don't use space, why not number them all?
>>
>> IMHO because it is unused code and because those numbers constitute an
>> interface which once set will be hard to change if need be.
>>
>> But that's not that important and I don't feel particularly strong
>> about that point, so I'll add those sources in v3.
>
> Thanks.
>
>> Do you insist that I split what I call IMX7_RESET_PCIEPHY into
>> PCIEPHY_G_RST and PCIEPHY_BTN or can I keep it as a single logical
>> reset?
>
> No, I say keep it as is. For now I'll assume this is not a reset, but
> some other interface signal that just happens to be routed out to the
> SRC and just happens to be toggled around the same time in the enable
> sequence.
>
> [...]
>> >> >> +#define IMX7_RESET_PCIE_CTRL_APPS    0
>> >> >> +#define IMX7_RESET_PCIEPHY           1
>> >> >
>> >> > It would expect these to be numbered in the order they appear in the
>> >> > register map, not starting from the end. Could you add all available
>> >> > peripheral resets to this list, in the correct order?
>> >>
>> >> The numbering is just a consequence of me adding only resets I could
>> >> exercise with my code and numbering then starting from zero. I also
>> >> was hesitant adding more sources since it seemed to me that some of
>> >> less trivial registers in that IP block might be best represented as a
>> >> single reset source doing something more sophisticated that just
>> >> setting a bit under the hood.
>> >
>> > Any in particular?
>>
>> USBPHY1/2 and maybe MIPI resets? But that's no more than a gut feeling.
>
> Is there any downstream code that already handles these resets? At least
> for the USB PHYs I'd expect there has to be something we could look at.

Just went and double checked. Of the three that I mentioned, couldn't
find anything besides MIPI and for that only one of the signals was
being used, nothing fancy. I think I'll just expose all of the signals
as discussed above and not worry about it in v3.

Thanks,
Andrey Smirnov
