From: timo.kokkonen@offcode.fi (Timo Kokkonen)
Date: Tue, 05 May 2015 12:07:54 +0300
Subject: [PATCHv7 6/8] watchdog: imx2_wdt: Convert to use new core
 extensions
In-Reply-To: <55487FDB.6060708@pengutronix.de>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi>
 <55487B1D.1060108@pengutronix.de> <55487FDB.6060708@pengutronix.de>
Message-ID: <5548886A.4040905@offcode.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 05.05.2015 11:31, Marc Kleine-Budde wrote:
> On 05/05/2015 10:11 AM, Marc Kleine-Budde wrote:
>> On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
>>> Fill in the HW capabilities in watchdog_device structure and call
>>> watchdgog_init_params() to let watchdog core to init itself
>>> properly. The watchdog core can then ping stopped watchdog and the
>>> timer code in the driver can be removed.
>>>
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>
>> This patch changes the default behaviour of the imx watchdog. Without
>> the patch: If the system boot with watchdog enabled (by the bootloader),
>> the driver sets up a threads to pet the watchdog. With the patch,
>> imx2_wdt_ping() is called once during probe but the thread is not
>> started. There are no timeout or early_timeout paremters in the DT or in
>> the kernel command line.
>>
>> I don't like the old behaviour, but I think there are some setups that
>> rely on this feature.
>
> BTW: the start-thread-if-wd-is-active feature was added in:
>
>      faad5de0b104 watchdog: imx2_wdt: convert to watchdog core api
>

Yes, thanks for pointing this out. I didn't realize this was in place. 
So what we need to do is to tell the watchdog core the actual status of 
the watchdog HW, whether it is running or not. The core can then start 
the worker thread to ping the HW if needed.

I will fix this for the next patch version.

Thanks!
-Timo
