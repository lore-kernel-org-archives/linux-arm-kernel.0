From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 5 Nov 2015 10:19:50 +0000
Subject: [PATCHv2 3/4] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <563B2C01.80701@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-4-git-send-email-suzuki.poulose@arm.com>
 <20151104182854.GH23860@leverpostej> <563B2C01.80701@arm.com>
Message-ID: <563B2D46.10503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 10:14, Suzuki K. Poulose wrote:
> On 04/11/15 18:28, Mark Rutland wrote:
>> On Tue, Oct 20, 2015 at 02:05:25PM +0100, Suzuki K. Poulose wrote:
>>> Adds helper routines to manipulate the counter controls for
>>> all the counters on the CCI PMU.

>>> +static void pmu_disable_counters_ctrl(struct cci_pmu *cci_pmu, unsigned long *mask)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < cci_pmu->num_cntrs; i++) {
>>> +        clear_bit(i, mask);
>>> +        if (pmu_get_counter_ctrl(cci_pmu, i)) {
>>> +            set_bit(i, mask);
>>> +            pmu_disable_counter(cci_pmu, i);
>>> +        }
>>> +    }
>>> +}
>>
>> I don't understand what's going on with the mask here. Why do we clear
>> ieach bit when the only user (introduced in the next patch) explicitly
>> clears the mask anyway?
>
> To be more precise, it should have been :
>
>      if (pmu_get_counter_ctrl(cci_pmu, i)) {
>          set_bit(i, mask);
>          pmu_disable_counter(cci_pmu, i);
>      } else
>          clear_bit(i, mask);

Forgot to mention, the explicit clearing is for the bits that may be
beyond the num_counters. Since we limit it to cci_pmu->num_cntrs here
we could get rid of that.
  
Thanks
Suzuki
