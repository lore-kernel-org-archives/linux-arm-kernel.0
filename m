From: wulf@rock-chips.com (wlf)
Date: Tue, 13 Feb 2018 00:40:31 +0800
Subject: [PATCH 1/3] dt-bindings: phy: phy-rockchip-typec: add usb3 otg
 reset
In-Reply-To: <1907466.pgqOKPpIkg@phil>
References: <1515751704-13213-1-git-send-email-william.wu@rock-chips.com>
 <20180119214916.fegrzgcmbbdiesyz@rob-hp-laptop>
 <d05fb977-cd6c-4875-25be-9212e75b7e39@rock-chips.com>
 <1907466.pgqOKPpIkg@phil>
Message-ID: <7996ee24-1376-a7ec-91dc-26798c9159c7@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Heiko,

? 2018?02?11? 03:55, Heiko Stuebner ??:
> Hi Wulf,
>
> Am Montag, 22. Januar 2018, 12:33:05 CET schrieb wlf:
>> ? 2018?01?20? 05:49, Rob Herring ??:
>>> On Thu, Jan 18, 2018 at 09:47:50AM -0800, Brian Norris wrote:
>>>> On Thu, Jan 18, 2018 at 06:20:09PM +0100, Enric Balletbo Serra wrote:
>>>>> As Brian said commit 06c47e6286d5 'usb: dwc3: of-simple: Add support
>>>>> to get resets for the device' introduced the support to get the resets
>>>>> from dwc3-of-simple and the queued commit 'b7e63d95c14d arm64: dts:
>>>>> rockchip: add reset property for dwc3 controllers on rk3399' started
>>>>> using it. Without the latest I get errors like this doing bind/unbind
>>>>> tests.
>>>>>
>>>>>      dwc3: probe of fe900000.dwc3 failed with error -110
>>>>>
>>>>> I just tested these series on top of mainline, I reverted my patch
>>>>> because otherwise two drivers are requesting the same reset and fails,
>>>>> and I did some of the bind/unbind test. They just worked fine, and
>>>>> seems that this is right way, so this makes me think some questions.
>>>> Actually, this was intended to coexist with DWC3 optionally controlling
>>>> the same reset. It was written before the reset framework was rewritten
>>>> to have shared and exclusive resets. Should this be rewritten to use
>>>> shared resets? We'd have to modify both dwc3 core and the PHY driver.
>>> Seems like abuse of DT to me. If you need to control the controller's
>>> reset from the phy driver, then get the reset out of the controller
>>> node. The phy node should describe the connections to the phy.
>> I try to get the reset out of the controller, but I don't find a good
>> way to get the reset ofthe controller associated with the given phy
>> device node.  Is there an API like theof_usb_get_dr_mode_by_phy() to
>> get 'dr_mode' of the controller?
> I guess the easiest way would be taking the of_usb_get_dr_mode_by_phy()
> function move the part above the "finish" label into a separate function
> like of_usb_get_node_by_phy (or possibly move that to an even more general
> place as it is not usb-related at all) and use that function in
> of_usb_get_dr_mode_by_phy() and also use it to get the reset you want via
> something like:
>
> node = of_usb_get_node_by_phy(...);
> rst = of_reset_control_get(node, ...);
Thanks for your good suggestion. I think it's a good way to get the 
reset of the
controller by phy.
>> And we're trying to find another method to fix the RK3399 tcphy power
>> on fail issue.If we get another proper method, we may not need these
>> phy patch series.
> Did you find any different solution for that yet?
>
> Heiko
Yes, finally, we have found another way to fix the? RK3399 tcphy usb power
on fail issue. And Enric Balletbo i Serra <Enric Balletbo i Serra> has 
submitted
new patch series, refer to the following patches:
https://patchwork.kernel.org/patch/10207261/
https://patchwork.kernel.org/patch/10207267/
https://patchwork.kernel.org/patch/10207263/

So my patches can be abandoned.
>
