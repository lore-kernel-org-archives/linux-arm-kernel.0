From: jason77.wang@gmail.com (Hui Wang)
Date: Sat, 8 Oct 2011 09:33:56 +0800
Subject: [PATCH] mx5: modify pm and idle
In-Reply-To: <20111003052458.GA21563@S2100-06.ap.freescale.net>
References: <1317364642-22956-1-git-send-email-jason77.wang@gmail.com>
	<20111003052458.GA21563@S2100-06.ap.freescale.net>
Message-ID: <4E8FA884.5010308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> On Fri, Sep 30, 2011 at 02:37:22PM +0800, Hui Wang wrote:
>   
>> Two problems exist in the current i.MX5 pm suspend/resume and idle
>> functions. The first is the current i.MX5 suspend routine will call
>>     
<snip>
>> MPGC1_SRPGCR);
>>  	}
>>  }
>> +
>> +void mx5_arch_idle(void)
>> +{
>> +		if (gpc_dvfs_clk == NULL)
>> +			gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
>> +
>> +		/* gpc clock is needed for SRPG */
>> +		clk_enable(gpc_dvfs_clk);
>> +		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
>> +		if (tzic_enable_wake() != 0)
>> +			goto exit;
>> +		cpu_do_idle();
>> +exit:
>> +		clk_disable(gpc_dvfs_clk);
>>     
>
> Bad indentation on entire function block (should be 1 tab rather than 2)
>
> Regards,
> Shawn
>
>   
Got it. I will fix it in the V2.

>> +}
>> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
>> index 0987923..c4d324a 100644
>> --- a/arch/arm/plat-mxc/include/mach/mxc.h
>> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
>> @@ -182,7 +182,7 @@ struct cpu_op {
>>  	u32 cpu_rate;
>>  };
>>  
>>     
