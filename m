From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Dec 2016 18:09:08 +0000
Subject: [PATCH 3/3] rtc: armada38x: Prepare for being use on 64 bits
In-Reply-To: <20161208171010.29446-4-gregory.clement@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-4-gregory.clement@free-electrons.com>
Message-ID: <20161208180908.GL14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 06:10:10PM +0100, Gregory CLEMENT wrote:
> The drivers are supposed to be portable, however there are few assumption
> done here about the unsigned long size. Make sure we use the accurate
> width for the variable.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/rtc/rtc-armada38x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index b8a74ffaae80..c4138130febf 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -84,14 +84,14 @@ static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
>  }
>  
>  struct str_value_to_freq {
> -	unsigned long value;
> +	u32 value;
>  	u8 freq;
>  } __packed;
>  
> -static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
> +static u32 read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
>  {
> -	unsigned long value_array[SAMPLE_NR], i, j, value;
> -	unsigned long max = 0, index_max = SAMPLE_NR - 1;
> +	int i, j, index_max = SAMPLE_NR - 1;
> +	u32 value_array[SAMPLE_NR], value, max = 0;

Ah, I see my comments on patch 1 got addressed in patch 3... :)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
