From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 26 Jan 2015 14:34:38 +0100
Subject: [PATCH v2 02/12] pm: at91: Workaround DDRSDRC self-refresh bug
 with LPDDR1 memories.
In-Reply-To: <20150126103605.GA20837@gradator.net>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
 <1422265139-23011-1-git-send-email-wenyou.yang@atmel.com>
 <20150126103605.GA20837@gradator.net>
Message-ID: <54C6426E.9090808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/01/2015 11:36, Sylvain Rochet a ?crit :
> Hello Wenyou,
> 
> On Mon, Jan 26, 2015 at 05:38:59PM +0800, Wenyou Yang wrote:
>> From: Peter Rosin <peda@axentia.se>
>>
>> The DDRSDR controller fails miserably to put LPDDR1 memories in
>> self-refresh. Force the controller to think it has DDR2 memories
>> during the self-refresh period, as the DDR2 self-refresh spec is
>> equivalent to LPDDR1, and is correctly implemented in the
>> controller.
>>
>> Assume that the second controller has the same fault, but that is
>> untested.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/mach-at91/pm_slowclock.S  |   43 +++++++++++++++++++++++++++++++-----
>>  include/soc/at91/at91sam9_ddrsdr.h |    2 +-
>>  2 files changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
>> index e2bfaf5..1155217 100644
>> --- a/arch/arm/mach-at91/pm_slowclock.S
>> +++ b/arch/arm/mach-at91/pm_slowclock.S
>> @@ -100,6 +100,16 @@ ddr_sr_enable:
>>  	cmp	memctrl, #AT91_MEMCTRL_DDRSDR
>>  	bne	sdr_sr_enable
>>  
>> +	/* LPDDR1 --> force DDR2 mode during self-refresh */
> 
> I think we should explain we are dealing with an errata here, this is 
> not obvious at first sight, the patch summary may find its place here :-)

True but the problem is that this errata is not public yet, it will be
in a couple of weeks.

I have the feeling though that the commit message is pretty clear. We'll
maybe add that it"s an actual errata.

Bye,
-- 
Nicolas Ferre
