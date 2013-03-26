From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Mar 2013 10:43:29 +0100
Subject: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
In-Reply-To: <20130326072458.GA7141@S2101-09.ap.freescale.net>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
 <20130326072458.GA7141@S2101-09.ap.freescale.net>
Message-ID: <51516DC1.1000807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 08:25 AM, Shawn Guo wrote:
> On Mon, Mar 25, 2013 at 06:55:30PM +0100, Daniel Lezcano wrote:
>> The initialization is done from the cpuidle framework.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
>> index 5ae22f7..a783a63 100644
>> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
>> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
>> @@ -6,7 +6,6 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> -#include <linux/clockchips.h>
> 
> Removing this causes the compile error below.
> 
>   CC      arch/arm/mach-imx/cpuidle-imx6q.o
> arch/arm/mach-imx/cpuidle-imx6q.c: In function ?imx6q_enter_wait?:
> arch/arm/mach-imx/cpuidle-imx6q.c:25:2: error: implicit declaration of function ?clockevents_notify? [-Werror=implicit-function-declaration]
> arch/arm/mach-imx/cpuidle-imx6q.c:25:21: error: ?CLOCK_EVT_NOTIFY_BROADCAST_ENTER? undeclared (first use in this function)
> arch/arm/mach-imx/cpuidle-imx6q.c:25:21: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm/mach-imx/cpuidle-imx6q.c:45:21: error: ?CLOCK_EVT_NOTIFY_BROADCAST_EXIT? undeclared (first use in this function)
> cc1: some warnings being treated as errors
> make[2]: *** [arch/arm/mach-imx/cpuidle-imx6q.o] Error 1


Hi Shawn,

actually this is because the patch applies on top of:

commit 12e849504b861470e5bf991f79c0be71b97c8dac
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu Mar 21 12:21:33 2013 +0000

    cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag

    Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
    to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
    this state.

    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
