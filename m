From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 20 Apr 2016 15:06:51 +0000
Subject: [PATCH V3] rtc: zynqmp: Update seconds time programming logic
In-Reply-To: <1461164331-13732-1-git-send-email-anuragku@xilinx.com>
References: <1461164331-13732-1-git-send-email-anuragku@xilinx.com>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E0B56D@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Made a small typo mistake , Please  ignore this patch. Sorry for the inconvenience caused. 

Thanks,
Anurag Kumar V 


> -----Original Message-----
> From: Anurag Kumar Vulisha [mailto:anurag.kumar.vulisha at xilinx.com]
> Sent: Wednesday, April 20, 2016 8:29 PM
> To: Alessandro Zummo <a.zummo@towertech.it>; Alexandre Belloni
> <alexandre.belloni@free-electrons.com>; Soren Brinkmann
> <sorenb@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; rtc-linux at googlegroups.com; linux-
> arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Punnaiah
> Choudary Kalluri <punnaia@xilinx.com>; Anirudha Sarangi
> <anirudh@xilinx.com>; Srikanth Vemula <svemula@xilinx.com>; Srinivas
> Goud <sgoud@xilinx.com>; Anurag Kumar Vulisha <anuragku@xilinx.com>
> Subject: [PATCH V3] rtc: zynqmp: Update seconds time programming logic
> 
> We programe RTC time using SET_TIME_WRITE register and read the RTC
> current time using CURRENT_TIME register. When we set the time by writing
> into SET_TIME_WRITE Register and immediately try to read the rtc time from
> CURRENT_TIME register, the previous old value is returned instead of the
> new loaded time. This is because RTC takes nearly 1 sec to update the  new
> loaded value into the CURRENT_TIME register. This behaviour is expected in
> our RTC IP.
> 
> This patch updates the driver to read the current time from SET_TIME_WRITE
> register instead of CURRENT_TIME when rtc time is requested within an 1sec
> period after setting the RTC time. Doing so will ensure the correct time is
> given to the user.
> 
> Since there is an delay of 1sec in updating the CURRENT_TIME we are loading
> set time +1sec while programming the SET_TIME_WRITE register, doing this
> will give correct time without any delay when read from CURRENT_TIME.
> 
> This patch updates the above said.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  Changes in v3:
>    1. Corrected the read time logic
>  Changes in v2:
>    1. Updated the Time programming logic as suggested by Alexandre Belloni
>    2. Changed the commit message
> ---
>  drivers/rtc/rtc-zynqmp.c | 44
> ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c index
> f87f971..c2f4495 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -64,7 +64,12 @@ static int xlnx_rtc_set_time(struct device *dev, struct
> rtc_time *tm)
>  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>  	unsigned long new_time;
> 
> -	new_time = rtc_tm_to_time64(tm);
> +	/*
> +	 * The value written will be updated after 1 sec into the
> +	 * seconds read register, so we need to program time +1 sec
> +	 * to get the correct time on read.
> +	 */
> +	new_time = rtc_tm_to_time64(tm) + 1;
> 
>  	if (new_time > RTC_SEC_MAX_VAL)
>  		return -EINVAL;
> @@ -78,14 +83,43 @@ static int xlnx_rtc_set_time(struct device *dev, struct
> rtc_time *tm)
> 
>  	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
> 
> +	/*
> +	 * Clear the rtc interrupt status register after setting the
> +	 * time. During a read_time function, the code should read the
> +	 * RTC_INT_STATUS register and if bit 0 is still 0, it means
> +	 * that one second has not elapsed yet since RTC was set and
> +	 * the current time should be read from SET_TIME_READ register;
> +	 * otherwise, CURRENT_TIME register is read to report the time
> +	 */
> +	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_STS);
> +
>  	return 0;
>  }
> 
>  static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)  {
> +	u32 status, read_time;
>  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> 
> -	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> +	status = readl(xrtcdev->reg_base + RTC_INT_STS);
> +
> +	if (status & RTC_INT_SEC) {
> +		/*
> +		 * RTC has updated the CURRENT_TIME with the time written
> into
> +		 * SET_TIME_WRITE register.
> +		 */
> +		rtc_time64_to_tm(readl(xrtcdev->reg_base +
> RTC_CUR_TM), tm);
> +	} else {
> +		/*
> +		 * Time written in SET_TIME_WRITE has not yet updated into
> +		 * the seconds read register, so read the time from the
> +		 * SET_TIME_WRITE instead of CURRENT_TIME register.
> +		 * Since we add +1 sec while writing, we need to -1 sec while
> +		 * reading.
> +		 */
> +		read_time = readl(xrtcdev->reg_base + RTC_SET_TM_RD) -
> 1;
> +		rtc_time64_to_tm(read_time, tm);
> +	}
> 
>  	return rtc_valid_tm(tm);
>  }
> @@ -166,11 +200,9 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
>  	if (!(status & (RTC_INT_SEC | RTC_INT_ALRM)))
>  		return IRQ_NONE;
> 
> -	/* Clear interrupt */
> -	writel(status, xrtcdev->reg_base + RTC_INT_STS);
> +	/* Clear RTC_INT_ALRM interrupt only */
> +	writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_STS);
> 
> -	if (status & RTC_INT_SEC)
> -		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
>  	if (status & RTC_INT_ALRM)
>  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> 
> --
> 2.1.2
