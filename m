From: vigneshr@ti.com (Vignesh R)
Date: Thu, 27 Nov 2014 09:59:33 +0530
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <547325FA.6020004@linutronix.de>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de> <547321A2.6010207@ti.com>
 <547325FA.6020004@linutronix.de>
Message-ID: <5476A8AD.4010003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 24 November 2014 06:05 PM, Sebastian Andrzej Siewior wrote:
> On 11/24/2014 01:16 PM, Vignesh R wrote:
> 
>> I have tried running both IIO and TSC at the same time. But I have never
>> seen WARN_ON() even after running for close to 30 min. Can you send me
>> the exact script, so that it will be easy to reproduce?
> 
> Sure thing.
> - one shell
> 	evtest /dev/input/event2
> - second shell
> 	./iio-test.sh
>   with:
> 
> |#!/bin/sh
> |
> |while [ 1 = 1 ]
> |do
> |        cat /sys/bus/iio/devices/iio\:device0/in_voltage4_raw
> |done
> 
> 
> the kernel config: https://breakpoint.cc/am335x-config
> 

I was able to reproduce this issue. When ADC hits WARN_ON(), the TSC
steps should be disabled. But, in this case, TSC is sampling the first Y
co-ordinate and all TSC steps are enabled.
REG_SE: 0x1ffc1
ADC_STAT: 0x24

Any idea why this may be happening?

Regards
Vignesh
