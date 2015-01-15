From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Thu, 15 Jan 2015 09:27:14 +0800
Subject: [PATCH v6 1/2] mtd: hisilicon: add a new NAND controller driver
 for hisilicon hip04 Soc
In-Reply-To: <20150114192510.GY9759@ld-irv-0074>
References: <1421047734-30818-1-git-send-email-wangzhou1@hisilicon.com>
 <1421047734-30818-2-git-send-email-wangzhou1@hisilicon.com>
 <20150113035844.GJ9759@ld-irv-0074> <54B6625F.8060607@hisilicon.com>
 <20150114192510.GY9759@ld-irv-0074>
Message-ID: <54B71772.9080601@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/15 3:25, Brian Norris wrote:
> On Wed, Jan 14, 2015 at 08:34:39PM +0800, Zhou Wang wrote:
>> On 2015/1/13 11:58, Brian Norris wrote:
>>> On Mon, Jan 12, 2015 at 03:28:53PM +0800, Zhou Wang wrote:
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>> +	chip->IO_ADDR_R = chip->IO_ADDR_W = devm_ioremap_resource(dev, res);
>>>
>>> Hmm, do you really have to reuse IO_ADDR_{R,W} here? Those are only
>>> targeted for NAND systems which have a direct MMIO mapping to the NAND
>>> I/O pins. See nand_base's {read,write}_buf() and read_{byte,word}()
>>> implementations. But you override those.
>>
>> There is a hardware buffer in this NAND controller, and the buffer can be
>> accessed as MMIO.
> 
> Sure.
> 
>> IO_ADDR_R/W just indicates the base address of this buffer.
> 
> But I was noting that IO_ADDR_{R,W} actually serve a very particular
> purpose in nand_base.c, which seems distinct from your HW buffer.
> 
>> Maybe I need to use a void __iomem pointer stored in my host struct to use
>> this buffer instead of IO_ADDR_R/W as you said below here?
> 
> Yes, I think that would be better.

OK, I will do as this in next version, Thanks!

> 
>>> It's best if it's obvious if nand_base is somehow inadvertently using
>>> these pointers. So leaving them NULL is helpful.
>>>
>>> As an alternative, you can just stash another private void __iomem
>>> pointer in you your host struct.
> 
> Thanks,
> Brian

Thanks for your reply!
Zhou Wang

> 
> .
> 
