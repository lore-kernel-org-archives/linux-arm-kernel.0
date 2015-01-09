From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 9 Jan 2015 18:33:54 +0530
Subject: [PATCH v3 4/8] clk: Add clock driver for mb86s7x
In-Reply-To: <20150109123958.GJ12302@n2100.arm.linux.org.uk>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420802977-4126-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150109123958.GJ12302@n2100.arm.linux.org.uk>
Message-ID: <CAJe_ZhdH=xKjkGcX-9APaeEJveG-gT9UdHEG-J0PLTTaRwcbVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 18:09, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 09, 2015 at 07:29:37PM +0800, Vincent Yang wrote:
>> +static int mb86s7x_clclk_of_init(void)
>> +{
>> +     int cpu;
>> +     struct clk *clk;
>> +
>> +     for_each_possible_cpu(cpu) {
>> +             struct device *cpu_dev = get_cpu_device(cpu);
>> +
>> +             if (!cpu_dev) {
>> +                     pr_err("failed to get cpu%d device\n", cpu);
>> +                     continue;
>> +             }
>> +
>> +             clk = mb86s7x_clclk_register(cpu_dev);
>> +             if (IS_ERR(clk)) {
>> +                     pr_err("failed to register cpu%d clock\n", cpu);
>> +                     continue;
>> +             }
>> +             if (clk_register_clkdev(clk, NULL, dev_name(cpu_dev))) {
>> +                     pr_err("failed to register cpu%d clock lookup\n", cpu);
>> +                     continue;
>> +             }
>> +             pr_debug("registered clk for %s\n", dev_name(cpu_dev));
>> +     }
>> +
>> +     platform_device_register_simple("arm-bL-cpufreq-dt", -1, NULL, 0);
>> +
>> +     return 0;
>> +}
>> +module_init(mb86s7x_clclk_of_init);
>
> What is the effect of this initialising on platforms which are not
> a "mb86s7x" ?
>
Yeah, there should have been some check for node
"fujitsu,mb86s70-scb-1.0" that guarantees we have a remote+protocol
that this driver assumes.

Thanks
Jassi
