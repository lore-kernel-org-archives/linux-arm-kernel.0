From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 20 Apr 2018 09:24:04 +0200
Subject: [PATCH 46/61] spi: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-47-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-47-wsa+renesas@sang-engineering.com>
Message-ID: <80e6c822-094e-fded-d8bd-28f4cb7d14ad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/spi/spi-cadence.c      | 6 ++----
>  drivers/spi/spi-zynqmp-gqspi.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
> index 5c9516ae4942..de394422b611 100644
> --- a/drivers/spi/spi-cadence.c
> +++ b/drivers/spi/spi-cadence.c
> @@ -686,8 +686,7 @@ static int cdns_spi_remove(struct platform_device *pdev)
>   */
>  static int __maybe_unused cdns_spi_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  
>  	return spi_master_suspend(master);
>  }
> @@ -702,8 +701,7 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
>   */
>  static int __maybe_unused cdns_spi_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct cdns_spi *xspi = spi_master_get_devdata(master);
>  
>  	cdns_spi_init_hw(xspi);
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 18aeaceee286..3608db4ff368 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -918,8 +918,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
>   */
>  static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  
>  	spi_master_suspend(master);
>  
> @@ -939,8 +938,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
>   */
>  static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
>  	int ret = 0;
>  
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
