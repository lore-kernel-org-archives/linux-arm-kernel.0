From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2012 11:35:18 +0100
Subject: [PATCH 0/2] Use architected timers for delay loop
In-Reply-To: <4FE8DA65.8030403@codeaurora.org>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <4FE8DA65.8030403@codeaurora.org>
Message-ID: <20120626103518.GC27996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for taking a look at the series!

On Mon, Jun 25, 2012 at 10:38:45PM +0100, Stephen Boyd wrote:
> On 06/22/12 08:09, Will Deacon wrote:
> > This patch series reworks our delay loop implementation to allow the
> > busy-loop to be replaced with the physical counter included as part of
> > the architected timer on recent CPUs. The polling implementation is
> > still maintained to support cores without the timers and we use the same
> > maths and upper delay bound of 2ms.
> 
> I have posted a read_current_timer implementation to the list a couple
> times but had no success in getting it merged. The patches are still in
> the patch tracker but I haven't really pushed them to get merged.
> 
>     http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6874/1
>     http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6873/1
>     http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6875/1

I took a look at these but I really shy away from using memory-mapped
clocksources for delay -- it feels like we're asking for problems if we go
down that route. Maybe it could work, but switching from the polling loop to
the clocksource would surely require some recalibration?

> So far we've just been carrying them internally. I suppose ARM needs
> this now because of big little?

To be honest, I just implemented this because it allows us to skip the
calibration and I thought the solution fell out quite neatly. It does also
remove the need for re-calibration when scaling the core clock, so yes it
would be useful whenever that occurs.

Will
