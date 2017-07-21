From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jul 2017 12:30:47 +0200
Subject: Under some conditions i.MX temperature is not read out from
 on-SOC temperature sensor
In-Reply-To: <249c7ea2-ace5-1297-2abb-258810ae88e1@ilbers.de>
References: <82812714-6658-efaf-599a-9556d5238e17@ilbers.de>
 <249c7ea2-ace5-1297-2abb-258810ae88e1@ilbers.de>
Message-ID: <1500633047.2999.40.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxim,

thank you for the patch and the analysis. I have some comments below.

On Fri, 2017-07-21 at 12:30 +0300, Maxim Yu. Osipov wrote:
> Hello, Shawn, Sascha,
> 
> We use yocto (with mainline kernel 4.4.18) for our i.MX 6SOLO-based 
> custom board. We use in-kernel thermal management framework with
> default thermal governor (step_wise) (drivers/thermal/imx-thermal.c) 
> with defined trip points:
> 
> imx_thermal 2000000.aips-bus:tempmon: Commercial CPU temperature grade - 
> max:95C critical:90C passive:85C
> 
> We heat up the board in climate chamber until temperature reaches 
> critical value (90C) and in-kernel thermal management powers it off. 
> After short period of time (when temperature is in range 
> passive(85C)...critical(90C), we power up the board again so the alarm 
> condition is met and imx_thermal interrupt fires up. When we try to read 
> out the temperature from corresponding sysfs file we permanently get the 
> error -EAGAIN:
> 
> root at mybox:/usr/lib/strace/ptest# ./strace cat 
> /sys/class/thermal/thermal_zone0/temp
> ...
> open("/sys/class/thermal/thermal_zone0/temp", O_RDONLY|O_LARGEFILE) = 3
> sendfile64(1, 3, NULL, 16777216)        = -1 EAGAIN (Resource 
> temporarily unavailable)
> read(3, 0x7ee5bc00, 4096)               = -1 EAGAIN (Resource 
> temporarily unavailable)
> brk(NULL)                               = 0x1ad9000
> brk(0x1afa000)                          = 0x1afa000
> write(2, "cat: read error: Resource tempor"..., 50cat: read error: 
> Resource temporarily unavailable
> 
> root at mybox:~# cat /proc/interrupts
>       CPU0        <snip>
>       271:          2       GPC  49 Level     imx_thermal
>       <snip>
> 
> There are a couple of workarounds to enforce the temperature file to be 
> readable. If we explicitly enable the thermal's mode via sysfs (echo 
> enabled > /sys/sys/class/therma/thermal_zone0/mode) the temperature file 
> becomes readable. The same applies to suspend/resume cycles - after 
> resume the temperature file is readable.
> 
> 
> Having analyzed/debugged the code (for both mainline and freescale's 
> trees) I figured out the reason of the problem:
> 
> In imx_thermal_probe() thermal alarm interrupt is enabled before 
> device's 'mode' field is set to THERMAL_DEVICE_ENABLED while the sensor 
> hardware is already powered up. If alarm condition is met -
> the interrupt immediately fires up. During (threaded) interrupt 
> processing imx_get_temp() is called. The field 'mode' is still set to 
> DISABLED, so imx_get_temp() processes such case by special way: sensor 
> is powered up,
> measurement is enabled, a reading is taken, after that measurement is 
> DISABLED and temperature sensor is POWERED DOWN.
> When processing of alarm interrupt ends, imx_thermal_probe() continues 
> and sets mode field to ENABLED, but in fact the device is powered off!
> 
> This leads to broken logic of further calls of imx_get_temp().
> 
> The consequences of this bug could be quite serious - the temperature is 
> not read out from the sensor, so in-kernel thermal management is useless 
> - the board is not powered off by thermal management when the CPU is 
> overheated.
> 
> 
> Attached is patch against current mainline kernel tree.

It would be preferable to have the patch sent inline. That way it would
be easier to comment on specifics. Also, as a thermal patch, this should
be sent to linux-pm at vger.kernel.org. The scripts/get_maintainers.pl
script in the kernel sources can help to find the relevant maintainers
and mailing lists.

I think the data->irq_enabled assignment should be moved up before the
call to devm_request_threaded_irq as well. If the interrupt triggers
immediately (and sets data->irq_enabled=false), and then
imx_thermal_probe returns (after setting data->irq_enabled=true) before
the threaded irq handler gets to run, imx_get_temp will not reenable the
interrupt at the end, if the temperature has just fallen below the alarm
temperature.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

best regards
Philipp
