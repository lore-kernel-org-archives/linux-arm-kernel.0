From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Jun 2012 10:42:50 -0700
Subject: [PATCH 0/2] Use architected timers for delay loop
In-Reply-To: <20120626103518.GC27996@mudshark.cambridge.arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <4FE8DA65.8030403@codeaurora.org>
 <20120626103518.GC27996@mudshark.cambridge.arm.com>
Message-ID: <4FE9F49A.9030602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/12 03:35, Will Deacon wrote:
> On Mon, Jun 25, 2012 at 10:38:45PM +0100, Stephen Boyd wrote:
>> I have posted a read_current_timer implementation to the list a couple
>> times but had no success in getting it merged. The patches are still in
>> the patch tracker but I haven't really pushed them to get merged.
>>
>>     http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6874/1
>>     http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6873/1
>>     http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6875/1
> I took a look at these but I really shy away from using memory-mapped
> clocksources for delay -- it feels like we're asking for problems if we go
> down that route. Maybe it could work, but switching from the polling loop to
> the clocksource would surely require some recalibration?

We never switch from polling to clocksource (or vice versa) after the
calibration is done in calibrate_delay(). The lpj calculation is always
based on the clocksource using calibrate_delay_direct(). This looks to
be pretty much like what your patches are doing but you skip the
calibration step by setting lpj_fine, which is even better.

Even then, I don't understand why the series scares you that much. You
could just define read_current_timer() for architected timers like you
already have and then the series would work just the same with
coprocessor accesses. The benefit is no code duplication. I like how
you've implemented get_cycle(), but that's a minor difference.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
