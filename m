From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 23 Feb 2016 11:48:37 -0600
Subject: [PATCH] irqchip/gicv3-its: Don't allow devices whose ID is
 outside range
In-Reply-To: <56CC1D83.4060503@arm.com>
References: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
 <56CC1D83.4060503@arm.com>
Message-ID: <56CC9B75.7090801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Sorry, I have not responded to your email earlier, by mistake replied to 
original patch.

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
ITS probe function tries to allocate maximum memory as much as possible to
cover whole DevID. sparse which is reported (ITS_TYPER.Devbits) by HW. We
might not be able to allocate enough memory for device table.  We reduce
memory allocation size for two reasons either because of crossing MAX_ORDER
limit or max ITS_BASERn size.

1) According to ARM-GIC spec, we can assign maximum memory size
     256 (ITS-Size) * 64K (ITS-PageSzie) Bytes to level-one (flat) 
device table.

     DevID = flat_table_size/device_table_entry_size = 16MBytes/8  = 
21bits (max)

2) Maximum 4Mbytes memory is possible on kernel using PAGE_SIZE=4K with 
default
     arch/arm64/defconfig (MAX_ORDER = 12).

     DevID = flat_table_size/device_table_entry_size = 4MBytes/8  = 
19bits (max)

Assuming: minimum device table entry size 8 Bytes.

I think it is a generic problem and this fail scenario happens if DevID 
range is more
than 21bits or failed to allocate required memory size for device table.

Our ITS hardware is capable of supporting 32bit DevID space, so it 
advertises
ITS_TYPER.Devbits field with value 31 causing this problem. I think we need
some protection in its_create_device() to avoid this scenario.

I am planning to post an another patch to add support for ITS-Indirection
(two-level) table walk feature.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
