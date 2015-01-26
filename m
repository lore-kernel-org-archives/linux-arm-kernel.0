From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 26 Jan 2015 09:33:07 +0100
Subject: [PATCH v3] ARM: zynq: DT: Add USB to device tree
In-Reply-To: <54C5F965.90100@monstr.eu>
References: <1417536431-27759-1-git-send-email-soren.brinkmann@xilinx.com>
 <d78fedd84f354d80985187f851cb3cd1@BN1AFFO11FD055.protection.gbl>
 <54C5F89A.3090901@suse.de> <54C5F965.90100@monstr.eu>
Message-ID: <54C5FBC3.7030903@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.01.2015 um 09:23 schrieb Michal Simek:
> On 01/26/2015 09:19 AM, Andreas F?rber wrote:
>> Am 03.12.2014 um 09:39 schrieb Michal Simek:
>>> On 12/02/2014 05:07 PM, Soren Brinkmann wrote:
>>>> Add USB nodes to zc702, zc706 and zed device trees.
>>>>
>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>> ---
>>>> v3:
>>>>  - rename phy nodes: usb_phy -> phy0
>>>>  - rebased onto zynq/dt
>>>> v2:
>>>>  - remove '@0' from phy node name
>>>>  - don't add bogus space
>>>> ---
>>>>  arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
>>>>  arch/arm/boot/dts/zynq-zc702.dts | 11 +++++++++++
>>>>  arch/arm/boot/dts/zynq-zc706.dts | 10 ++++++++++
>>>>  arch/arm/boot/dts/zynq-zed.dts   | 10 ++++++++++
>>>>  4 files changed, 51 insertions(+)
>> [...]
>>>
>>> Applied to zynq/dt.
>>
>> Hm, I don't see this patch in linux-next next-20150123...
>>
>> And if I apply it to my -next based tree, adding corresponding nodes to
>> zynq-parallella.dts, I get repeatedly:
>>
>> [  +0,012242] ci_hdrc ci_hdrc.0: no of_node; not parsing pinctrl DT
>> [  +0,000157] ci_hdrc ci_hdrc.0: ChipIdea HDRC found, lpm: 0; cap:
>> f090e100 op: f090e140
>> [  +0,000081] platform ci_hdrc.0: Driver ci_hdrc requests probe deferral
>> [  +0,005360] ci_hdrc ci_hdrc.1: no of_node; not parsing pinctrl DT
>> [  +0,000120] ci_hdrc ci_hdrc.1: ChipIdea HDRC found, lpm: 0; cap:
>> f0910100 op: f0910140
>> [  +0,001810] platform ci_hdrc.1: Driver ci_hdrc requests probe deferral
>>
>> Am I missing any other patches or config options?
>> (I do notice that the pinctrl v3 patch that got merged has a trivial bug
>> for usb0, for which I'll send a patch later on.)
> 
> Why is it deferred? Is it because of pinmuxing stuff?

No, happened without as well.

Looking at a different place in dmesg, I spot this:

[  +0,003988] usb_phy_generic phy0: GPIO lookup for consumer reset-gpios
[  +0,000012] usb_phy_generic phy0: using device tree for GPIO lookup
[  +0,000015] of_get_named_gpiod_flags: can't parse 'reset-gpios-gpios'
property
 of node '/phy0[0]'
[  +0,000013] of_get_named_gpiod_flags: can't parse 'reset-gpios-gpio'
property
of node '/phy0[0]'
[  +0,000010] usb_phy_generic phy0: using lookup tables for GPIO lookup
[  +0,000153] usb_phy_generic phy0: lookup for GPIO reset-gpios failed
[  +0,000012] usb_phy_generic phy0: Error requesting RESET GPIO
[  +0,004360] usb_phy_generic: probe of phy0 failed with error -2
[  +0,004991] usb_phy_generic phy1: GPIO lookup for consumer reset-gpios
[  +0,000012] usb_phy_generic phy1: using device tree for GPIO lookup
[  +0,000013] of_get_named_gpiod_flags: can't parse 'reset-gpios-gpios'
property
 of node '/phy1[0]'
[  +0,000013] of_get_named_gpiod_flags: can't parse 'reset-gpios-gpio'
property of node '/phy1[0]'
[  +0,000010] usb_phy_generic phy1: using lookup tables for GPIO lookup
[  +0,000012] usb_phy_generic phy1: lookup for GPIO reset-gpios failed
[  +0,000011] usb_phy_generic phy1: Error requesting RESET GPIO
[  +0,004337] usb_phy_generic: probe of phy1 failed with error -2

So, I guess the chipidea driver is deferring because the phys want a
property that neither me nor you are specifying? Would that be the two
MDIO pins 52 and 53 that would need to be specified?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/b985530f/attachment.sig>
