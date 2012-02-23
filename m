From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 10:26:27 +0000
Subject: [PATCH v2 3/7] rtc: sa1100: use ioremap to map registers
In-Reply-To: <1329967709-3786-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
 <1329967709-3786-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120223102627.GM22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 11:28:29AM +0800, Haojian Zhuang wrote:
>  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> -	rtc_time_to_tm(RCNR, tm);
> +	struct sa1100_rtc *info = dev_get_drvdata(dev);
> +	unsigned long rcnr;
> +
> +	rcnr = readl_relaxed(info->reg_rcnr);
> +	rtc_time_to_tm(rcnr, tm);

Just one nit - this could be:

	struct sa1100_rtc *info = dev_get_drvdata(dev);

	rtc_time_to_tm(readl_relaxed(info->reg_rcnr), tm);
