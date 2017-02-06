From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 6 Feb 2017 06:59:40 -0600
Subject: [PATCH] irqchip/gicv3: Fix GICR_WAKE & GICD_IGROUPR accesses from
 non-secure
In-Reply-To: <fd1d435d-28e8-117b-4794-886b11a7454c@arm.com>
References: <1486347465-28316-1-git-send-email-shankerd@codeaurora.org>
 <fd1d435d-28e8-117b-4794-886b11a7454c@arm.com>
Message-ID: <31731b77-e985-5b86-705a-f1ae61522070@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 02/06/2017 03:33 AM, Marc Zyngier wrote:
> Hi Shanker,
>
> On 06/02/17 02:17, Shanker Donthineni wrote:
>> On systems where it supports two security states, both the register
>> GICR_WAKE and GICD_IGROUPR accesses are RAZ/WI from non-secure.
>> The function gic_enable_redist() to wake/sleep redistributor is not
>> harmful at all, but it is confusing looking at the code. The current
>> code checks the single security state based on bit GICD_CTLR.DS which
>> is absolutely incorrect. The disable security bit GICD_CTLR.DS is RAZ
>> to non-secure.
> I'm afraid we don't have the same definition of GICD_CTLR.DS. In my copy
> of the architecture spec, it says:
>
> "When this field is set to 1, all accesses to GICD_CTLR access the
> single Security state view, and all bits are accessible".
>                                  ^^^^^^^^^^^^^^^^^^^^^^^
Yes, but GICD_CTLR.DS is reversed bit not defined when accessing from 
non-secure.
Please look at GICD_CTLR definition 'When access is Non-secure, in a 
system that supports two Security states'

> This would tend to support my interpretation that once DS has been set
> from the secure side, it becomes visible to all type of accesses.
>
>> The GICD_TYPE.SecurityExtn indicates whether the GIC
>> implementation supports two security states or only one security
>> state.
> Yes, and that's orthogonal to having set DS or not.
>
> So clearly, we have a difference of interpretation. What part of the
> spec is supporting yours?
I've verified three releases of GIC specs, all of them have the same 
definition of GICD_CTLR.

  1) First release of GICv3 and GICv4 issue A
  2) First release of GICv3 and GICv4 issue B
  3) First release of GICv3 and GICv4 issue C

Section '8.9.4 GICD_CTLR, Distributor Control Register' has the three 
definitions.
    1) When access is Secure, in a system that supports two Security states
        DS bit: When this field is set to 1, all accesses to GICD_CTLR 
access the single Security state view, and all
bits are accessible.

    2) When access is Non-secure, in a system that supports two Security 
states
         DS bit: Reserved.
    3) When in a system that supports only a single Security state
         DS bit: Disable Security. This field is RAO/WI.


-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
