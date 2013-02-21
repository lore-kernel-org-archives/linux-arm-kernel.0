From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Feb 2013 12:57:02 -0700
Subject: [PATCH 3/3] pinctrl: imx: move hard-coding data into device tree
In-Reply-To: <CAP1dx+w2bLcztrRJOYs07xxSqVgo3bggJHMFt5LyL5jXQ-h6Mg@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
 <51251E5A.1080806@wwwdotorg.org>
 <CAP1dx+w2bLcztrRJOYs07xxSqVgo3bggJHMFt5LyL5jXQ-h6Mg@mail.gmail.com>
Message-ID: <51267C0E.6070902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2013 02:36 AM, Dong Aisheng wrote:
> On 21 February 2013 03:04, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 02/20/2013 12:08 AM, Shawn Guo wrote:
>>> Currently, all imx pinctrl drivers maintain a big array of struct
>>> imx_pin_reg which hard-codes data like register offset and mux mode
>>> setting for each pin function.  Every time a new imx SoC support is
>>> added, we need to add such a big mount of data.  With moving to single
>>> kernel build, it's only matter of time to be blamed on memory consuming.
>>>
>>> With DTC pre-processor support in place, the patch moves all these data
>>> into device tree by redefining the PIN_FUNC_ID in imxXX-pinfunc.h and
>>> changing the PIN_FUNC_ID parsing code a little bit.
...
>> This patch removes a bunch of tables from the kernel. I like having the
>> tables in the kernel, since in theory it could allow a future debugfs or
>> sysfs interface to pinctrl that allows manipulation of the pinctrl HW
>> state at a semantic level.
> 
> Right, that's one of the considerations why i kept the register table in driver
> in the first binding design.
> 
>> This is only possible if the DT binding
>> includes details such as "set this pin to this function", and the driver
>> includes the tables to convert that into details such as register
>> address and value. I don't think such an "API" could be implemented for
>> IMX after this patch.
> 
> Theoretically It can, because device tree contains the pin registers
> informations

> in this way. But the problem is that it can only manipulate the used pins which
> are parsed from devices tree. While for those unused pins, since the driver does
> not have the pin register information, it can not manipulate it.

Right, that's the main issue I was trying to highlight; the driver no
longer provides complete knowledge of the HW, but only learns about
stuff that happens to be used/defined in the board-specific DT.

> But what i'm wondering now is do we really need to manipulate the unused pins
> from sysfs or debugfs?
> I still can not think out a real using case now.
> Anyone else can think one?

For early board bringup, it may be useful to boot with a minimal set of
entries in the DT (enough to support e.g. serial console and some device
for a root filesystem) and then interactively tweak the rest of the
pinmux to define the rest of the board, and perhaps even save the result
somehow, and add it to the next iteration of the DT.

Also, consider a hobbyist-oriented board that has 50 unused pins that
could be GPIO, or mapped to some otherwise unused SD, I2C, SPI, ...
controller. Do we want to force the user to write a new DT and reboot,
or would it be better to provide some runtime API to set up those pins
based on what they had connected to the board, and then instantiate
drivers or use the sysfs GPIO interface, after doing so?
