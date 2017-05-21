From: gengdj.1984@gmail.com (gengdongjiu)
Date: Sun, 21 May 2017 16:24:26 +0800
Subject: [PATCH v3 3/3] arm/arm64: signal SIBGUS and inject SEA Error
In-Reply-To: <5915EFC3.9070507@arm.com>
References: <CAMj-D2BGTDKpOcMu2ip41_MTTj8VDwvs59Ds7yvLHcD8PeQzhg@mail.gmail.com>
 <CAMj-D2A-ER8GEN32au774AY682yeMVyJwxhZoO+NkXKYYMwoQw@mail.gmail.com>
 <5915EFC3.9070507@arm.com>
Message-ID: <CAMj-D2DLW3a1XxWtW0xouBoLEVFqHmX5t-ds=2bCyb8ZbRS9Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,
    sorry for the late response due to recently verify and debug the
RAS solution.

2017-05-13 1:24 GMT+08:00, James Morse <james.morse@arm.com>:
> Hi gengdongjiu,
>
> On 05/05/17 13:31, gengdongjiu wrote:
>> when guest OS happen an SEA, My current solution is shown below:
>>
>> (1) host EL3 firmware firstly handle the SEA error and generate the CPER
>> record.
>> (2) EL3 firmware separately copy the esr_el3, elr_el3, SPSR_el3,
>> far_el3 to the esr_el2, elr_el2, SPSR_el2, far_el2.
>
> Copying {ELR,SPSR,FAR}_EL3 to the EL2 registers rings some alarm bells: I'm
> sure
> you exclude values from EL3 or the secure-world, we should never hand those
> to
> the normal world.

 it is sure that needs to  exclude the EL3 Error and secure-world.

>
>
>> (3) then jump the EL2 hypervisor
>
>> so the EL2 hypervisor uses the ESR that come from esr_el3,  here the
>> ESR(esr_el3) value may be different with the exist KVM API's ESR.
>
> The ESR may be different between EL3 and EL2. The ESR contains the severity
> of
> the event, the CPU will choose this when it takes the SError to EL3. If it
> had
> taken the SError to EL2, the CPU may have classified the error differently.
>
> Firmware may need to generate a more severe ESR if it receives an error
> that
> would be propagated by delivering SEI to a lower exception level, for
> example if
> an EL2 system register is 'infected'.
>
> This is the same for Qemu/kvmtool. A contained error at EL2 may be an
> uncontained error if we hand it to guest EL1. Linux's RAS code will decide
> this
> with its choice of signal to send, (and possibly which code to set).
> Qemu/kvmtool need to choose an appropriate APEI notification, which may
> involve
> generating a relevant ESR.
>
> Also relevant is the problem we discussed earlier with trying to deliver
> fake
> Physical-SError from software at EL3: If the SError is routed to EL2, and
> EL2
> has PSTATE.A masked, EL3 has to wait and try again later. This is another
> case
> where firmware may have to upgrade the classification of an error to
> uncontainable.
   it makes sense. thanks to James.

>
>
> Thanks,
>
> James
>
