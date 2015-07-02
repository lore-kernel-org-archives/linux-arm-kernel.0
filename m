From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 01 Jul 2015 17:14:04 -0700
Subject: [PATCH v2 0/3] ARM: keystone: add ecc error interrupt handling
In-Reply-To: <558D437F.30705@ti.com>
References: <1435242710-31346-1-git-send-email-vitalya@ti.com>
 <558C188B.5060107@oracle.com> <558C6C4F.1090102@codeaurora.org>
 <558C72EB.8010502@oracle.com> <558C7437.2090306@codeaurora.org>
 <558D437F.30705@ti.com>
Message-ID: <5594824C.7030202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2015 05:20 AM, Vitaly Andrianov wrote:
>
>
> On 06/25/2015 05:35 PM, Stephen Boyd wrote:
>>
>> There's an existing one for highbank (drivers/edac/highbank_l2_edac.c)
>> and there was a patch set for the pl310 as well[1]. I don't think we
>> want any architecture specific code for this, just use the EDAC
>> framework.
>>
>> [1] https://lkml.org/lkml/2014/3/2/87
>>
>
> Before porting that patch I was looking to implementation of the EDAC
> for L2 cache and tried to use the framework. Sorry, but I couldn't
> understand why would the Keystone platform may need it. Most likely
> because I didn't understand the framework itself :(
>
> In order the Keystone ECC works u-boot has to initialize the entire
> DDR3 and enable ECC. When kernel boots up it has to install the ECC
> interrupt handlers for Cortex-A15 L1/L2 ECC and Keystone2 DDR3 ECC. As
> far as 1-bit errors handled and corrected by hardware the software
> even doesn't need to handle those errors. We need to handle 2-bit
> errors and just reboot the board.
>
> As the ECC detection has to be enable on kernel boot time and cannot
> be disabled there is not sense to make it in a module.
>
> So, shall Keystone use the EDAC framework to install the onetime
> working interrupt handler? What are advantages to use the framework?
>

Some advantages that come to mind are user configurability and
statistics. Perhaps the user wants to know how many single bit errors
(correctable errors in EDAC language) have happened so they can figure
out if the part is going bad. Or perhaps the user wants to panic on
single bit errors to play it safe. The edac framework makes this sort of
thing standard, instead of requiring SoC specific tooling. It also
groups similar pieces of hardware support in one place and gets code out
of mach directories.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
