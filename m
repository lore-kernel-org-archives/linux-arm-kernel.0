From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 5 May 2015 23:01:31 +0200
Subject: [rtc-linux] [PATCH v3 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <1430858661.9365.20.camel@perches.com>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
 <20150505200010.GP4276@piout.net>
 <1430858661.9365.20.camel@perches.com>
Message-ID: <20150505210131.GR4276@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2015 at 13:44:21 -0700, Joe Perches wrote :
> I suggest moving the time_after() test into the loop,
> use break; and remove the exit label too.
> 
> Maybe something like:
> 
> 	while (1) {
> 		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> 				  &data);
> 		if (ret < 0)
> 			break;
> 		if (!(data & RTC_BBPU_CBUSY))
> 			break;
> 		if (time_after(jiffies, timeout)) {
> 			ret = -ETIMEDOUT;
> 			break;
> 		}
> 		cpu_relax();
> 	}
> 
> 	return ret;

That certainly looks more readable.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
