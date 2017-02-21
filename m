From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 21 Feb 2017 12:37:33 +0530
Subject: [PATCH v4 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <20170220110942.GF9003@leverpostej>
References: <1487530263-42643-1-git-send-email-anurup.m@huawei.com>
 <20170220110942.GF9003@leverpostej>
Message-ID: <58ABE735.2010708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Marc.

On Monday 20 February 2017 04:39 PM, Mark Rutland wrote:
> On Sun, Feb 19, 2017 at 01:51:03PM -0500, Anurup M wrote:
>> The L3 cache PMU use N-N SPI interrupt which has no support
>> in kernel mainline.
> Could you elaborate on what you mean by this?
>
> I don't understand what is meant here. How exactly are the interrupts
> wired up in HW, and what exactly is not supported by Linux?

In HW the L3C overflow IRQ is wired as SPI which use N-N model.
But according to ARM GIC V2 specification, the peripheral(hardware) 
interrupts should use 1-N model.
N-N model is used by SGIs. In GIC V3 spec I could not find any 
description of N-N model.
So I think the N-N model for SPI will not be supported.

Hi Marc,
     Does ARM GIC support N-N module for SPI? Please share your comments.

>> So use hrtimer to poll and update event
>> counter to avoid overflow condition for L3 cache PMU.
>> A interval of 10 seconds is used for the hrtimer.
>> The time interval can be configured in the sysfs.
> I'm not too keen on giving userspace the ability to control this, since
> it gives an awful lot of rope for userspace to tie around itself.

I thought of giving facility to system user to decide the interval based 
on the system usage.

If we do not provide this facility, then we always set the worst case 
overflow interval?
I am trying to understand it better.

Thanks,
Anurup

> Thanks,
> Mark.
