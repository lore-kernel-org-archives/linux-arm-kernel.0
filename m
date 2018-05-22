From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 22 May 2018 14:48:29 +0100
Subject: [RFC PATCH v2] arm64: fault: Don't leak data in ESR context for
 user fault on kernel VA
In-Reply-To: <20180522133826.GE26955@arm.com>
References: <20180419154833.27727-1-peter.maydell@linaro.org>
 <20180522133826.GE26955@arm.com>
Message-ID: <CAFEAcA9i4_neKwaWPm_gV=fAgASL4B9X8Z++c+NvGA+JYSdDZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2018 at 14:38, Will Deacon <will.deacon@arm.com> wrote:
> Hi Peter,
>
> Sorry for the delay in getting to this! Comments inline.
>
> On Thu, Apr 19, 2018 at 04:48:33PM +0100, Peter Maydell wrote:

>> +                     /*
>> +                      * These bits provide only information about the
>> +                      * faulting instruction, which userspace knows already.
>> +                      * We explicitly clear bits which are architecturally
>> +                      * RES0 in case they are given meanings in future.
>> +                      */
>> +                     if (esr & ESR_ELx_ISV)
>> +                             esr &= ESR_ELx_EC_MASK | ESR_ELx_IL |
>> +                                     ESR_ELx_ISV | ESR_ELx_SAS |
>> +                                     ESR_ELx_SSE | ESR_ELx_SRT_MASK |
>> +                                     ESR_ELx_SF | ESR_ELx_AR | ESR_ELx_CM |
>> +                                     ESR_ELx_WNR;
>
> Reading through the ARM ARM, it seems to say that ISV is always 0 for
> faults reported in ESR_EL1, which implies we can drop ISV, SAS, SSE, SRT,
> SF and AR from this list and actually drop the conditional altogether.

Mmm, I guess so, if we're guaranteed to only be working with ESRs
taken to EL1 (or we want to present userspace with an ESR that
looks like that regardless of what EL we took it to). I'll respin
without the conditional.

thanks
-- PMM
