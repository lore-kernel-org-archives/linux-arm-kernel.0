From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 30 Jun 2015 09:07:54 -0500
Subject: [PATCH 1/3] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <20150630135815.GK27725@arm.com>
References: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
 <20150630135815.GK27725@arm.com>
Message-ID: <5592A2BA.7010604@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
>> >Selecting this option will enable code that serializes all console
>> >input and output to core 0.  The DCC driver will create input and
>> >output FIFOs that all cores will use.  Reads and writes from/to DCC
>> >are handled by a workqueue that runs only core 0.

> What happens if CPU0 is hotplugged off?

I guess the whole thing just breaks.

I don't know what to say.  Trace32's DCC window is latched to CPU0.  If 
that CPU is hotplugged off, then I don't think there's a mechanism for 
Trace32 to migrate to another CPU.  It will broken no matter what.

That's why this feature is disabled by default.  If you're working on an 
SMP ARM system and using Trace32, you will need this patch.  It might be 
possible for Lauterbach to fix Trace32 to provide this feature 
internally in some situations (e.g. SMP mode where there's one window 
for all cores), but not in every situation.

I can add a "depends on !CPU_HOTPLUG" to the Kconfig, but I think that's 
overkill.  This is really a "use it if you need it" patch, and DCC is 
used mostly for debugging.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
