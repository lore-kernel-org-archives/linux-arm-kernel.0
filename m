From: venkappa.m@samsung.com (Venkappa Mala)
Date: Fri, 13 Feb 2015 04:36:25 +0000 (UTC)
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
Message-ID: <loom.20150213T053547-381@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nathan Lynch <nathan_lynch <at> mentor.com> writes:

> +#ifdef CONFIG_ARM_ARCH_TIMER
> +
> +static notrace u64 get_ns(struct vdso_data *vdata)
> +{
> +	u64 cycle_delta;
> +	u64 cycle_now;
> +	u64 nsec;
> +
> +	cycle_now = arch_counter_get_cntvct();

Hello Nathan,

Regarding ARM:vDSO, I have enabled your patch set on Cortex-A7/ARMv7, 
the vDSO is up and running using generic arch timer using physical 
counter but not with VCT.
I anticipate, the issue could be due to VCT cycles.

let me explain the problem first,
   The current validation system at the following state,
    
   commit 65b5732d241b8b39e07653794eefffd0d8028cbb(branch: linux-3.19.y)
   clocksource: arch_timer: Allow the device tree to specify 
uninitialized timer registers

    Some 32-bit (ARMv7) systems are architected like this:

    * The firmware doesn't know and doesn't care about hypervisor mode
      and we don't want to add the complexity of hypervisor there.

    * The firmware isn't involved in SMP bringup or resume.

    * The ARCH timer come up with an uninitialized offset (CNTVOFF)
      between the virtual and physical counters.  Each core gets a
      different random offset.

    * The device boots in "Secure SVC" mode .

    On systems like the above, it doesn't make sense to use the virtual
    counter.  There's nobody managing the offset and each time a core
    goes down and comes back up it will get reinitialized to some other
    random value.
                
    Based on the above, physical timer like this really only makes sense
    for ARMv7 systems. 

    To support vDSO on the above configuration,
        Will arch_counter_get_cntvct() work?
         OR
        Should we use arch_counter_get_cntpct()?

Perhaps, either we need to revise the vDSO frame work to choose VCT or 
PCT dynamically Otherwise CNTVOFF reset to be zero but CNTVOFF could not 
be accessed in SVC mode (PL1).
  
BR,
Venkappa
