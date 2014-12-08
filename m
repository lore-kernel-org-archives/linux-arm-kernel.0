From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Mon, 08 Dec 2014 10:59:31 +0530
Subject: [PATCH] tick-broadcast: Register for hrtimer based broadcast
 as the default broadcast mode
In-Reply-To: <20141205133908.GA21313@leverpostej>
References: <20141205124756.25803.4988.stgit@preeti.in.ibm.com>
 <20141205133908.GA21313@leverpostej>
Message-ID: <5485373B.302@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 07:09 PM, Mark Rutland wrote:
> Hi Preeti,
> 
> Moving this out of the architecture code looks good to me!
> 
> I have a couple of minor comments below.
<snip>

>>  
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index ec1791f..6044a51 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1016,6 +1016,10 @@ void __init timekeeping_init(void)
>>  		boot.tv_sec = 0;
>>  		boot.tv_nsec = 0;
>>  	}
>> +	/* Register for hrtimer based broadcast as the default timekeeping
>> +	 * mode in deep idle states.
>> +	 */
> 
> Nit: for code style this should have a newline after the '/*' (and we
> should probably have a newline before that anyway.
> 
>> +	tick_setup_hrtimer_broadcast();
> 
> We register the generic dummy timer via an early_initcall, which keeps
> all the logic in the dummy timer driver. Are we able to do the same of
> the broadcast hrtimer? Or is there some ordering constraint we need to
> meet?

Yes this is doable. There are no ordering constraints. Placing it in an
early_initcall() will enable it to run before initializing SMP and
cpuidle, which is perfect (we do not have any per-cpu initializations
and we do not want cpus to begin entering idle states before this
hrtimer is initialized).

It also runs after the hrtimer/clockevents infrastructure has been
initialized, which is good since we need them. The broadcast hrtimer
will thus only get registered as a broadcast device if no other clock
device has managed to register itself as one.

Let me send out a V2.

Thanks

Regards
Preeti U Murthy
