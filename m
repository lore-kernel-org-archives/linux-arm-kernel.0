From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Apr 2016 09:36:38 +0200
Subject: [PATCH v7 1/2] drivers: base: add support for registering notifier
 about deferred probe
In-Reply-To: <20160413141254.GB12749@kroah.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
 <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
 <20160413141254.GB12749@kroah.com>
Message-ID: <570F4886.20203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2016-04-13 16:12, Greg Kroah-Hartman wrote:
> On Wed, Apr 13, 2016 at 11:35:59AM +0200, Marek Szyprowski wrote:
>> This patch adds code which allow other subsystems get a notification
>> when deferred probe has been triggered. This way one can retry some
>> actions, which earlier failed with -EPROBE_DEFER error code.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Why would some other subsystem want/care about this?  You aren't telling
> them what device was deferred, and you don't need to as the bus itself
> already knows this information as it did the deferring!
>
> confused,

This notifier is just to let others that the deferred probe has happened and
it is a good time to retry operation, which earlier failed due to missing
resources (i.e. power domains, clocks). Such case is with registering AMBA
device (not the driver!). During AMBA device registration, bus code has 
to read
some device's registers to get its device CID/PID. To do this, device's 
clocks
and power domain has to be turned on. Those however might not be available
that time. With this notifier, AMBA bus code is able to retry device
registration, which earlier failed due to missing clocks or power domain.

This CID/PID reading has to be done during device registration time because
of the already deployed userspace ABI. CID/PID values are reported to
userspace, which might rely on them to load proper driver modules.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
