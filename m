From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 11 Jan 2011 18:56:10 -0800
Subject: Locking in the clk API
In-Reply-To: <20110111091607.GI12552@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
Message-ID: <4D2D184A.8020405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2011 01:16 AM, Russell King - ARM Linux wrote:
> On Tue, Jan 11, 2011 at 10:16:42AM +0800, Jeremy Kerr wrote:
>> At present, we can satisfy these with:
>>
>> * clk_enable: may sleep
>
> I object to this as one of the purposes behind the clk API is to allow
> power savings to be made, and unless we can perform clk enable/disable
> from atomic contexts, the best you can do is enable the clock when the
> device is probed and disable it when it's released.

Since dev_pm_ops.suspend is not atomic anymore (am I wrong?), what is 
the atomic context that you are having in mind that's related to power 
savings? How often do we really need to call clk enable/disable in that 
atomic context?

If the system VDD needed to be increased when a clock/core in enabled 
(in reality, when a core is enabled), how do we make sure that the 
voltage is reduced when the clock/core is turned off? Do we simply punt 
the voltage change problem to the driver and say "not our problem"?

I'm not saying that the voltage change should or shouldn't be handled by 
the clock driver. But it looks like the same methods used to handle the 
voltage change problem could be applied to how we could handle the clk 
enable/disable problem.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
