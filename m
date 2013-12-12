From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 20:09:30 +0100
Subject: [PATCH v2 1/3] pinctrl: Add Qualcomm TLMM driver
In-Reply-To: <52A7C313.8090208@codeaurora.org>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-2-git-send-email-bjorn.andersson@sonymobile.com>
 <52A24438.4000908@codeaurora.org>
 <20131210081031.GD11990@sonymobile.com>
 <52A7C313.8090208@codeaurora.org>
Message-ID: <CACRpkdbEKUibOBk=iUi-CrHdmgV46GetyNUgomyngFAwrb=biQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 2:42 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 12/10/13 00:10, Bjorn Andersson wrote:
>> On Fri 06 Dec 13:40 PST 2013, Stephen Boyd wrote:
>>>> +config PINCTRL_MSM
>>>> +     bool
>>> Why not tristate?
>>>
>> I have a hard time seeing an situation where you would like to build a system
>> with this driver as a module; it would force almost the entire system to be
>> loaded at a later time...
>
> We're going to need to build everything but the essentials as modules
> for the multi-platform kernel because we're going to run into the
> problem where the kernel can't link anymore. Data heavy drivers such as
> this are  targets for that because they waste more space being built-in
> and they're not absolutely necessary to boot into an initrd that holds
> the modules for a particular device.

This is a quite generic problem rather than a pin control problem.

We're actually going to have to compile quite a few drivers into the
kernel as well, like all irqchips and all clock sources...

I think we have toyed with the idea of tagging code and data so
that it will be discarded on non-matched platforms, I have no
idea how that would look in practice :-(

There are quite a few pin control drivers compiled into any
present multiplatform kernels, so I wouldn't say that one
more or less hurts us today.

>>>> +#include <linux/pinctrl/pinctrl.h>
>>>> +#include <linux/pinctrl/pinmux.h>
>>>> +#include <linux/pinctrl/pinconf.h>
>>>> +#include <linux/pinctrl/machine.h>
>>> Are any of these includes actually necessary? Can't we just forward
>>> declare struct pinctrl_pin_desc?
>>>
>> None of them are needed in the current set of patches, as these are already
>> included in the c-files before including this.
>>
>> But the right set should be: platform_device.h and pinctrl.h.
>
> We should be able to get away with forward declaring the structs we care
> about. C files that include this header should be including the
> pinctrl.h header file anyway, no?

Patches accepted...

Yours,
Linus Walleij
