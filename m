From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Sun, 30 Jun 2013 10:42:35 +0200
Subject: [PATCH v3 1/5] rtc: mxc_rtc: Driver re
 work
In-Reply-To: <1372580813.432068011@f179.mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
 <20130630075234.GE10414@pengutronix.de>
 <1372580813.432068011@f179.mail.ru>
Message-ID: <20943.61307.796422.302951@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexander Shiyan writes:
> > On Sat, Jun 29, 2013 at 12:40:40PM +0400, Alexander Shiyan wrote:
> > > This patch rework mxc_rtc driver.
> > > Major changes have been made:
> > > - Added second clock support (optional) which permit module functionality.
> > > - Implemented support for periodic interrupts.
> > > - Some code have been optimized.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> ...
> > > -static inline int is_imx1_rtc(struct rtc_plat_data *data)
> > > -{
> > > -	return data->devtype == IMX1_RTC;
> > > -}
> > 
> > What is wrong with this function?
> 
> All good here. This call is used only once in set_mmss, so no reason
> to have separate function.
> I agree that we can make it in a separate patch, but the optimization of the
> code is specified in the changelog.
> 
That's an inline function anyway. There should be no difference in
code with or without this function. Only difference in source code
readability.

> > > +	pdata->rtc_ops.open		= mxc_rtc_open;
> > > +	pdata->rtc_ops.release		= mxc_rtc_release;
> > > +	pdata->rtc_ops.read_time	= mxc_rtc_read_time;
> > > +	pdata->rtc_ops.set_mmss		= mxc_rtc_set_mmss;
> > > +	pdata->rtc_ops.read_alarm	= mxc_rtc_read_alarm;
> > > +	pdata->rtc_ops.set_alarm	= mxc_rtc_set_alarm;
> > > +	pdata->rtc_ops.alarm_irq_enable	= mxc_rtc_alarm_irq_enable;
> > 
> > So struct rtc_class_ops is embedded into struct rtc_plat_data now. Why
> > is this necessary?
> 
> Just save BSS. Can be moved into cleanup part.
> 
The purpose of platform_data is to convey platform specific
information to drivers, not a general driver local storage.
Thus platform_data should be treated read-only by drivers.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
