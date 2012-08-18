From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Sat, 18 Aug 2012 08:43:04 +0200
Subject: [rtc-linux] [PATCH v3] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120817061439.GF24242@S2101-09.ap.freescale.net>
References: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
 <20120814170300.8f97afcf.akpm@linux-foundation.org>
 <20120815141606.GA2457@S2101-09.ap.freescale.net>
 <20120815133221.ca88d4ba.akpm@linux-foundation.org>
 <20524.43620.36859.792122@ipc1.ka-ro>
 <20120817061439.GF24242@S2101-09.ap.freescale.net>
Message-ID: <20527.14712.202172.863404@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Thu, Aug 16, 2012 at 10:08:04AM +0200, Lothar Wa?mann wrote:
> > Why not read the register once more in case of a timeout, which
> > would guarantee to have a current view of the register contents no
> > matter how long the process may have been descheduled before:
> > 
> > [...]
> > static int snvs_rtc_enable_done(int enable, void __iomem *addr)
> > {
> > 	u32 lpcr = readl(addr + SNVS_LPCR);
> > 
> > 	return !!enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
> > }
> > [...]
> > 	while (1) {
> > 		if (svns_rtc_enable_done(enable, data->ioaddr))
> > 			break;
> > 
> > 		if (time_after(jiffies, timeout)) {
> > 			if (!svns_rtc_enable_done(enable, data->ioaddr))
> > 				return -ETIMEDOUT;
> > 		}
> > 	}
> > 
> I'm fine with this solution.  Can you send a formal patch for this?
> Then we will have two incremental patches (I already sent the fixed
> times loop one) for Andrew to choose one.
> 
What should I base this patch on?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
