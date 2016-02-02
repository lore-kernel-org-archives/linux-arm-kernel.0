From: wdc@rock-chips.com (David.Wu)
Date: Tue, 2 Feb 2016 17:38:43 +0800
Subject: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to
 distinguish
In-Reply-To: <5354361.hQXgJ7cEGx@diego>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
 <5387650.lAgTxexlF2@phil> <56AF1D4E.40307@rock-chips.com>
 <5354361.hQXgJ7cEGx@diego>
Message-ID: <56B07923.9020900@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2016/2/2 5:17, Heiko St?bner ??:
> Hi David,
>
> Am Montag, 1. Februar 2016, 16:54:38 schrieb David.Wu:
>> ? 2016/1/30 20:39, Heiko Stuebner ??:
>>> Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
>>>> As rk3368 contained two separated iodomain areas, this was
>>>> determined to use which regmap base address.
>>>>
>>>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>>> I don't think we need to specify this on a driver level. Both GRF areas
>>> are
>>> "General register files" only located in two separate power-domains.
>>> So the rockchip,grf property should work for both. Especially as nothing
>>> keeps designers from introducing yet another GRF-area somewhere else ;-)
>>>
>>> >From when I started working on the rk3368, I still have a preliminary
>>>
>>> patches for that sitting here, so I've attached on how I envisoned that to
>>> work.
>> Okay, i agree to you, but it make someone a little confused just from
>> the drive code,
>> not DT file,  about  pmugrf regmap base address.:-)
>>
>> How do you feel about intergating GRF and PMU drivers in one driver?
>> Thanks!
> I will very strongly disagree here ;-) .
> Similar to the power-domains being part of the pmu, the io-domains are
> part of their individual GRFs. So if you want it really clean and tidy the way
> to go foward will be the attached patches. Compile-tested only.

Thanks for your reply, the patchs look better than mine.
I have tested them on sdk board and i found something may be wrong.
"parent->of_node" instead of "parent", as the parent is not null if 
parent-node not used.
         if (parent->of_node) {
             iod->grf = syscon_node_to_regmap(parent->of_node);
         } else {
             dev_dbg(&pdev->dev, "falling back to old binding\n");
             iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
         }

> Other things like the usbphy control should move there as well in the long
> run. But that's not immediate necessary.
>
>
> Heiko
