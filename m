From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 09 Aug 2012 10:05:50 +0300
Subject: [alsa-devel] [PATCH 07/11] ASoC: omap-mcbsp: Sidetone: Use SIDLE
 bits in SYSCONFIG register to select noidle mode
In-Reply-To: <5022E46A.4010909@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-8-git-send-email-peter.ujfalusi@ti.com>
 <5022E46A.4010909@ti.com>
Message-ID: <5023614E.3030308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ricardo,

On 08/09/2012 01:12 AM, Ricardo Neri wrote:
> Is this another case in which it is required to change the idle-mode on a
> per-use-case basis? In the past I was trying to do the same with HDMI [1]. In
> that case it was decided to add the HWMOD_SWSUP_SIDLE to hwmod data with the
> drawback of using no-idle/force-idle rather than smart-idle[2][3].

This only concerns use case on OMAP3 when the sidetone is in use. In all other
use cases we want to use smart-idle (music playback, FM TX/RX, etc).
The main problem here is that the sidetone block have broken sidle line, it
can not prevent McBSP iclk to be gated.
The sidetone block is using the ICLK of the McBSP port (OMAP3 has ST block
attached to McBSP2 and 3 ports only).


> [1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg60226.html
> [2] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70463.html
> [3] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70653.html
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   sound/soc/omap/mcbsp.c |   18 ++++++++++++++----
>>   sound/soc/omap/mcbsp.h |    1 +
>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
>> index c870023..e008898 100644
>> --- a/sound/soc/omap/mcbsp.c
>> +++ b/sound/soc/omap/mcbsp.c
>> @@ -257,8 +257,15 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
>>   {
>>       unsigned int w;
>>
>> -    if (mcbsp->pdata->enable_st_clock)
>> -        mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
>> +    /*
>> +     * Sidetone uses McBSP ICLK - which must not idle when sidetones
>> +     * are enabled or sidetones start sounding ugly.
>> +     */
>> +    w = MCBSP_READ(mcbsp, SYSCON);
>> +    mcbsp->st_data->mcbsp_sidle = (w >> 3) & 0x3;
>> +    w &= ~SIDLEMODE(0x3);
>> +    w |= SIDLEMODE(0x1);
>> +    MCBSP_WRITE(mcbsp, SYSCON, w);
> 
> Wouldn't this create a mismatch between the SYSCONFIG register and McBSP
> omap_hwmod._sysc_cache?

We modify the bits runtime (if the ST is enabled), after the hwmod already
configured the McBSP port to s-idle. We change the McBSP port's s-idle mode
back to it's original before pm_runtime_put().

Previously we did the same thing in PRCM level which was as ugly as this
workaround with the penalty of a callback function to mach-omap2 since we can
only got access to PRCM register API there.

> Perhaps this could be done with a future omap_hwmod API?

But there's no such an API and I'm not aware any ongoing effort to have one.
Still the issue mostly remains since we need to modify other block's s-idle
mode. If sidetone block is enabled we need to change the McBSP port's s-idle
mode to no-idle.

In most of the use cases the McBSP need to be in smart-idle mode since it
provides significant power saving.

-- 
P?ter
