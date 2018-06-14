From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 14 Jun 2018 11:30:54 -0400
Subject: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
In-Reply-To: <20180613130232.GA27675@arm.com>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
 <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
 <9957219b64252d3b2e19724db04a1179@codeaurora.org>
 <20180613103555.GC26280@arm.com>
 <06c81a64-904f-59fa-5751-62818d6d2107@arm.com>
 <20180613130232.GA27675@arm.com>
Message-ID: <4a584145358bd046d735c30ba0d49db6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2018-06-13 09:02, Will Deacon wrote:
> On Wed, Jun 13, 2018 at 01:59:58PM +0100, Marc Zyngier wrote:
>> On 13/06/18 11:35, Will Deacon wrote:

[...]

>> > Great :( We need to make sure we disable EL0 access during boot then, but
>> > that means we need to prove for the existence of this thing in head.S
>> > (since the PMU driver might not get loaded).

Unfortunately it appears the only check we can do for this is through
the MIDR or PMPIDRx. I'm investigating whether we can detect this 
through
some other mechanism, but it that doesn't exists would the MIDR.PMPIDRx
check be acceptable?

>> >
>> > Also, what's the kvm story here so that we don't accidentally open up a
>> > VM-VM side-channel via these registers? How do the EL1 trapping controls
>> > work?

Traps for these registers are as follows:

Architecture traps:
- HCR_EL2.TIDCP enables a trap when accessing IMP DEF registers. kvm 
will set
   this bit for all guests and access from EL1/EL0 will cause a trap to 
EL2.
- MDCR_EL2.TPM enables a trap when accessing the PM registers from 
EL1/EL0,
   causing accesses to trap to EL2.
- MDCR_EL2.TPM enables a trap when accessing the PM registers from 
EL1/EL0,
   causing accesses to trap to EL2.

IMP DEF traps:
- IMP DEF register PMACTLR_EL0.UEN controls EL0 access to all IMP DEF
   registers related to performance monitoring:
   0->disables EL0 access (default), 1->enables EL0 access
- IMP DEF HACR_EL2.TCPUPMRBB enables a trap when accessing the RBB 
registers
   from EL1/EL0, causing accesses to trap to EL2.
- IMP DEF HACR_EL2.TCPUPMPCCPT enables a trap when accessing the PCC 
registers
   from EL1/EL0, causing accesses to trap to EL2.
- IMP DEF HACR_EL2.TCPUPMRESRRLDR enables a trap when accessing the 
PMRESRx_EL0
   registers from EL1/EL0, causing accesses to trap to EL2.

>> 
>> We'd trap the IMPDEF register access and inject an UNDEF (assuming 
>> that
>> the IMPDEF trapping works correctly). I have strictly no plan to 
>> support
>> this in a guest.
> 
> Ah, so we could actually configure that in el2_setup and solve the host
> problem if we're entered at EL2. Agustin -- does that work, and what do 
> we
> need to do if the host is entered at EL1?
> 

Yes, that works, I understand there is no desire to support this under
virtualization.

As for the question about the EL1 host, all of our firmware 
configurations
boot the host OS at EL2. Is that sufficient guarantee or can you suggest
an alternative mechanism to ensure security?

Thanks,
Agust?n

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
