From: rogerq@ti.com (Roger Quadros)
Date: Fri, 9 May 2014 11:23:32 +0300
Subject: omap4-panda-es boot issues with v3.15-rc4
In-Reply-To: <7hha4zsyro.fsf@paris.lan>
References: <536B7E44.2040303@ti.com>
 <7hppjos2w2.fsf@paris.lan>	<CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>	<20140508165558.GB2198@atomide.com>	<20140508184055.GC2198@atomide.com>
 <7hha4zsyro.fsf@paris.lan>
Message-ID: <536C9084.50209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On 05/09/2014 01:15 AM, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> [...]
> 
>> ..but I think I found the cause for recent hangs on panda, just a wild
>> guess based on looking at the recent cpuidle patches after v3.14.
>>
>> Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
>> until all coupled CPUs leave idle) makes booting work reliably again
>> on panda.
>>
>> Can you guys confirm, so far no issues here after few boot tests,
>> but it might be too early to tell.
> 
> Reverting that makes things a bit more stable, but it still eventually
> fails in the same way.  For me it took 8 boots for it to eventually
> fail.
> 
> However, if I build with CONFIG_CPU_IDLE=n, it becomes much more stable
> (20+ boots in a row and still going.)
> 

Can you please test with CPU_IDLE enabled but C3 disabled as in below patch?
It worked for me 10/10 boots.

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 01fc710..99362ff 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -206,7 +206,12 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.desc = "CPUx OFF, MPUSS OSWR",
 		},
 	},
-	.state_count = ARRAY_SIZE(omap4_idle_data),
+/*
+ * 	Disable C3 state since it is unstable
+ *
+ *	.state_count = ARRAY_SIZE(omap4_idle_data),
+ */
+	.state_count = 2,
 	.safe_state_index = 0,
 };
 
