From: zonque@gmail.com (Daniel Mack)
Date: Tue, 20 Dec 2011 11:00:31 +0100
Subject: [PATCH] ARM: OMAP: avoid NULL pointer dereference when no PMIC
 is configured
In-Reply-To: <4EEEF163.7030608@compulab.co.il>
References: <1324235628-26439-1-git-send-email-zonque@gmail.com>
 <4EEEF163.7030608@compulab.co.il>
Message-ID: <4EF05CBF.4010007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On 12/19/2011 09:10 AM, Igor Grinberg wrote:
> On 12/18/11 21:13, Daniel Mack wrote:
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap2/vp.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
>> index 66bd700..5407173 100644
>> --- a/arch/arm/mach-omap2/vp.c
>> +++ b/arch/arm/mach-omap2/vp.c
>> @@ -41,6 +41,11 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>>  	u32 val, sys_clk_rate, timeout, waittime;
>>  	u32 vddmin, vddmax, vstepmin, vstepmax;
>>  
>> +	if (!voltdm->pmic) {
>> +		pr_err("%s: No PMIC configured.\n", __func__, voltdm->name);
> 
> You are passing two parameters to pr_err(), but use only one...

Of course not. I wonder why the compiler didn't yell at me about that.

> Also, I don't know if this is the right thing to do here,
> so Cc'ed Paul and Kevin.

That is the other question ideed. In the case I was facing on a custom
board, I was running into this without any configured PMIC. Clearly,
derferencing a NULL pointer here is no good thing to do.



Thanks,
Daniel
