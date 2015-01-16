From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 16 Jan 2015 09:44:49 +0100
Subject: [PATCH V2 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
In-Reply-To: <20150115170444.GM16217@leverpostej>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
 <1421240530-7971-5-git-send-email-ulf.hansson@linaro.org>
 <20150115170444.GM16217@leverpostej>
Message-ID: <CAPDyKFquHA0LJLkRVWUaUJzCuw7pWacY=XFLhD3C+XXK3Kw_kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 18:04, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Jan 14, 2015 at 01:02:10PM +0000, Ulf Hansson wrote:
>> The need for a reset GPIO has several times been pointed out from
>> earlier posted patchsets. Especially some WLAN chips which are
>> attached to an SDIO interface may use a GPIO reset.
>>
>> In this first version, one reset pin is supported. We may want to
>> extend the support to cover more pins, but let's leave that as a future
>> change. The added DT binding for the reset GPIO can easily be extended
>> to manage several pins.
>>
>> The reset GPIO is asserted at initialization and prior we start the
>> power up procedure. It will then be de-asserted right after the power
>> has been provided to the external chip/card, from the ->post_power_on()
>> callback.
>
> This needs to be specified a little more explicitly in the binding
> document below, as it forms part of the contract of the binding.
>
>>
>> Note, the reset GPIO is optional. Thus we don't return an error even if
>> we can't find a GPIO pin for the consumer.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Changes in v2:
>>       - Adopted to the changed names of the pwrseq callbacks.
>>
>> ---
>>  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt  |  5 +++
>>  drivers/mmc/core/pwrseq_simple.c                   | 38 ++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> index e1b7f9c..6fe0cd6 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> @@ -11,8 +11,13 @@ for several SOC designs.
>>  Required properties:
>>  - compatible : contains "mmc,pwrseq-simple".
>>
>> +Optional properties:
>> +- reset-gpios : contains a list of GPIO specifiers, though currently only one
>> +             specifier is supported.
>
> The support is a Linux issue. If the binding is meant to describe a
> list, mention that, and what the expected semantics are.
>
> Is it that difficult to have the driver iterate over the list now?

I was trying to keep code simple, maybe too simple. :-)

I will update the DT document according to your proposal and fix the code.

Thanks for reviewing!

Kind regards
Uffe
