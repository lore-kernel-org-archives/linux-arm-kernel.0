From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 16 May 2017 09:06:54 +0200
Subject: [PATCH 1/8] mmc: dt: pwrseq-simple: Invent power-off-delay-us
In-Reply-To: <CAL_JsqK4EnME2qH4j4+Nef7+1gAOKsjq00b8e7m0HWR4=w6FtQ@mail.gmail.com>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-2-git-send-email-ulf.hansson@linaro.org>
 <20170512200300.a2hq546ra42ptlz5@rob-hp-laptop>
 <CAPDyKFqhbGqanoQqFsLrLaBXsQ5WdFrrunkvB2eOoJqH+W6jdQ@mail.gmail.com>
 <CAL_JsqK4EnME2qH4j4+Nef7+1gAOKsjq00b8e7m0HWR4=w6FtQ@mail.gmail.com>
Message-ID: <CAPDyKFqJ5-tPGSSONPBc34YkwT=VruxfAo1GsBBHJYK6fiSZUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2017 at 18:16, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 15, 2017 at 6:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 12 May 2017 at 22:03, Rob Herring <robh@kernel.org> wrote:
>>> On Mon, May 08, 2017 at 06:21:10PM +0200, Ulf Hansson wrote:
>>>> During power off, after the GPIO pin has been asserted, some devices like
>>>> the Wifi chip from TI, Wl18xx, needs a delay before the host continues with
>>>> clock gating and turning off regulators as to follow a graceful shutdown
>>>> sequence.
>>>>
>>>> Therefore invent an optional power-off-delay-us DT binding for
>>>> mmc-pwrseq-simple, to allow us to support this constraint.
>>>
>>> Do you really need this to be programmable per device. A delay is not
>>> going to hurt devices that don't need it.
>>
>> Well, that depends on what "hurt" means. The device would still be
>> properly shut down, only that it would take unnecessary longer to do
>> so.
>>
>> I think the problem here, is that this delay may also affect system
>> suspend/resume time of the device, if the device powers off/on in this
>> sequence.
>
> I was assuming that given you changed the units the time was small
> enough to not be significant.

That's right. We are in the range of < 50us, which is suitable for the
Wl18xx chip.

However, the problem occurs when some other device needs a longer
delay and then we may reach a threshold that isn't acceptable.

To me it's better to allow it to be described in DT - then only
influencing those devices that really needs it.

>
>>> Sorry, but this is exactly what I don't like about "simple" bindings:
>>> adding one property at a time.
>>
>> I understand you opinion, which in the end is a matter of taste/flavor.
>
> It's more than that. The problem is you would end up with a different
> binding if everything is defined up front versus reviewing one
> addition at a time.
>
> To give a trivial example here, now we have power on and off times in
> different units and if I was reviewing them together I would say make
> them both usec. That example is mostly taste, but different units also
> makes it more error prone for the dts writer.

Okay, I see your a point.

>
>> However, for me this just follows the existing approach - and suddenly
>> say no to this, doesn't really seems right either.
>
> I never said no.

Alright. Is that a yes then? :-)

If not, what do you prefer me to do?

Kind regards
Uffe
