From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jun 2017 22:21:53 +0100
Subject: [PATCH 12/51] rtc: coh901331: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-13-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-13-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <20170620212153.GN4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:35:20AM +0200, Benjamin Gaignard wrote:
> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: rtc-linux at googlegroups.com
> CC: linux-kernel at vger.kernel.org
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/rtc/rtc-coh901331.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
> index cfc4141..5645011 100644
> --- a/drivers/rtc/rtc-coh901331.c
> +++ b/drivers/rtc/rtc-coh901331.c
> @@ -80,7 +80,8 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
>  	clk_enable(rtap->clk);
>  	/* Check if the time is valid */
>  	if (readl(rtap->virtbase + COH901331_VALID)) {
> -		rtc_time_to_tm(readl(rtap->virtbase + COH901331_CUR_TIME), tm);
> +		rtc_time64_to_tm(
> +			(u64)readl(rtap->virtbase + COH901331_CUR_TIME), tm);
>  		clk_disable(rtap->clk);
>  		return rtc_valid_tm(tm);
>  	}
> @@ -88,7 +89,7 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
>  	return -EINVAL;
>  }
>  
> -static int coh901331_set_mmss(struct device *dev, unsigned long secs)
> +static int coh901331_set_mmss64(struct device *dev, time64_t secs)

Do you realise how stupid this is?  Here, you're implicitly truncating
the 64-bit time value to 32-bit when you write it into the register.
So, when your clock wraps past 7 February 2106 (*not* 2038), when you
next read it, you read a date in 1970.

Exactly the same happens with the existing implementation, so this
fixes nothing at all.  As I've said in my other mail, these changes
make it harder to fix the problem, because you're stuck with that
truncation - you can never do anything but truncate it.

Keeping the 32-bit conversion functions allows us to wind the date
progressively forward if we so choose.

Sure, if we don't want to maintain two conversion functions, then we
can define the 32-bit conversion functions in terms of the 64-bit
versions, but do _not_ get rid of them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
