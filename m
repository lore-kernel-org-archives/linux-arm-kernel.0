From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 02 Jan 2014 12:17:34 -0600
Subject: [GIT PULL] clk: socfpga: Clean-ups for 3.14
In-Reply-To: <20131229190529.21400.11997@quantum>
References: <1386976031-21651-1-git-send-email-dinguyen@altera.com>
 <20131229190529.21400.11997@quantum>
Message-ID: <52C5AD3E.7060000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 12/29/13 1:05 PM, Mike Turquette wrote:
> Quoting dinguyen at altera.com (2013-12-13 15:07:11)
>> Hi Mike,
>>
>> Please pull in these 3 patches that cleans up the SOCFPGA clock driver.
> Hi Dinh,
>
> Patch #2, "clk: socfpga: Look for the GPIO_DB_CLK by its offset" throws
> the following error during compilation:
>
> drivers/clk/socfpga/clk.c: In function ?socfpga_clk_recalc_rate?:
> drivers/clk/socfpga/clk.c:238:27: error: invalid operands to binary & (have ?void *? and ?int?)
>    if (socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
>                            ^
> make[3]: *** [drivers/clk/socfpga/clk.o] Error 1
> make[2]: *** [drivers/clk/socfpga] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/clk] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....
>
> Compilation can continue with the following change:
>
> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index 9350071..da6d82c 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -235,7 +235,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>  		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
>  		val &= div_mask(socfpgaclk->width);
>  		/* Check for GPIO_DB_CLK by its offset */
> -		if (socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
> +		if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
>  			div = val + 1;
>  		else
>  			div = (1 << val);
>
> I have not applied this change to the patch. Is there anything different
> way of handling this that you would prefer?

Let me clean this up and send you an updated pull request.

Thanks,
Dinh
>
> Regards,
> Mike
>
>> Thanks,
>>
>> Dinh
>>
>> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>>
>>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.14
>>
>> for you to fetch changes up to be4cf9f262a069a91d095b9c17aed44e12699236:
>>
>>   clk: socfpga: Remove socfpga_init_clocks (2013-12-13 16:54:38 -0600)
>>
>> ----------------------------------------------------------------
>> SOCFPGA clk cleanups for 3.14
>>
>> ----------------------------------------------------------------
>> Dinh Nguyen (3):
>>       clk: socfpga: Map the clk manager base address in the clock driver
>>       clk: socfpga: Look for the GPIO_DB_CLK by its offset
>>       clk: socfpga: Remove socfpga_init_clocks
>>
>>  arch/arm/mach-socfpga/socfpga.c |    5 -----
>>  drivers/clk/socfpga/clk.c       |   31 +++++++++++++++++--------------
>>  2 files changed, 17 insertions(+), 19 deletions(-)
>>
