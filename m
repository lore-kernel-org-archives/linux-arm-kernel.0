From: itooo@itooo.com (Greg)
Date: Tue, 07 May 2013 18:40:39 +0200
Subject: MVNETA irq with backport-3.8
In-Reply-To: <20130507181823.23342ffb@skate>
References: <51890C29.8000504@itooo.com> <20130507181823.23342ffb@skate>
Message-ID: <51892E87.5020903@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/05/2013 18:18, Thomas Petazzoni a ?crit :
> Dear Greg,
>
> On Tue, 07 May 2013 16:14:01 +0200, Greg wrote:
>
>> I'm trying to boot off the the backport-3.-8 kernel with armada-xp-db DT
>> file.
>>
>> When eth0 is brought up (I'm booting on NFS) the mvneta driver fails in
>> mvneta_open, with the following error :
>>> mvneta d0070000.ethernet eth0: cannot request irq 25
>> The oddness is this is not the actual IRQ to be requested, and the DTS
>> files explicitly specify the IRQ is 8 for this device.
>>
>> I'm not familiar with the DT system, where should I start looking to
>> find the source of the problem ?
> This issue should be fixed by:
>
> commit 7f23f62fc31c5c97947414c0937a72e08a947a41
> Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Date:   Wed Mar 20 16:09:35 2013 +0100
>
>      arm: mvebu: Use local interrupt only for the timer 0
>      
>      The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
>      managed the 28th first interrupts as local interrupt to match the
>      hardware specification. Among these interrupts there are the Gigabits
>      Ethernet ones used by the mvneta driver. Unfortunately the state of
>      the percpu_irq API prevents the driver to use it.
>      
>      Indeed the interrupts have to be freed when the .stop() function is
>      called. As the free_percpu_irq() function don't disable the interrupt
>      line, we have to do it on each CPU before calling this. The function
>      disable_percpu_irq() only disable the percpu on the current CPU and
>      there is no function which allows to disable a percpu irq on a given
>      CPU. Waiting for the extension of the percpu_irq API, this fix allows
>      to use again the mvneta driver.
>      
>      Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>      Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>      Tested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>      Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>
> which is part of the backport-3.8 branch, so I'm a bit confused. Are
> you sure you're using the latest backport-3.8 branch? If so, then I'll
> do a test here to check this.
>
By the way, the patch IS applied to the source tree I'm compiling.
I can see this in arch/arm/mach-mvebu/irq-armada-370-xp.c which is using 
ARMADA_370_XP_TIMER0_PER_CPU_IRQ instead of ARMADA_370_XP_MAX_PER_CPU_IRQS

Cheers,
