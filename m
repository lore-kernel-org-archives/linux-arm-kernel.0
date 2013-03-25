From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 23:09:21 +0100
Subject: [PATCH 07/15] ARM: cpuidle: add init/exit routine
In-Reply-To: <20130325214203.GD631@lunn.ch>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org>
 <20130325190908.GC631@lunn.ch> <5150A378.60608@linaro.org>
 <20130325214203.GD631@lunn.ch>
Message-ID: <5150CB11.6090105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 10:42 PM, Andrew Lunn wrote:
>> If the DT binding was allowed, I *may* not be ARM specific but will
>> certainly used only by the ARM drivers as the x86 platform uses ACPI or
>> static tables.
> 
> And powerpc? Its powerpc that created DT, as far as i understand.
> 
> arch/powerpc/platforms/pseries/processor_idle.c
> 
> static int pseries_idle_devices_init(void)
> {
>         int i;
>         struct cpuidle_driver *drv = &pseries_idle_driver;
>         struct cpuidle_device *dev;
> 
>         pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
>         if (pseries_cpuidle_devices == NULL)
>                 return -ENOMEM;
> 
>         for_each_possible_cpu(i) {
>                 dev = per_cpu_ptr(pseries_cpuidle_devices, i);
>                 dev->state_count = drv->state_count;
>                 dev->cpu = i;
>                 if (cpuidle_register_device(dev)) {
>                         printk(KERN_DEBUG \
>                                 "cpuidle_register_device %d failed!\n", i);
>                         return -EIO;
>                 }
>         }
> 
>         return 0;
> }
> 
> 
> This looks pretty similar to the code you are consolidating. Can your
> 'ARM' code be made to work on powerpc?

Yes, it is very similar. I am aware of this code and the cpuidle code of
all others archs but for now there are *18* cpuidle drivers for ARM I
would like to consolidate in priority into a single one. When all of
them will be factored out, I will recheck with the other arch. That will
be easier to consolidate four archs: x86, arm, sh and powerpc.

May be in the meantime, someone will cleanup the non-ARM drivers and
make my life easier :)

In any case, I keep in mind there are other arch using cpuidle.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
