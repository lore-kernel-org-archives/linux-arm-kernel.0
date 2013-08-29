From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 29 Aug 2013 20:20:48 +0200
Subject: [PATCH RFC v2 16/16] ARM: zynq: Don't call of_clk_init()
In-Reply-To: <201308291537.54608.arnd@arndb.de>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-17-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308291537.54608.arnd@arndb.de>
Message-ID: <521F9100.4070107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/13 15:37, Arnd Bergmann wrote:
> On Tuesday 27 August 2013, Sebastian Hesselbarth wrote:
>> @@ -58,10 +57,10 @@ static void __init zynq_init_machine(void)
>>          of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
>>   }
>>
>> -static void __init zynq_timer_init(void)
>> +static void __init zynq_init_irq(void)
>>   {
>> +       irqchip_init();
>>          zynq_slcr_init();
>> -       clocksource_of_init();
>>   }
>>
>>   static struct map_desc zynq_cortex_a9_scu_map __initdata = {
>> @@ -104,8 +103,8 @@ static const char * const zynq_dt_match[] = {
>>   DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
>>          .smp            = smp_ops(zynq_smp_ops),
>>          .map_io         = zynq_map_io,
>> +       .init_irq       = zynq_init_irq,
>>          .init_machine   = zynq_init_machine,
>> -       .init_time      = zynq_timer_init,
>>          .dt_compat      = zynq_dt_match,
>>          .restart        = zynq_system_reset,
>>   MACHINE_END
>
> It looks like we are not getting any closer to removing all callbacks here,
> since you add one in order to remove another, and after the patch we do
> more things "early", which we try to avoid. I think we're better off without
> this particular patch.

Right.

Have you seen Soeren requesting to move of_clk_init(NULL) under the
else branch of arch-wide .init_time? In the proposed patch it is called
unconditionally before any mach specific callback.

Moving it to what gets called if no mach specific callback is set,
would allow zynq (and others) to still have their own callback where
they can probe clocks whenever they want to.

Sebastian
