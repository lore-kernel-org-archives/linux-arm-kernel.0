From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 5 Jul 2018 12:59:48 +0100
Subject: question about : inv smmu atc all cmd timeout when pcie dpc occur.
In-Reply-To: <8CD08B4737CACA4ABE0228F45E441A9163801C42@dggemm521-mbs.china.huawei.com>
References: <8CD08B4737CACA4ABE0228F45E441A9163801C42@dggemm521-mbs.china.huawei.com>
Message-ID: <f93cbab5-5cc7-2854-f120-d745abdac50d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/18 03:12, Zhongmiao wrote:
> On Mon, Jul 02, 2018 at 02:24:45PM +0000, Zhongmiao wrote:
>>       I?m testing  pcie  ats feature .     when some  error occur pcie dpc
>>  then  link down .  iommu will   remove device from iommu group and send  atc
>> inv all  cmd to  device .
>>
>>  
>>
>> But , pcie already  link down , so  atc inv all  will   time out .  I what to
>> know kernel  driver  how to think aout it  ?  thanks .  ^_^.

Thanks for the report, the interaction between ATS and DPC is an
interesting one, and I hadn't been able to trigger an ATC timeout so far.

An ATC inv timeout shouldn't be fatal, and after seeing this error you
should still be able to use the SMMU. It's not clear from your kernel
log, does the SMMU driver recover cleanly? Can you continue using it for
other endpoints?

As to the messages you're seeing, if it's just a couple of extra
warnings in a situation as exceptional as DPC error, it might fine as
is. But if it bothers you, maybe we could call pci_dev_is_disconnected
before sending an ATC-inv-all, I think the core sets this bit before
removing the device.

Thanks,
Jean
