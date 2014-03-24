From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Mar 2014 08:45:44 -0500
Subject: [PATCH 05/20] mmc: mmci: Add DT bindings for signal direction
In-Reply-To: <CAPDyKFrupT7sbT5eBsTC61ELCp_OZTe==Jc_6KUqo9Wb4Xf5dQ@mail.gmail.com>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-6-git-send-email-ulf.hansson@linaro.org>
 <CAL_JsqLFJbC=ZVgc1xu9MN6iYN2871mxvZoJnAQJw3BQU07B+w@mail.gmail.com>
 <CAPDyKFrupT7sbT5eBsTC61ELCp_OZTe==Jc_6KUqo9Wb4Xf5dQ@mail.gmail.com>
Message-ID: <CAL_Jsq+=7YTK8p+=QNwatUaTnQsFXXFD3OH+kmqYLF0DYpbTKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 4:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 21 March 2014 16:20, Rob Herring <robherring2@gmail.com> wrote:
>> On Fri, Mar 21, 2014 at 7:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Some variants have support for indicating the bus signal directions,
>>> which currently are configured through platform data.
>>>
>>> Add corresponding DT bindings to enable us to move away from using the
>>> platform data.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/mmci.txt |    4 ++++
>>>  drivers/mmc/host/mmci.c                        |    7 +++++++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
>>> index d167562..eb9ad86 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
>>> @@ -15,6 +15,7 @@ Optional properties:
>>>  - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
>>>  - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
>>>  - vqmmc-supply           : phandle to the regulator device tree node.
>>> +- signal-direction       : a bit pattern, indicating bus signals directions.
>>
>> You need to define the bit positions.
>
> May I refer to the <dt-bindings/mmc/mmci.h> instead? To me, it seems a
> bit silly to duplicate that information in the documentation.

We really prefer that the binding doc stand on it's own such that you
could write the header based on the binding.

>>
>>>
>>>  Example:
>>>
>>> @@ -37,6 +38,9 @@ sdi0_per1 at 80126000 {
>>>         mmc-cap-mmc-highspeed;
>>>         cd-gpios  = <&gpio2 31 0x4>; // 95
>>>
>>> +       signal-direction = <(MCI_ST_DATA2DIREN | MCI_ST_CMDDIREN |
>>> +                       MCI_ST_DATA0DIREN | MCI_ST_FBCLKEN)>;
>>
>> The "ST" here is for STMicro or some ST based company? Use the vendor
>> prefix here.
>
> We have way back already concluded to use "ST" as prefix for all
> STMicro specific defines used in mmci. Please have a look at
> drivers/mmc/host/mmci.h.
> I would prefer to keep these aligned with the other defines, though if
> you have strong feelings about it, sure I can change them.

I don't mean change the defines. I mean name the property
"st,signal-direction" and indicate it only applies to the STMicro
variant.

>> I don't really understand why you need to specify the direction here.
>> Data lines are bi-directional and cmd and clk are outputs.
>>
>
> These bits are being used when you have an external levelshifter.
>
> Without going into too much details, it all depends on how the
> different pins are connected to the levelshifter, which isn't possible
> to figure out in runtime.

Okay.

Rob
