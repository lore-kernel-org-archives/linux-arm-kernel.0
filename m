From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Mar 2013 22:42:03 +0100
Subject: [PATCH 07/15] ARM: cpuidle: add init/exit routine
In-Reply-To: <5150A378.60608@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org>
 <20130325190908.GC631@lunn.ch> <5150A378.60608@linaro.org>
Message-ID: <20130325214203.GD631@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If the DT binding was allowed, I *may* not be ARM specific but will
> certainly used only by the ARM drivers as the x86 platform uses ACPI or
> static tables.

And powerpc? Its powerpc that created DT, as far as i understand.

arch/powerpc/platforms/pseries/processor_idle.c

static int pseries_idle_devices_init(void)
{
        int i;
        struct cpuidle_driver *drv = &pseries_idle_driver;
        struct cpuidle_device *dev;

        pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
        if (pseries_cpuidle_devices == NULL)
                return -ENOMEM;

        for_each_possible_cpu(i) {
                dev = per_cpu_ptr(pseries_cpuidle_devices, i);
                dev->state_count = drv->state_count;
                dev->cpu = i;
                if (cpuidle_register_device(dev)) {
                        printk(KERN_DEBUG \
                                "cpuidle_register_device %d failed!\n", i);
                        return -EIO;
                }
        }

        return 0;
}


This looks pretty similar to the code you are consolidating. Can your
'ARM' code be made to work on powerpc?

     Andrew
