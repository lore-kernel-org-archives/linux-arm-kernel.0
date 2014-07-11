From: dianders@chromium.org (Doug Anderson)
Date: Thu, 10 Jul 2014 21:02:35 -0700
Subject: [PATCH v7 08/24] mfd: max77686: Add Dynamic Voltage Scaling (DVS)
 support
In-Reply-To: <53BF41C8.4080304@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-9-git-send-email-javier.martinez@collabora.co.uk>
 <CADGdYn6tyTBZOjZH8JBUVMJ1kh-tht=tkU4tA+oM=PbfTYkqGw@mail.gmail.com>
 <53BF41C8.4080304@collabora.co.uk>
Message-ID: <CAD=FV=XrgKSaOOutRr6wkNa6vu3uXo3ny43zyKCQzbYpe5xb2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 10, 2014 at 6:45 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>> I think when DVS gpio is used all the 8 voltage levels are fetched
>> from DT during booting and the registers are programmed accordingly.
>> Any further set/get_voltage just changes the GPIO lines.
>> Any reason why this method is not used?
>
> What are you describing is how the DT binding works for other Maxim PMICs that
> also have DVS support right? (e.g: max8997).
>
> The DVS binding in max77686/802 is actually a subset of the one in max8997 so it
> let's you only choose which single DVS index is going to be used. The GPIOs in
> "max77686,pmic-buck-dvs-gpios" should match "pmic-buck-default-dvs-idx".
>
> To be honest I just took the DT binding that was used in the max77xxx driver
> from the Chrome OS 3.8 kernel and didn't compare it with other Maxim PMICs DT
> bingings.
>
> I wonder if I should just take the DVS patches out from this initial version to
> avoid blocking the max77802 support and then we can discuss this in more detail.

To give background:

* On exynos5250 / exynos5420 / exynos5800 the CPUFreq driver exposes
more than 8 different operating points.  You could argue about whether
that's useful but that's the way it is right now.  That means that
using the GPIOs is not trivial (you'd have to use a mix of GPIOs and
i2c and use heuristics).

* On the Samsung Chromebook 2 we use the DVFS GPIOs to get back to a
sane state after a warm reset.  When the CPU resets itself all GPIOs
will default back to their reset state.  That will effectively
transfer us to DVFS slot 0.  We make sure that the kernel always
modifies a different DVFS slot.

* On all known boards all DVFS GPIOs were hooked up.  I originally
wrote code assuming that someone could design a board with fewer lines
hooked up but I don't know of that being done.

-Doug
