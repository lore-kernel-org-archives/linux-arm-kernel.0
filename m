From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Mar 2014 22:03:05 +0100
Subject: [PATCH 04/20] mmc: mmci: Move signal directions bits into DT
 include file
In-Reply-To: <CAPDyKFq=PUcFkT901W15KXThzS4cKMJvZToW3JDc3SkXck9VHA@mail.gmail.com>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-5-git-send-email-ulf.hansson@linaro.org>
 <CACRpkdZSr380FVHkx3uOMFKxKYsExoL-1WYhxVpirFMVc+T3Yw@mail.gmail.com>
 <CAPDyKFq=PUcFkT901W15KXThzS4cKMJvZToW3JDc3SkXck9VHA@mail.gmail.com>
Message-ID: <CACRpkdaNY1jM7xN00DEnOMdDxSf==3AqdrkRSXX3dghStvA4hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 12:05 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 March 2014 22:22, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Mar 21, 2014 at 1:14 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>> These bits is currently used from platform data, but will be needed
>>> from DT as well, so let's make them available.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> (...)
>>> +#define MCI_ST_DATA31DIREN     (1 << 5)
>>> +#define MCI_ST_FBCLKEN         (1 << 7)
>>> +#define MCI_ST_DATA74DIREN     (1 << 8)
>>
>> Isn't MCI_ST_FBCLKEN = feedback clock enable and nothing
>> to do with directions really?
>
> You do have a point here, but then we are about to go into the details. :-)
>
> What MCI_ST_FBCLKEN means, is that the internal logic in the primecell
> can decide whether to use the signal from clockout pin or the
> feebackclock pin, when its latching incoming signals on the data bus.
>
> That said, we for sure need a dt binding for bit as well, since this
> is not possible to figure out how pins are routed in runtime.
>
> Also, I do believe it is very closely related to the other sigdir
> pins, since it's all about how pins is being routed, even if it's as
> you say - in this case a matter of signal directions.
>
> So, I guess we have two options here; Either move the MCI_ST_FBCLKEN
> out of the signal-direction binding and invent a separate binding for
> it, or just keep them as is.

If they are very closely related I guess that will become very
clear when you document it in the requested explicit bindings,
so no strong opinion here. I'd probably ACK either version.

>> Maybe we should just have single strings for these
>> things in the binding instead, like:
>>
>> @@ -118,6 +119,10 @@
>>                         bus-width = <4>;
>>                         mmc-cap-sd-highspeed;
>>                         mmc-cap-mmc-highspeed;
>> +                       st,signal-direction-data2;
>> +                       st,signal-direction-cmd;
>> +                       st,signal-direction-data0;
>> +                       st,feedback-clock-enable;
>>                         vmmc-supply = <&ab8500_ldo_aux3_reg>;
>>                         vqmmc-supply = <&vmmci>;
>>                         pinctrl-names = "default", "sleep";
>
> I guess this is an option. To me it just seems a bit silly to have one
> separate binding for each single bit, but maybe it becomes clearer?

The idea with device trees is to be very human-readable, so I guess
if you have preprocessor macro things |:ing the arguments together
to a singular 32bit value it serves the same purpose. Arguably this
version is even easier for a human to read though.

What we should avoid is using magic number assignments to
save space (e.g. have magic numbers in the tree rather than
readable strings) so I lean toward this, but it's admittedly in a
grey area, so again no strong opinion.

Yours,
Linus Walleij
