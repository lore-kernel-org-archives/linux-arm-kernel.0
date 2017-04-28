From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Apr 2017 12:03:29 +0200
Subject: [PATCH] IMX: Rearm watchdog after loading value for restart
In-Reply-To: <20170427131434.17085-1-Frederik.juul@3shape.com>
References: <20170427131434.17085-1-Frederik.juul@3shape.com>
Message-ID: <20170428120329.2dab740f@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 27 Apr 2017 15:14:34 +0200 frederikj at gmail.com wrote:
> When calling the restart function the watchdog is activated and the WDOG
> timeout field is set to 0. This gives a reset time of 500 ms, which is
> consistent with the following delay. However this new time is not loaded
> into the WDOG until the WDOG service routine is run (see IMX6SXRM section
> 70.5.1.1 "Servicing WDOG to reload the counter").
> 
> Not reloading the counter could result in a random delay up to 128 seconds
> before the system restarts, depending on the previous value of the WDOG
> timeout field and when it has last been serviced. That bug is fixed with
> this patch.
>
The routine is actually initiating a softreset by clearing the SRS bit
in WCR. Thus the watchdog timeout should only have any effect, if the
softreset fails in some way. Under normal circumstances the reset
should happen immediately no matter what watchdog timeout is programmed.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
