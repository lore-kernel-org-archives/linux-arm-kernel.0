From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 Apr 2015 15:13:46 +0200
Subject: [PATCH] rtc: armada38x: Fix concurrency access in
 armada38x_rtc_set_time
In-Reply-To: <20150415192732.GB13105@lunn.ch>
References: <1429103633-24376-1-git-send-email-gregory.clement@free-electrons.com>
 <20150415192732.GB13105@lunn.ch>
Message-ID: <5531070A.7080105@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 15/04/2015 21:27, Andrew Lunn wrote:
> On Wed, Apr 15, 2015 at 03:13:53PM +0200, Gregory CLEMENT wrote:
>> While setting the time, the RTC TIME register should not be
>> accessed. However due to hardware constraints, setting the RTC time
>> involves sleeping during 100ms. This sleep was done outside the
>> critical section protected by the spinlock, so it was possible to read
>> the RTC TIME register and get an incorrect value. This patch
>> introduces a mutex for protecting the RTC TIME access, unlike the
>> spinlock it is allowed to sleep in a critical section protected by a
>> mutex. The RTC STATUS register can still be used from the interrupt
>> handler but it has no effect on setting the time.
> 
> Hi Gregory
> 
> There is the following comment in the code:
> 
>         /*
>          * Setting the RTC time not always succeeds. According to the
>          * errata we need to first write on the status register and
>          * then wait for 100ms before writing to the time register to be
>          * sure that the data will be taken into account.
>          */
> 
> The interrupt handler also writes to the STATUS register. So what
> happens if there is an interrupt during that 100ms and a second write
> to STATUS?


As I wrote in the commit log, the RTC STATUS register can still be used from
the interrupt handler but it has no effect on setting the time: between writing
0 in the RTC_STATUS register and writing the time in the RTC_TIME register,
writing anything in RTC_STATUS won't prevent to write the time successfully.


> 
> Maybe it is necessary to disable the RTC interrupt while setting the
> time?

It won't be necessary.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
