From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Apr 2012 13:53:03 -0600
Subject: [PATCH 1/1] pinctrl: handle dummy state in core
In-Reply-To: <20120417034210.GD17173@shlinux2.ap.freescale.net>
References: <1334586289-13078-1-git-send-email-b29396@freescale.com>
 <4F8C42D6.2000607@wwwdotorg.org>
 <20120417034210.GD17173@shlinux2.ap.freescale.net>
Message-ID: <4F8DCA1F.3020904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 09:42 PM, Dong Aisheng wrote:
> On Tue, Apr 17, 2012 at 12:03:34AM +0800, Stephen Warren wrote:
>> On 04/16/2012 08:24 AM, Dong Aisheng wrote:
>>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>>
>>> Remove dummy state user interface and handle it totally in core.
>>> This can make it more easy to use by platforms which has neither pinctrl
>>> driver support nor dt support.
>>>
>>> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
>>
>> I think this is the wrong direction.
>>
>> I specifically want people to think about which drivers require what
>> pinctrl states to be defined, and what their content should be, and
>> hence explicitly define dummy states when it's appropriate. This patch
>> prevents that.
>>
> It's correct if all platforms have switched to pinctrl subsystem.
> 
> I think the main issue is for one platform neither supports dt nor using pinctrl
> subsystem, do you think it still makes too much sense to force that platform
> to define a _PINCTRL_ dummy state in their machine code?
> 
> But the driver is commonly shared between these different platforms(using pinctrl
> or not).

For a platform that doesn't have any pinctrl driver, wouldn't you just
disable CONFIG_PINCTRL. When that's disabled, all the pinctrl APIs are
already stubbed out not to return errors, IIRC.

If you're converting a platform to pinctrl for the first time, I don't
think it's unreasonable to have to define the dummy states for any
drivers that already use pinctrl. After all, there will on average
probably not be any/many such drivers, since presumably you'd write the
pinctrl driver first, then enable pinctrl for the platform, then port
all the relevant drivers to using pinctrl. The only pre-existing drivers
that actually use pinctrl would be shared IP blocks, which aren't too
common across different SoCs. (They are common within a series of SoCs
from the same vendor, but I still think it's reasonable to just write
few dummy states during the early conversion process either way).

If you don't agree with my thinking, can we at least make your patch
conditional, probably using a Kconfig variable, so that fully ported
platforms can require the mapping table (or DT) to fully specify all
pinctrl state (including dummy states if required), but people doing
development can flip a Kconfig switch to make pinctrl_get/lookup_state
return a dummy state instead of an error"?

> That's why i proposed to handle dummy state in core in this patch rather than require
> user to do it.
> 
> You must can assume there're so many platforms still have not switched to use pinctrl
> subsystem. If we require user to do it, we need change many code.
> 
> Regards
> Dong Aisheng
