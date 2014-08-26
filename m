From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 26 Aug 2014 08:30:04 +0200
Subject: [PATCH 04/29] drivers: base: add notifier for failed driver bind
In-Reply-To: <20140825211823.GH16329@8bytes.org>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
 <20140825211823.GH16329@8bytes.org>
Message-ID: <53FC296C.1030202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-08-25 23:18, Joerg Roedel wrote:
> On Tue, Aug 05, 2014 at 12:47:32PM +0200, Marek Szyprowski wrote:
>> +	if (failed && dev->bus)
>> +		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> +					     BUS_NOTIFY_DRVBIND_FAILED, dev);
>> +
> Why can't you just use the notifier for BUS_NOTIFY_UNBIND_DRIVER or
> BUS_NOTIFY_UNBOUND_DRIVER when something goes wrong in driver
> initialization?

Hmmm, you might be right. BUS_NOTIFY_UNBIND_DRIVER event happens before 
unbinding
the driver, but BUS_NOTIFY_UNBOUND_DRIVER is called when driver remove 
has been
finished, so it can be considered as a symmetrical pair for 
BUS_NOTIFY_BIND_DRIVER.
Driver which registered bus notifiers is mainly interested in doing 
right cleanup,
so the code executed for IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER and
IOMMU_GROUP_NOTIFY_DRVBIND_FAILED is same.

I will remove this additional event and simply add a call to
BUS_NOTIFY_UNBOUND_DRIVER event when driver probe fails.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
