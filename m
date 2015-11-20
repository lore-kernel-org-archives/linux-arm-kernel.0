From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Nov 2015 19:58:01 -0600
Subject: [PATCH v3 2/5] dt-bindings: soc: add document for rockchip reboot
 notifier driver
In-Reply-To: <564E7473.9080509@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <20151118225904.GA5429@rob-hp-laptop> <564D2331.8070503@rock-chips.com>
 <2082288.pD4oKxtaXL@phil> <564E7473.9080509@rock-chips.com>
Message-ID: <CAL_JsqLRbTz-dNcYctXmY=E_y3MZj7XWJC3PqDU=YYek09vnmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 7:16 PM, Andy Yan <andy.yan@rock-chips.com> wrote:
> On 2015?11?19? 12:35, Heiko Stuebner wrote:
>> Am Donnerstag, 19. November 2015, 09:17:37 schrieb Andy Yan:
>>> On 2015?11?19? 06:59, Rob Herring wrote:
>>>> On Wed, Nov 18, 2015 at 05:53:30PM +0800, Andy Yan wrote:
>>>>>
>>>>> Add devicetree binding document for rockchip reboot nofifier driver
>>>>
>>>> Just reading the subject this is way too specific to the Linux driver
>>>> needs rather than a h/w description. Please don't create fake DT nodes
>>>> just to bind to drivers. Whatever &pmu is is probably what should have
>>>> the DT node. Let the driver for it create child devices if you need
>>>> that.
>>>
>>>       This is note a fake DT nodes, we really need it to tell the driver
>>>        which register to use to store the reboot mode. Because rockchip
>>>        use different register file to store the reboot mode on different
>>>        platform, on rk3066,rk3188, rk3288,it use  one of the PMU
>>> register, on
>>>        the incoming RK3036, it use one of the GRF register, and it use
>>> one  of
>>>        the PMUGRF register for arm64 platform rk3368. On the other hand,
>>> the
>>>        PMU/GRF/PMUGRF register file are mapped as "syscon", then
>>> referenced
>>>        by other DT nodes by phandle. So maybe let it as a separate DT
>>> node here
>>>        is better.
>>
>> or alternatively we could do something similar to what the bl-switcher
>> cupfreq-driver does. Take a look at
>>
>> drivers/cpufreq/arm_big_little.c
>> drivers/clk/clk-mb86s7x.c
>>
>> We already have the core restart-handler code in the clock-tree, so could
>> maybe simply do the
>>         platform_device_register_simple("rockchip-reboot", -1, NULL, 0);
>> in that common code?
>>
>> Though I'm not yet sure how to get the platform-data. I guess one option
>> would
>> be to do things like the 3288 suspend code does
>> (arch/arm/mach-rockchip/pm.c
>> at the bottom), by having the per-soc-data in the driver and then matching
>> against the pmu. Because the pmu is not part of the clock controller
>> binding
>> (and probably also shouldn't be).
>>
>    Thanks for your suggestion.
>     I have read the code you list above, if we implement the reboot notifier
>     driver like this, the driver need to add much more code to find the
> platform
>     data(like arch/arm/mach-rockhcip/pm.c), what's more, if we have a new
> soc
>     in the future and the soc use a different register here, we need modify
> the
>     driver to add a new platform data again, this will bring additional
> work.
>
>     Use the DT node pass the register will make the driver code simple and
> clear.
>     Is there any hurt to put this information in the DT?

Add the data you need to the PMU node. Then the PMU driver can get it
and pass to the child driver.

Rob
