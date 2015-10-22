From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 22 Oct 2015 09:43:17 +0200 (CEST)
Subject: Problem about CPU stalling in hrtimer_intterrupts()
In-Reply-To: <56288585.40204@huawei.com>
References: <56288585.40204@huawei.com>
Message-ID: <alpine.DEB.2.11.1510220942010.4012@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015, Yang Yingliang wrote:
> I use the kernel-4.1.6 running on arm64.
> My testcase is that it calls clock_settime and clock_adjtime alternately with
> random params on each core. My system has 32 cores.
> 
> I found the cpu stalling in  hrtimer_intterrupts(). So I added some debug info
> in hrtimer_intterrupts() and found that the while loop runs 1020437660 times
> and takes 98761 jiffies(HZ=250).
> 
> Some debug log is here:
> ---start---
> Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830
> hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0
> timer:ffffffdffdec6138, timer->function:ffffffc000129b84
> Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830
> hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0

Something is rearming a timer over and over with expiry time in the
past.

Thanks,

	tglx
