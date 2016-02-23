From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 23 Feb 2016 08:15:35 -0600
Subject: [PATCH] irqchip/gicv3-its: Don't allow devices whose ID is
 outside range
In-Reply-To: <56CC1D83.4060503@arm.com>
References: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
 <56CC1D83.4060503@arm.com>
Message-ID: <56CC6987.1050107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 02/23/2016 02:51 AM, Marc Zyngier wrote:
> On 23/02/16 03:57, Shanker Donthineni wrote:
>> We are not checking whether the requested device identifier fits into
>> table or not. The ITS MAPD command fails if 'Device ID' is outside of
>> device table range.
>>
>> Add a simple validation check to avoid MAPD failures since we are
>> not handling ITS command errors. This change also helps to return an
>> error -ENOMEM instead of success to caller.
>>
> In which circumstances do you see this failing? We allocate memory for
> the whole DevID range (as advertised by the ITS), so anything that comes
> up outside of that range cannot be handled anyway, and is a HW
> integration issue. You might as well pretend that these devices do not
> exist.
>
> Thanks,
>
> 	M.
We will try to allocate maximum memory as much as possible to cover 
whole DevID.
sparse. We may not always successful, sometimes we limit memory 
allocation size
for two reasons MAX_ORDER and ITS flat table capacity.

1) According to ARM-GIC spec, ITS hw can access maximum of 256 (ITS-pages) *
    64K (ITS-pageszie) bytes.

     21bits = 16 MBytes / 8 (flat table size / device table entry size)

Assuming: minimum device table entry size 8 Bytes

2) On 4K page size kernel with default arch/arm64/defconfig.

    19bits = 4 MBytes / 8 (flat table size / device table entry size)

Assuming: minimum device table entry size 8 Bytes

This is definitely a problem if DevID range is much more than 19Bits and 
we fail to allocate
enough memory. Our ITS hardware has capable of supporting all 32bits, so 
it advertises
DevID 32.

I am preparing an another patch to support ITS-Indirection (two-level 
table walk) feature.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
