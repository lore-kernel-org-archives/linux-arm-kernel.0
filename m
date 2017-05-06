From: Andrew.Pinski@cavium.com (Pinski, Andrew)
Date: Sat, 6 May 2017 17:38:52 +0000
Subject: [PATCH 2/2] arm64:vdso: Remove ISB from gettimeofday.
In-Reply-To: <CY4PR07MB3415D0B108BE622CF94B205893E80@CY4PR07MB3415.namprd07.prod.outlook.com>
References: <1492991221-5156-1-git-send-email-apinski@cavium.com>
 <1492991221-5156-2-git-send-email-apinski@cavium.com>
 <7ac07a75-ec3b-d05e-061c-5efab751ae2b@jonmasters.org>
 <CY4PR07MB3415D0B108BE622CF94B205893E80@CY4PR07MB3415.namprd07.prod.outlook.com>
Message-ID: <CY4PR07MB34154B8FDA4C88F153FF8D5A93E80@CY4PR07MB3415.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry sending again as plain text (I did not notice that before).

On 5/6/2017 9:29 AM, Jon Masters wrote:
On 04/23/2017 07:47 PM, Andrew Pinski wrote:
> ISB is normally required before mrs CNTVCT if we want the
> mrs to completed after the loads. In this case it is not.
> As we are taking the difference and if that difference
> was going to be negative, we just use the last counter value
> instead.
> 
> Signed-off-by: Andrew Pinski <apinski@cavium.com>

Humor me. Walk me through this?

Here is what the ARM ARM says (D6.1.3):
Reads of CNTVCT_EL0 can occur speculatively and out of order relative to other instructions executed on the same PE.
For example, if a read from memory is used to obtain a signal from another agent that indicates that CNTVCT_EL0 must be read, an ISB must be used to ensure that the read of CNTVCT_EL0 occurs after the signal has been read from memory
--- CUT ---

So we could have the read of the virtual timer happen before the reading of the cycles last field of the vdso data.? In the current code, there is an ISB which forces that case not to happen.? Without the ISB it could happen but since we know the time (virtual timer) cannot go backwards, we just take the last cycle field as the current time; this could happen when the last cycle field was updated from another core.? I hope this walk through a little better than my original description.

Basically the current virtual timer is either newly read value or the read from last cycle counter.

Thanks,
Andrew Pinski


> ---
>? arch/arm64/kernel/vdso/gettimeofday.c | 14 ++++++++++++--
>? 1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso/gettimeofday.c b/arch/arm64/kernel/vdso/gettimeofday.c
> index a0ab8b1..cf3235a 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.c
> +++ b/arch/arm64/kernel/vdso/gettimeofday.c
> @@ -117,10 +117,20 @@ static notrace u64 get_clock_shifted_nsec(u64 cycle_last, u64 mult)
>??????? u64 res;
>? 
>??????? /* Read the virtual counter. */
> -???? isb();
> +???? /*
> +????? * This normally requires an ISB but since we know the
> +????? * read of the last cycle will always be after the
> +????? * read of the values are valid word.
> +????? */
>??????? asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
>? 
> -???? res = res - cycle_last;
> +???? /*
> +????? * If the current cycle is greater than the last,
> +????? *? then get the difference.
> +????? */
> +???? if (res > cycle_last)
> +???????????? res = res - cycle_last;
> +
>??????? /* We can only guarantee 56 bits of precision. */
>??????? res &= ~(0xff00ul<<48);
>??????? return res * mult;
> 


-- 
Computer Architect
