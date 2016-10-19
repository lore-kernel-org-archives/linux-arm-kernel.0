From: harba@codeaurora.org (Abdulhamid, Harb)
Date: Wed, 19 Oct 2016 12:59:03 -0400
Subject: [PATCH V3 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <496ddac3-a220-fd42-5ca1-3d0fb0238907@linaro.org>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
 <1475875882-2604-6-git-send-email-tbaicar@codeaurora.org>
 <496ddac3-a220-fd42-5ca1-3d0fb0238907@linaro.org>
Message-ID: <1941586c-4c51-60d8-a77a-ad56fe5f3e3f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2016 8:44 AM, Hanjun Guo wrote:
> Hi Tyler,
> 
> On 2016/10/8 5:31, Tyler Baicar wrote:
>> ARM APEI extension proposal added SEA (Synchrounous External
>> Abort) notification type for ARMv8.
>> Add a new GHES error source handling function for SEA. If an error
>> source's notification type is SEA, then this function can be registered
>> into the SEA exception handler. That way GHES will parse and report
>> SEA exceptions when they occur.
> 
> Does this SEA is replayed by the firmware (firmware first handling)
> or directly triggered by the hardware when error is happened?

Architecturally, an SEA must be synchronous and *precise*, so if you
take an SEA on a particular load instruction, firmware/hardware should
not be corrupting the context/state of the PE to allow software to
determine which thread/process encountered the abort.  GHES error status
block will be expose to software with information about the type,
severity, physical address impacted.

Generally the error status block is populated by firmware.  However, as
long as the above requirement is met, I don't think the spec precludes
error status block being populated by hardware.  Those details must be
completely transparent to software.

Finally, to answer your more specific question:  If the implementation
of firmware-first involves trapping the SEA in EL3 to do some firmware
first handling, firmware must maintain the context of the offending ELx,
generate an error record, and then "replay" the exception to normal
(non-secure) software at the appropriate vector base address.

Thanks,
Harb
-- 
-- 
Qualcomm Datacenter Technologies, Inc.
as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
