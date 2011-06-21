From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 21 Jun 2011 16:37:44 +0530
Subject: [PATCH 1/6] serial: samsung: Keep a copy of platform data in
	driver's private data
In-Reply-To: <BANLkTikLfbiL0ZpLiysA6qUxv8sj-AVS+A@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-2-git-send-email-thomas.abraham@linaro.org>
	<BANLkTikLfbiL0ZpLiysA6qUxv8sj-AVS+A@mail.gmail.com>
Message-ID: <BANLkTi=m9QYhVoj-e916D-u79ymZFTup4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 20 June 2011 21:24, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jun 20, 2011 at 5:02 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> The driver depends on pdev->dev.platform_data to retrive information
>> about the platform data even after the initialization. To add device
>> tree support, this has to be changed in way that the platform data
>> is avialable from driver's private data. This patch adds support
>> for keeping a copy of the plaform data in s3c24xx_uart_info and using
>> it when needed after the initialization.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/tty/serial/s5pv210.c | ? 12 ++++++++++--
>> ?drivers/tty/serial/samsung.c | ? 24 ++++++++++++++++++++----
>> ?drivers/tty/serial/samsung.h | ? ?4 +++-
>> ?3 files changed, 33 insertions(+), 7 deletions(-)
>
> Hi Thomas.
>
> Don't forget you need to cc Alan Cox and the linux-serial mailing list
> for tty driver patches.

Ok. I will do that when I submit the next version of the patch.

>
> Comments below...
>
>>
>> diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
>> index d6b2423..3b2021a 100644
>> --- a/drivers/tty/serial/s5pv210.c
>> +++ b/drivers/tty/serial/s5pv210.c
>> @@ -27,9 +27,13 @@

<snip>

>> + ? ? ? if (cfg) {
>> + ? ? ? ? ? ? ? memcpy((void *)&info->cfg, cfg, sizeof(struct s3c2410_uartcfg));
>
> "info->cfg = *cfg;" should be sufficient.
>
>> + ? ? ? ? ? ? ? info->cfg.clocks = kzalloc(sizeof(struct s3c24xx_uart_clksrc) *
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cfg->clocks_size, GFP_KERNEL);
>> + ? ? ? ? ? ? ? if (!info->cfg.clocks)
>> + ? ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
>> + ? ? ? ? ? ? ? memcpy(info->cfg.clocks, cfg->clocks,
>> + ? ? ? ? ? ? ? ? ? ? ? sizeof(struct s3c24xx_uart_clksrc) * cfg->clocks_size);
>> + ? ? ? }
>
> ewwh. There has to be a better way to do this. ?Part of the point of
> putting a copy of pdata into the private data structure is to simplify
> the driver so that kzallocing wouldn't be necessary. ?With that clock
> table, the driver actually gets more complex because both DT and
> non-DT paths now need to kzalloc a clock array.
>
> From what I can tell, the list of clocks on all mainlined platforms is
> a static array of one or two entries; min & max baud are always set to
> 0, and names are one of:
> - uclk & pclk
> - uclk
> - uclk1
> - fclk (with divisor either 10 or 0)
> - pclk_low & uclk1
>
> You could also make the clock structure a static array of 2 elements
> in the private data structure. ?That would simplify both this code and
> the followon DT patch.
>
> Also, peaking forward at what the 2nd patch does, I think that it
> might just be a little premature to try and decode the clock info from
> the DT. ?But I'll address that issue when replying to the second
> patch.

Thanks for the suggestion. I had not thought about these issues. One
possible option in this case is using Sylwester's suggestion of
changing exynos4 clkdev support to be similar to the omap clkdev
support. That way, an additional level of indirection is possible. The
uart driver could than be modified to lookup clock with generic names
like "uart_clksrc0", "uart_clksrc1" and "uart_clksrc2". With this,
there will be no need to pass clock names to the uart driver. I will
check if this can be done.

>
>> +
>> + ? ? ? cfg = &info->cfg;
>> ? ? ? ?if (cfg->hwport > CONFIG_SERIAL_SAMSUNG_UARTS) {
>> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: port %d bigger than %d\n", __func__,
>> ? ? ? ? ? ? ? ? ? ? ? cfg->hwport, CONFIG_SERIAL_SAMSUNG_UARTS);
>> + ? ? ? ? ? ? ? kfree(info->cfg.clocks);
>> ? ? ? ? ? ? ? ?return -ERANGE;
>> ? ? ? ?}
>>
>> @@ -1181,11 +1195,13 @@ EXPORT_SYMBOL_GPL(s3c24xx_serial_probe);
>> ?int __devexit s3c24xx_serial_remove(struct platform_device *dev)
>> ?{
>> ? ? ? ?struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
>> + ? ? ? struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>>
>> ? ? ? ?if (port) {
>> ? ? ? ? ? ? ? ?s3c24xx_serial_cpufreq_deregister(to_ourport(port));
>> ? ? ? ? ? ? ? ?device_remove_file(&dev->dev, &dev_attr_clock_source);
>> ? ? ? ? ? ? ? ?uart_remove_one_port(&s3c24xx_uart_drv, port);
>> + ? ? ? ? ? ? ? kfree(info->cfg.clocks);
>> ? ? ? ?}
>>
>> ? ? ? ?return 0;
>> diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
>> index a69d9a5..4f2f6f5 100644
>> --- a/drivers/tty/serial/samsung.h
>> +++ b/drivers/tty/serial/samsung.h
>> @@ -24,6 +24,9 @@ struct s3c24xx_uart_info {
>>
>> ? ? ? ?unsigned int ? ? ? ? ? ?has_divslot:1;
>>
>> + ? ? ? /* copy of platform data */
>
> I'd change this to "copy of /configuration/ data" since the data
> doesn't necessarily come from the platform_data pointer anymore.

Ok. I will change this. Thanks for reviewing the patches.

Thomas.
