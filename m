From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Mar 2015 18:52:47 +0000
Subject: [PATCH 5/5] arm-cci: Fix CCI PMU event validation
In-Reply-To: <1426000735-14375-6-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
 <1426000735-14375-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150317185247.GE8399@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 03:18:55PM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> We mask the event with the CCI_PMU_EVENT_MASK, before passing
> the config to pmu_validate_hw_event(), which causes extra bits
> to be ignored and qualifies an invalid event code as valid.
> 
> e.g,
>  $ perf stat -a -C 0 -e CCI_400/config=0x1ff,name=cycles/ sleep 1
>    Performance counter stats for 'system wide':
> 
>          506951142      cycles
> 
>        1.013879626 seconds time elapsed
> 
> where, cycles has an event coding of 0xff. This patch also removes
> the unnecessary 'event' mask in pmu_write_register, since the config_base
> is set by the pmu code after the event is validated.
> 
> Changes since V2:
>  - Switch to input unsigned long for pmu_validate_hw_event()
> 
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 581190d..89c86e9 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -179,12 +179,15 @@ enum cci400_perf_events {
>  #define CCI_REV_R1_MASTER_PORT_MIN_EV	0x00
>  #define CCI_REV_R1_MASTER_PORT_MAX_EV	0x11
>  
> -static int pmu_validate_hw_event(u8 hw_event)
> +static int pmu_validate_hw_event(unsigned long hw_event)
>  {
>  	u8 ev_source = CCI_PMU_EVENT_SOURCE(hw_event);
>  	u8 ev_code = CCI_PMU_EVENT_CODE(hw_event);
>  	int if_type;
>  
> +	if (hw_event & ~CCI_PMU_EVENT_MASK)
> +		return -ENOENT;

Given that you want to build this for arm64, shouldn't CCI_PMU_EVENT_MASK
be an unsigned long too (i.e. 0xffUL)? Otherwise you won't detect set bits
in the upper word here.

Will
