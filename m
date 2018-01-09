From: stefan@agner.ch (Stefan Agner)
Date: Tue, 09 Jan 2018 14:22:45 +0100
Subject: [PATCH 1/7] ARM: imx: add timer stop flag to ARM power off state
In-Reply-To: <20180109092232.GA26312@b29396-OptiPlex-7040>
References: <20180102164223.15230-1-stefan@agner.ch>
 <20180109092232.GA26312@b29396-OptiPlex-7040>
Message-ID: <ad09e651b944f56ddb167b20cd9995f6@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-09 10:22, Dong Aisheng wrote:
> On Tue, Jan 02, 2018 at 05:42:17PM +0100, Stefan Agner wrote:
>> When the CPU is in ARM power off state the ARM architected
>> timers are stopped. The flag is already present in the higher
>> power WAIT mode.
>>
>> This allows to use the ARM generic timer on i.MX 6UL/6ULL SoC.
>> Without the flag the kernel freezes when the timer enters the
>> first time ARM power off mode.
>>
>> Cc: Anson Huang <anson.huang@nxp.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> It seems ok at my side.
> Did you meet the real issue? If yes, how to reproduce?

Enable the timer added with Patch 5, use a U-Boot with this patchset
applied:
https://www.mail-archive.com/u-boot at lists.denx.de/msg273287.html

And boot... For me it freezed somewhere early during systemd boot phase,
presumably the first time the CPU got into this idle mode.

--
Stefan

> 
> Both mx6sx and mx6ul are using GPT which do not need that flag, suppose
> we should remove it, right?
> Anson can help confirm it.
> 
> Regards
> Dong Aisheng
> 
>> ---
>>  arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
>> index c5a5c3a70ab1..d0f14b761ff7 100644
>> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
>> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
>> @@ -89,6 +89,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
>>  			 */
>>  			.exit_latency = 300,
>>  			.target_residency = 500,
>> +			.flags = CPUIDLE_FLAG_TIMER_STOP,
>>  			.enter = imx6sx_enter_wait,
>>  			.name = "LOW-POWER-IDLE",
>>  			.desc = "ARM power off",
>> --
>> 2.15.1
>>
