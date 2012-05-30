From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 30 May 2012 16:00:15 +0800
Subject: [PATCH 02/10] spi: s3c64xx: move controller information into
 driver data
In-Reply-To: <CAOesGMjGfCH1T6WXPzMDLKsD=URdm15G1SDM=ac624KLmSS=4w@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-3-git-send-email-thomas.abraham@linaro.org>
 <CAOesGMjGfCH1T6WXPzMDLKsD=URdm15G1SDM=ac624KLmSS=4w@mail.gmail.com>
Message-ID: <CAJuYYwRn5R-qm7kv8D8pf6dfinNkDOdgJpMhqgsH2vVF-J9vUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 30 May 2012 15:23, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> Some comments below.
>
> On Tue, May 8, 2012 at 3:04 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Platform data is used to specify controller hardware specific information
>> such as the tx/rx fifo level mask and bit offset of rx fifo level. Such
>> information is not suitable to be supplied from device tree. Instead,
>> it can be moved into the driver data and removed from platform data.
>>
>> Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/spi/spi-s3c64xx.c | ?180 ++++++++++++++++++++++++++++++++++++++-------
>> ?1 files changed, 153 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 6a3d51a..f6bc0e3 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>
>> @@ -171,6 +198,8 @@ struct s3c64xx_spi_driver_data {
>> ? ? ? ?struct s3c64xx_spi_dma_data ? ? rx_dma;
>> ? ? ? ?struct s3c64xx_spi_dma_data ? ? tx_dma;
>> ? ? ? ?struct samsung_dma_ops ? ? ? ? ?*ops;
>> + ? ? ? struct s3c64xx_spi_port_config ?*port_conf;
>> + ? ? ? unsigned ? ? ? ? ? ? ? ? ? ? ? ?port_id;
>
> unsigned int

Ok.

>
>
>> @@ -942,6 +964,13 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
>> ? ? ? ?flush_fifo(sdd);
>> ?}
>>
>> +static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct platform_device *pdev)
>> +{
>> + ? ? ? return (struct s3c64xx_spi_port_config *)
>> + ? ? ? ? ? ? ? ? ? ? ? ?platform_get_device_id(pdev)->driver_data;
>> +}
>> +
>> ?static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>> ?{
>> ? ? ? ?struct resource *mem_res, *dmatx_res, *dmarx_res;
>> @@ -1000,6 +1029,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>> ? ? ? ?platform_set_drvdata(pdev, master);
>>
>> ? ? ? ?sdd = spi_master_get_devdata(master);
>> + ? ? ? sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
>> ? ? ? ?sdd->master = master;
>> ? ? ? ?sdd->cntrlr_info = sci;
>> ? ? ? ?sdd->pdev = pdev;
>
> Single-use helper? Might as well open code it in this case.

This helper function 's3c64xx_spi_get_port_config' is populated with
more code later in the 'add spi support' patch. Which simplifies the
code flow here. So I prefer to maintain this as a separate function.

>
>
>> @@ -1227,6 +1258,100 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
>> ? ? ? ? ? ? ? ? ? ? ? ? ? s3c64xx_spi_runtime_resume, NULL)
>> ?};
>>
>> +#if defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2443)
>> +struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
>> + ? ? ? .fifo_lvl_mask ?= { 0x7f },
>> + ? ? ? .rx_lvl_offset ?= 13,
>> + ? ? ? .tx_st_done ? ? = 21,
>> + ? ? ? .high_speed ? ? = true,
>> +};
>> +#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)&s3c2443_spi_port_config)
>> +#else
>> +#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
>> +#endif
>
> Is it really worth it to do the ifdefs here for just 16 bytes of data
> per entry? The table itself below takes more space.

Ok. The ifdefs do reduce the readability of this code. So I will leave
the ifdefs in this patch.

>
>
> [..]
>
>> +#ifdef CONFIG_ARCH_S5PV210
>> +struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
>> + ? ? ? .fifo_lvl_mask ?= { 0x1ff, 0x7F },
>> + ? ? ? .rx_lvl_offset ?= 15,
>> + ? ? ? .tx_st_done ? ? = 25,
>> + ? ? ? .high_speed ? ? = 1,
>
> high_speed = true
>
>> +};
>> +#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)&s5pv210_spi_port_config)
>> +#else
>> +#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
>> +#endif /* CONFIG_ARCH_S5PV210 */
>> +
>> +#ifdef CONFIG_ARCH_EXYNOS4
>> +struct s3c64xx_spi_port_config exynos4_spi_port_config = {
>> + ? ? ? .fifo_lvl_mask ?= { 0x1ff, 0x7F, 0x7F },
>> + ? ? ? .rx_lvl_offset ?= 15,
>> + ? ? ? .tx_st_done ? ? = 25,
>> + ? ? ? .high_speed ? ? = 1,
>
> high_speed = true

Ok.

Thanks for your comments.

Regards,
Thomas.

>
>
>
> -Olof
