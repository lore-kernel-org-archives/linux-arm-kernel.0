From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Aug 2012 14:14:42 +0800
Subject: [rtc-linux] [PATCH v3] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20524.43620.36859.792122@ipc1.ka-ro>
References: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
 <20120814170300.8f97afcf.akpm@linux-foundation.org>
 <20120815141606.GA2457@S2101-09.ap.freescale.net>
 <20120815133221.ca88d4ba.akpm@linux-foundation.org>
 <20524.43620.36859.792122@ipc1.ka-ro>
Message-ID: <20120817061439.GF24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 10:08:04AM +0200, Lothar Wa?mann wrote:
> Why not read the register once more in case of a timeout, which
> would guarantee to have a current view of the register contents no
> matter how long the process may have been descheduled before:
> 
> [...]
> static int snvs_rtc_enable_done(int enable, void __iomem *addr)
> {
> 	u32 lpcr = readl(addr + SNVS_LPCR);
> 
> 	return !!enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
> }
> [...]
> 	while (1) {
> 		if (svns_rtc_enable_done(enable, data->ioaddr))
> 			break;
> 
> 		if (time_after(jiffies, timeout)) {
> 			if (!svns_rtc_enable_done(enable, data->ioaddr))
> 				return -ETIMEDOUT;
> 		}
> 	}
> 
I'm fine with this solution.  Can you send a formal patch for this?
Then we will have two incremental patches (I already sent the fixed
times loop one) for Andrew to choose one.

-- 
Regards,
Shawn
