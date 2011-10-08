From: jason77.wang@gmail.com (Hui Wang)
Date: Sat, 8 Oct 2011 09:34:43 +0800
Subject: [PATCH] mx5: modify pm and idle
In-Reply-To: <20111004074316.GK31404@pengutronix.de>
References: <1317364642-22956-1-git-send-email-jason77.wang@gmail.com>
	<20111004074316.GK31404@pengutronix.de>
Message-ID: <4E8FA8B3.80206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Fri, Sep 30, 2011 at 02:37:22PM +0800, Hui Wang wrote:
>   
>> Two problems exist in the current i.MX5 pm suspend/resume and idle
>> functions. The first is the current i.MX5 suspend routine will call
>> tzic_enable_wake(1) to set wake source, this will set all enabled
>> irq as wake source rather than those wake capable. The second
>> is i.MX5 idle will call mx5_cpu_lp_set() to prepare enter low power
>> mode, but it forgets to call wfi instruction to enter this mode.
>>
>> To fix these two problems, using generic irq chip pm interface and
>> adding a new function mx5_arch_idle().
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>     
>
> As shawn already pointed out this conflicts with the imx-cleanup
> branch. Can you rework this onto it? Shawn has reworked the SoC
> specific idle stuff, so this is different now.
>
> Also, please find a better subject for this patch. 'modify pm and idle'
> is not enough.
>
> Sascha
>
>   
Got it, OK.
>> ---
>>
>> This patch is basing on the latest imx-features branch.
>>
>> This patch is validated on the i.MX51 PDK board (CPU revision 2.0).
>>
>> Since both pm suspend/resume and idle has close relation with
>> mx5_cpu_lp_set() and tzic_enable_wake(), i choose to use one patch
>> instead of independent two to address existing problems.
>>
>>  arch/arm/mach-mx5/system.c              |   24 +++++++++++++++--
>>  arch/arm/plat-mxc/include/mach/mxc.h    |    2 +-
>>  arch/arm/plat-mxc/include/mach/system.h |    3 +-
>>  arch/arm/plat-mxc/tzic.c                |   42 ++++++++++++++++++++++---------
>>  4 files changed, 54 insertions(+), 17 deletions(-)
>>     
