From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Thu, 21 Feb 2013 17:36:50 +0800
Subject: [PATCH 3/3] pinctrl: imx: move hard-coding data into device tree
In-Reply-To: <51251E5A.1080806@wwwdotorg.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
 <51251E5A.1080806@wwwdotorg.org>
Message-ID: <CAP1dx+w2bLcztrRJOYs07xxSqVgo3bggJHMFt5LyL5jXQ-h6Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 February 2013 03:04, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/20/2013 12:08 AM, Shawn Guo wrote:
>> Currently, all imx pinctrl drivers maintain a big array of struct
>> imx_pin_reg which hard-codes data like register offset and mux mode
>> setting for each pin function.  Every time a new imx SoC support is
>> added, we need to add such a big mount of data.  With moving to single
>> kernel build, it's only matter of time to be blamed on memory consuming.
>>
>> With DTC pre-processor support in place, the patch moves all these data
>> into device tree by redefining the PIN_FUNC_ID in imxXX-pinfunc.h and
>> changing the PIN_FUNC_ID parsing code a little bit.
>
> There are a couple of potential issues with this patch, which I'm in two
> minds about:
>
> 1)
>
> This is an incompatible change to the DT binding definition. A DT
> written to the old specification won't work with a newer kernel and
> vice-versa. This isn't supposed to happen with device tree.
>
> Right now I believe we're still being flexible about DT binding changes,
> but I've seen hints that this kind of thing will start getting lots of
> push-back in the near future...
>
I wonder it may be hard to avoid it, especially for some complicated devices or
non-standard devices during development process.
No sure if any better way to control it.

> That all said, I'd also love to change the Tegra pinctrl binding now
> that we have CPP, since I could replace all the strings in the current
> binding with integers and presumably save some space in the .dtb. Hence,
> I'd love to maintain the flexibility to keep changing the .dts and
> kernel code in lock-step.
>
> 2)
>
> This patch removes a bunch of tables from the kernel. I like having the
> tables in the kernel, since in theory it could allow a future debugfs or
> sysfs interface to pinctrl that allows manipulation of the pinctrl HW
> state at a semantic level.

Right, that's one of the considerations why i kept the register table in driver
in the first binding design.

> This is only possible if the DT binding
> includes details such as "set this pin to this function", and the driver
> includes the tables to convert that into details such as register
> address and value. I don't think such an "API" could be implemented for
> IMX after this patch.

Theoretically It can, because device tree contains the pin registers
informations
in this way. But the problem is that it can only manipulate the used pins which
are parsed from devices tree. While for those unused pins, since the driver does
not have the pin register information, it can not manipulate it.
But what i'm wondering now is do we really need to manipulate the unused pins
from sysfs or debugfs?
I still can not think out a real using case now.
Anyone else can think one?

> Still, given the IMX binding already merged "pin"
> and "function" into a single integer in the binding, I'm not sure if IMX
> could support that kind of "API" before anyway?
>
At least PIN config could support.
For PIN mux, it may also be implementable since we have all the needed
information
for a pin in driver whether it's used or not.

Regards
Dong Aisheng

> This is part of the reason I pushed hard for the pinctrl APIs to operate
> at the semantic pin/group/function level, and that Tegra's pinctrl
> drivers explicitly have tables listing all the pins/groups/functions,
> rather than just putting a bunch of register values into the DT.
>
> I'm not sure how much of an issue this is, though. LinusW and/or the DT
> maintainers should probably chime in here.
>
> I didn't actually read the driver implementation changes in this patch.
