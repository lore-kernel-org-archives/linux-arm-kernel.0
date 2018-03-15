From: york.sun@nxp.com (York Sun)
Date: Thu, 15 Mar 2018 15:15:14 +0000
Subject: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <20180315150702.5yqauxj3z6exdl65@lakrids.cambridge.arm.com>
Message-ID: <VI1PR04MB20786EE9B3FB70B7FCCA88789AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2018 08:07 AM, Mark Rutland wrote:
> Hi York,
> 
> On Wed, Mar 14, 2018 at 05:17:46PM -0700, York Sun wrote:
>> Add error detection for A53 and A57 cores. Hardware error injection
>> is supported on A53. Software error injection is supported on both.
>> For hardware error injection on A53 to work, proper access to
>> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
>> is done by making an SMC call in the driver. Failure to enable access
>> disables hardware error injection. For error interrupt to work,
>> another SMC call enables access to L2ECTLR_EL1. Failure to enable
>> access disables interrupt for error reporting.
> 
> Further to James's comments, I'm very wary of the prospect of using
> IMPLEMENTATION DEFINED functionality in the kernel, since by definition
> this varies from CPU to CPU, and we have no architected guarantees to
> rely upon.
> 
> I'm concerned that allowing the Non-secure world to access these
> IMPLEMENTATION DEFINED registers poses a security risk (as it allows the
> Non-secure world to change properties that the secure world may be
> relying upon, among other things).
> 
> I'm also concerned by the SMC interface, which uses a SIP-specific ID
> (i.e. it's NXP-specific). Thus, this driver can only possibly work on
> particular CPUs as integrated by NXP.
> 
> The general expectation is that IMPLEMENTATION DEFINED functionality is
> for the use of firmware, which can provide common abstract interfaces.
> 
> From ARMv8.2 onwards, EDAC functionality is architected as part of the
> RAS extensions, and in future, that's what I'd expect we'd support in
> the kernel.
> 
> Given all that, I don't think that we should be poking this
> functionality directly within Linux, and I think that firmware should be
> in charge of managing EDAC errors on these systems.
> 
> I've left some general comments below, but the above stands regardless.
> 

Points taken. I only made this driver under our customer's request.
Even this may meet our customer's need in short term, it doesn't look
like a generic solution for the architecture. Let's stop here.

I really appreciate your other comments in this thread.

York
