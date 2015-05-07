From: timo.kokkonen@offcode.fi (Timo Kokkonen)
Date: Thu, 07 May 2015 10:39:17 +0300
Subject: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core
 extensions
In-Reply-To: <20150507073029.GD12306@pengutronix.de>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
 <20150503185601.GD25193@pengutronix.de> <55470AA7.9050605@offcode.fi>
 <20150504070452.GE25193@pengutronix.de> <554B0964.9030501@offcode.fi>
 <20150507073029.GD12306@pengutronix.de>
Message-ID: <554B16A5.1040205@offcode.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.05.2015 10:30, Uwe Kleine-K?nig wrote:
> Hello Timo,
>
> On Thu, May 07, 2015 at 09:42:44AM +0300, Timo Kokkonen wrote:
>> On 04.05.2015 10:04, Uwe Kleine-K?nig wrote:
>>> On Mon, May 04, 2015 at 08:59:03AM +0300, Timo Kokkonen wrote:
>>>> Hi, 03.05.2015 21:56, Uwe Kleine-K?nig wrote:
>>>>> On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
>>>>>> +static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
>>>>>> +{
>>>>>> +	void __iomem *base = wdev->base;
>>>>>> +
>>>>>> +	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
>>>>>> +}
>>>>> This isn't reliable. The sequence needed to enable the watchdog is
>>>>> 	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
>>>>> 	writel(0x4444, base + OMAP_WATCHDOG_SPR);
>>>>>
>>>>> The sequence to stop is:
>>>>> 	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
>>>>> 	writel(0x5555, base + OMAP_WATCHDOG_SPR);
>>>>>
>>>>> But:
>>>>>
>>>>> barebox at TI AM335x BeagleBone black:/ md 0x44e35048+4
>>>>> 44e35048: 00005555                                           UU..
>>>>> barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
>>>>> barebox at TI AM335x BeagleBone black:/ md 0x44e35048+4
>>>>> 44e35048: 00004444                                           DD..
>>>>>
>>>>> So the register contains 0x4444 but the timer doesn't run. So at best
>>>>> testing for 0x4444 is a good heuristic.
>>>>
>>>> Yeah.. I don't think we can get any better than that. Unless we
>>>> start checking the counter register and see whether it really counts
>>>> or not, and I think that's a bit overkill.. So I'd say we should be
>>>> safe when assuming bootloader is doing things correctly. Although,
>>>> we could add a comment to the code that the test may not be 100%
>>>> reliable in case the start sequence have not been issued properly.
>>>>
>>>> Thanks for pointing this out!
>>> It doesn't seem to much overhead to do:
>>>
>>> 	/*
>>> 	 * There is no register that tells us if the timer is running,
>>> 	 * so we have to resort to sample twice. The minimal frequency
>>> 	 * is 256 Hz (32768 Hz prescaled with 2**7).
>>> 	 */
>>> 	counter1 = readl(base + OMAP_WATCHDOG_CCR);
>>> 	mdelay(4);
>>> 	counter2 = readl(base + OMAP_WATCHDOG_CCR);
>>> 	return counter1 != counter2;
>>>
>>> I'd say it's even worth to do:
>>>
>>> 	cntrl = readl(base + OMAP_WATCHDOG_CNTRL);
>>> 	if (cntrl & (1 << 5))
>>> 		shift = (cntrl >> 2) & 0x7;
>>> 	else
>>> 		shift = 0;
>>> 	counter1 = readl(base + OMAP_WATCHDOG_CCR);
>>> 	udelay(31 << shift);
>>> 	counter2 = readl(base + OMAP_WATCHDOG_CCR);
>>> 	return counter1 != counter2;
>>>
>>> For some bonus points add some defines for the magic constants.
>>>
>>> This is save as the OMAP_WATCHDOG_CNTRL doesn't seem to accept reads
> s/reads/writes/ in the above line.
>
>>> while the counter is running. Maybe even this could be used to detect a
>>> running timer?:
>>
>> Maybe, but you will get a data abort when the HW doesn't accept a
>> read. How do you recover from that?
>>
>> Also, it seems that for some reason the watchdog HW is very picky
>> about which registers can be read in what condition. If I add the
>> code to read watchdog counter register, I will get a data abort
>> later at the end of the probe when the watchdog revision is read. I
>> don't understand why that happens, this does not seem logica. Maybe
>> it has got something to do with the fact that the watchdog is
>> stopped? If I can't read the counter register, I can't really
>> implement the above heuristic.. Any ideas?
> Which SoC do you use for your tests? Sounds strange. If you provide me
> your wip patch I can take a look.
>

I tried it on BeagleBone which has am35xx

I tried both approaches and neither were working:

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index f86775e..b929c83 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -41,6 +41,7 @@
  #include <linux/slab.h>
  #include <linux/pm_runtime.h>
  #include <linux/platform_data/omap-wd-timer.h>
+#include <linux/delay.h>

  #include "omap_wdt.h"

@@ -81,6 +82,31 @@ static void omap_wdt_reload(struct omap_wdt_dev *wdev)
  static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
  {
  	void __iomem *base = wdev->base;
+	unsigned long cntrl, counter1, counter2, shift;
+       /*
+	* There is no register that tells us if the timer is running,
+	* so we have to resort to sample twice. Use shortest delay
+	* depending on the actual prescaling value.
+	*
+	* Note! If bootloader configured a very large prescaler
+	* value, we might delay up to 4ms here. If that happens, you
+	* are better to fix your bootloader anyway!
+	*/
+
+	/*
+	cntrl = readl_relaxed(base + OMAP_WATCHDOG_CNTRL);
+	if (cntrl & (1 << 5))
+		shift = (cntrl >> 2) & 0x7;
+	else
+		shift = 0;
+	*/
+
+	counter1 = readl_relaxed(base + OMAP_WATCHDOG_CRR);
+	/*udelay(31 << shift);*/
+	msleep(4);
+	counter2 = readl_relaxed(base + OMAP_WATCHDOG_CRR);
+
+	return counter1 != counter2;

  	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
  }
