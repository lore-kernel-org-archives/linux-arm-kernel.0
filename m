From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 28 Oct 2016 12:49:08 -0700
Subject: [PATCH v2 5/5] fpga manager: cyclone-ps-spi: make delay variable
In-Reply-To: <20161028174142.GA18325@live.com>
References: <cover.1477669744.git.stillcompiling@gmail.com>
 <2239ffc8aba7d053825d2bea122a3c16cdd9f6e1.1477669745.git.stillcompiling@gmail.com>
 <20161028174142.GA18325@live.com>
Message-ID: <5f349105-8567-0baf-fbda-71aca35f0c39@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

Thanks for the review.


On 10/28/2016 10:41 AM, Moritz Fischer wrote:
> Hi Joshua,
>
> looks good to me; however, I think since you're adding initial support,
> I'd squash this together with [3/5].
I agree. I didn't want to squash it in before putting it up for review, though.
>
> On Fri, Oct 28, 2016 at 09:56:42AM -0700, Joshua Clayton wrote:
>> The status pin may not show ready in the time described in the
>> Altetera manual. check the value several times before giving up
> s/Altetera/Altera
Thanks. I'll fix this. And it will go away when it gets squashed.
>> For the hardware I am working on, the status pin takes 250 us,
>> 5 times as long as described by Altera.
>>
>> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
>> ---
>>  drivers/fpga/cyclone-ps-spi.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/fpga/cyclone-ps-spi.c b/drivers/fpga/cyclone-ps-spi.c
>> index 4b70d5c..c368223 100644
>> --- a/drivers/fpga/cyclone-ps-spi.c
>> +++ b/drivers/fpga/cyclone-ps-spi.c
>> @@ -20,6 +20,7 @@
>>  
>>  #define FPGA_RESET_TIME		50   /* time in usecs to trigger FPGA config */
>> -#define FPGA_MIN_DELAY		250  /* min usecs to wait for config status */
>> +#define FPGA_MIN_DELAY		50   /* min usecs to wait for config status */
>> +#define FPGA_MAX_DELAY		1000 /* max usecs to wait for config status */
>>  
>>  struct cyclonespi_conf {
>>  	struct gpio_desc *config;
>> @@ -42,6 +43,7 @@ static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
>>  				 const char *buf, size_t count)
>>  {
>>  	struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
>> +	int i;
>>  
>>  	if (flags & FPGA_MGR_PARTIAL_RECONFIG) {
>>  		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
>> @@ -56,13 +58,14 @@ static int cyclonespi_write_init(struct fpga_manager *mgr, u32 flags,
>>  	}
>>  
>>  	gpiod_set_value(conf->config, 1);
>> -	usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
>> -	if (gpiod_get_value(conf->status) == 0) {
>> -		dev_err(&mgr->dev, "Status pin not ready.\n");
>> -		return -EIO;
>> +	for (i = 0; i < (FPGA_MAX_DELAY / FPGA_MIN_DELAY); i++) {
>> +		usleep_range(FPGA_MIN_DELAY, FPGA_MIN_DELAY + 20);
>> +		if (gpiod_get_value(conf->status))
>> +			return 0;
>>  	}
>>  
>> -	return 0;
>> +	dev_err(&mgr->dev, "Status pin not ready.\n");
>> +	return -EIO;
>>  }
>>  
>>  static void rev_buf(void *buf, size_t len)
>> -- 
>> 2.7.4
>>
> Cheers,
>
> Moritz
Joshua
