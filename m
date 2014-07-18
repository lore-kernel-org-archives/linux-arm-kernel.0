From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 18 Jul 2014 08:16:02 +0200
Subject: [PATCH] ARM: rockchip: Add cpu hotplug support for RK3XXX SoCs
In-Reply-To: <20140717221436.GZ21766@n2100.arm.linux.org.uk>
References: <1405617110-1136-1-git-send-email-romain.perier@gmail.com>
 <20140717221436.GZ21766@n2100.arm.linux.org.uk>
Message-ID: <53C8BBA2.7060308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

you're probably talking about __cpu_die at 
http://lxr.free-electrons.com/source/arch/arm/kernel/smp.c#L223 . The 
problem being that the thread below which executes cpu_die completes the 
completion before executing smp_ops.cpu_die. So smp_ops.cpu_kill might 
be executed before smp_ops.cpu_die (in some cases cache coherency would 
not be turned off). Note that almost all SoCs do the same thing.


On 18/07/2014 00:14, Russell King - ARM Linux wrote:
> On Thu, Jul 17, 2014 at 05:11:50PM +0000, Romain Perier wrote:
>> +static DECLARE_COMPLETION(cpu_died);
>> +
>> +static int rockchip_cpu_kill(unsigned int cpu)
>> +{
>> +	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(1000))) {
>> +		pr_err("CPU%d: didn't die correctly\n", cpu);
>> +		return 0;
>> +	}
> Please explain the point of this cpu_died thing.
>
> I think you should read arch/arm/kernel/smp.c, searching for cpu_died
> in there.
>
