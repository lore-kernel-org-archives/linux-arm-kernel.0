From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Dec 2014 11:20:31 +0000
Subject: [PATCH v3 04/13] irqchip: GICv3: ITS command queue
In-Reply-To: <5487B7E5.2080104@huawei.com>
References: <1416839720-18400-1-git-send-email-marc.zyngier@arm.com>
 <1416839720-18400-5-git-send-email-marc.zyngier@arm.com>
 <5487B7E5.2080104@huawei.com>
Message-ID: <54882C7F.4010901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/14 03:03, Yun Wu (Abel) wrote:
> On 2014/11/24 22:35, Marc Zyngier wrote:
> 
> [...]
> 
>> +static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
>> +                                              struct its_cmd_desc *desc)
>> +{
>> +     unsigned long itt_addr;
>> +     u8 size = order_base_2(desc->its_mapd_cmd.dev->nr_ites);
> 
> If @nr_ites is 1, then @size becomes 0, and... (see below)
> 
>> +
>> +     itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
>> +     itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
>> +
>> +     its_encode_cmd(cmd, GITS_CMD_MAPD);
>> +     its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
>> +     its_encode_size(cmd, size - 1);
> 
> here (size - 1) becomes the value of ~0, which will exceed the maximum
> supported bits of identifier.

Well, the problem is that nr_ites should never be 1, as it effectively
means "don't use any bit to index the ITE". And it also means we cannot
have an ITT that's not a strict power of two.

So while this is indeed a bug, the root of the problem is elsewhere.

I'll cook a fix, thanks for the report.

	M.
-- 
Jazz is not dead. It just smells funny...
