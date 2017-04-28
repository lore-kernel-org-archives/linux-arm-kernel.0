From: Frederik.Juul@3shape.com (Frederik Juul)
Date: Fri, 28 Apr 2017 12:45:15 +0000
Subject: [PATCH] IMX: Rearm watchdog after loading value for restart
In-Reply-To: <20170428120329.2dab740f@ipc1.ka-ro>
References: <20170427131434.17085-1-Frederik.juul@3shape.com>
 <20170428120329.2dab740f@ipc1.ka-ro>
Message-ID: <db36b4c832db4b75b4cb3fa7b19635f6@3shape.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disregard this patch then :) I had seen some strange behavior when toying with watchdog where it didn?t reset properly and wrote the "something went wrong" message. This patch fixed it for me, but I guess I may have misunderstood the issue.

Frederik Juul

-----Original Message-----
From: Lothar Wa?mann [mailto:LW at KARO-electronics.de] 
Sent: 28. april 2017 12:03
To: frederikj at gmail.com
Cc: linux-arm-kernel at lists.infradead.org; shawnguo at kernel.org; fabio.estevam at nxp.com; kernel at pengutronix.de; Frederik Juul <Frederik.Juul@3shape.com>
Subject: Re: [PATCH] IMX: Rearm watchdog after loading value for restart

Hi,

On Thu, 27 Apr 2017 15:14:34 +0200 frederikj at gmail.com wrote:
> When calling the restart function the watchdog is activated and the 
> WDOG timeout field is set to 0. This gives a reset time of 500 ms, 
> which is consistent with the following delay. However this new time is 
> not loaded into the WDOG until the WDOG service routine is run (see 
> IMX6SXRM section
> 70.5.1.1 "Servicing WDOG to reload the counter").
> 
> Not reloading the counter could result in a random delay up to 128 
> seconds before the system restarts, depending on the previous value of 
> the WDOG timeout field and when it has last been serviced. That bug is 
> fixed with this patch.
>
The routine is actually initiating a softreset by clearing the SRS bit in WCR. Thus the watchdog timeout should only have any effect, if the softreset fails in some way. Under normal circumstances the reset should happen immediately no matter what watchdog timeout is programmed.


Lothar Wa?mann
--
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de ___________________________________________________________
