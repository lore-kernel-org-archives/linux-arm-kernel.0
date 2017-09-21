From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Sep 2017 10:46:42 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920224522.GB20974@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
Message-ID: <20170921094641.GT20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 04:45:22PM -0600, Jason Gunthorpe wrote:
>  /**
>   * rtc_set_ntp_time - Save NTP synchronized time to the RTC
>   * @now: Current time of day
> + * @target_nsec: Output value indicating what now->tv_nsec

I'd suggest:

 * @target_nsec: pointer for desired now->tv_nsec value

>   *
>   * Replacement for the NTP platform function update_persistent_clock64
>   * that stores time for later retrieval by rtc_hctosys.
> @@ -20,28 +54,35 @@
>   *
>   * If temporary failure is indicated the caller should try again 'soon'
>   */
> -int rtc_set_ntp_time(struct timespec64 now)
> +int rtc_set_ntp_time(struct timespec64 now, long *target_nsec)
>  {
>  	struct rtc_device *rtc;
>  	struct rtc_time tm;
>  	int err = -ENODEV;
>  
> -	if (now.tv_nsec < (NSEC_PER_SEC >> 1))
> -		rtc_time64_to_tm(now.tv_sec, &tm);
> -	else
> -		rtc_time64_to_tm(now.tv_sec + 1, &tm);
> -
>  	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
> -	if (rtc) {
> +	if (!rtc)
> +		goto out_err;
> +
> +	/* The ntp code must call this with the correct value in tv_nsec, if
> +	 * it does not we update target_nsec and return EPROTO to make the ntp
> +	 * code try again later.
> +	 */
> +	*target_nsec = rtc->time_set_nsec;

Here, we want just the positive nanoseconds part of the desired offset
(iow, the value we want to see in now.tv_nsec):

	nsec = rtc->time_set_nsec % NSEC_PER_SEC;
	if (nsec < 0)
		nsec += NSEC_PER_SEC;
	*target_nsec = nsec;

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
