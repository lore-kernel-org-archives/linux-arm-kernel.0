From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 02 Apr 2013 16:37:36 +1100
Subject: [PATCH 2/6] rtc: rtc-m48t86: add hooks to support driver side
 memory mapping
In-Reply-To: <20130401234207.GL1953@edkhil>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
 <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
 <515A1A0B.8040803@gmail.com> <20130401234207.GL1953@edkhil>
Message-ID: <515A6EA0.1010700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/13 10:42, Alexander Clouter wrote:
> On Tue, Apr 02, 2013 at 10:36:43AM +1100, Ryan Mallon wrote:
>> On 02/04/13 10:22, Alexander Clouter wrote:
>>> If platform_data is not defined (as before), then named memory io
>>> ranges need to be defined ("rtc_index" and "rtc_data").  The driver
>>> then maps those regions and uses them as the RTC index and data
>>> addresses.
>>>
>>> Does compile with the following warnings, I cannot see the codepath
>>> affected myself:
>>> ----
>>> drivers/rtc/rtc-m48t86.c: In function ?m48t86_rtc_probe?:
>>> drivers/rtc/rtc-m48t86.c:180: warning: ?res_index? may be used
>>> uninitialized in this function
>>> drivers/rtc/rtc-m48t86.c:180: warning: ?res_data? may be used
>>> uninitialized in this function
>>
>> It is caused by the exit paths. If pdev->dev.platform_data is set, the
>> res_index and res_data are never initialised, but in the error case you
>> still for rtc_device_register you jump to out_io_data, which will then
>> dereference res_index/res_data. You need to make the exit paths
>> conditional on pdev->dev.platform_data (or init res_index/data to NULL
>> and make the release_mem_regions conditional on that).
> 
> However, the 'goto out_io_data' in the 'IS_ERR(priv->rtc)' is wrapped in
> a 'if (!pdev->dev.platform_data)', else we jump to out_free.

Ah right, I missed that. In that case, I can't see the problem either :-/.

> 
> I suspect I am probably missing something *too* obvious here for it to
> click?

It could be gcc being dumb, though this does seem a straight-forward
enough case for gcc to get it correct. It would be nice to get rid of
the warning though. Doing:

  struct resource *res_index = NULL; /* Avoid GCC warning */

Isn't too costly.

~Ryan
