From: brijeshkumar.singh@amd.com (Brijesh Singh)
Date: Fri, 30 Oct 2015 11:26:58 -0500
Subject: [PATCH v4] EDAC: Add ARM64 EDAC
In-Reply-To: <20151028164053.GG25451@leverpostej>
References: <1446048829-3359-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151028164053.GG25451@leverpostej>
Message-ID: <56339A52.8060701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

>> +
>> +Required properties:
>> +- compatible: Should be "arm,cortex-a57-edac" or "arm,cortex-a53-edac"
>> +
>> +Example:
>> +	edac {
>> +		compatible = "arm,cortex-a57-edac";
>> +	};
>> +
> 
> This is insufficient for big.LITTLE, no interrupt is possible, and we
> haven't defined the rules for accessing the registers (e.g. whether
> write backs are permitted).
> 
> Please see my prior comments [1] on those points.
> 
> If we're going to use this feature directly within the kernel, we need
> to consider the envelope of possible implementations rather than your
> use-case alone.
>

I have looked at possibility of pushing correctable error logging in the
firmware; but given current hardware limitation it seems like OS is the best
place to implement it. Let me summaries the issues we are running into:

* Correctable errors does not generate any interrupt:
  If we have to implement error parsing inside the firmware then work need
  to be split between OS and firmware. Maybe OS can call SMC instruction to 
  dial into firmware and then firmware can check error syndrome registers; 
  if it finds correctable error then build HEST table. This method will introduce
  performance issue because it require OS executing SMC every 100ms or so to just
  poll for correctable error. If you have any other recommendation then please share it.


> * Interaction with firmware
> - When/do we handle interrupts?

We can a properties in dt bindings:

1) "num-interrupts = 1" - number of interrupt count. One interrupts per cluster
    e.g if you have 4 cluster then num-interrupts=4.
2) interrupts = <0, 92, 0> <0, 94, 0> <0, 96, 0> <0, 98, 0>  // interrupt mapping

If num-interrupts = 0, then firmware handles interrupts. Optionally we can use HEST FIRMWARE-FIRST
bit, if bit is set then firmware is handling the interrupt otherwise use DT information.

>
>  - When is it valid to write back and clear an error? We should not do
>    this behind the back of any firmware that owns the interface.

As per A57 TRM is concerned you are right both the correctable and uncorrectable 
error needs to clear VALID bit in L1/L2 syndrome registers. So yes we need to define
a rule for accessing the registers. I can think of two possible approach here:

1) add "error-syndrome-reg-write-access=1" property in dt.
   * if '1' then OS has exclusive write backs access to error syndrome register
   * if '0' then OS will not clear the valid bit on fatal error

  The handler looks like this:

  parse_error_syndrome () {
   val = read_cpumerrsr

   if (!IS_VALID(val))
     return

   /* log the error details */

   /* if fatal error and OS does not have exclusive write back access */
   if (IS_FATAL(val) && !error-syndrom-reg-write-access)
     return; 

   val = ~(1UL << 31); /* clear valid bit */
  }

2) Use HEST FIRMWARE-FIRST bit field, if the bit is set then OS should not clear
   the valid bit on fatal error and similarly if bit is clear then OS clears the VALID bit.

Since firmware will never handle the correctable error hence its always safe to clear
the VALID bit on non-fatal error. If you have any other suggestions then please share it.

I am not pushing my use-case only; I am trying to work through current hardware
limitation and still support all the possibilities. I am open to hear your suggestions.
I am also not well versed on big.LITTILE CPU, so you may need to point me on right 
direction as we progress. My testing is limited to Cortex A57.

> 
> I don't think the use of old_mask is sufficient here, given the mapping
> of logical to physical ID is arbitrary. For example, we could have CPUs
> 0,5,6,7 in one cluster, and CPUs 1,2,3,4 in another, and in that case
> we'd check the first cluster twice.
> 

Noted. I should use physical ID instead of logical mapping.

> This also is wrong for big.LITTLE; we can't necessarily check on every
> CPU.
> 
