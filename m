From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Tue, 18 Feb 2014 11:04:23 +0000
Subject: BUG: Null pointer dereference on booting TC2 with
 vexpress_defconfig
In-Reply-To: <20140217223907.GH21070@cbox>
References: <20140217223907.GH21070@cbox>
Message-ID: <53033E37.6000402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/14 22:39, Christoffer Dall wrote:
> Booting my TC2 using 3.14-rc3 and vexpress_defconfig causes a NULL
> pointer dereference in schedule_work_on.
> 
> A quick look at the trace indicates that schedule_work() is called
> before system_wq is initialized.
> 
> Further, a bisect seems to indicate that this call path is triggered by
> the changes in this merge commit of Theodore T'so's random_for_linus
> tag:
> 0891ad829d2a0501053703df66029e843e3b8365
> 
> (However, my bisect may not be 100% correct, as some of the commits
> between 3.13 and 3.12 don't boot the TC2 with vexpress_defconfig,
> specifically the ones after f9300eaaac1ca300083ad41937923a90cc3a2394,
> which causes boot to halt after "ARM CCI driver probed").
> 
Yes that requires some changes in defconfig to continue to work across
these changes(mainly have all these new configs disabled)

> Disabling CONFIG_ARCH_VEXPRESS_TC2_PM avoids the issue.
> 
Are you just disabling this or even CONFIG_MCPM ? Are the secondaries cpus
coming up ?

> I'm not familiar enough with any of these code paths to quicly identify
> what the issue could be.  Apologies if I missed a previous post about
> this issue (I couldn't find anything but would be surprised if I'm the
> only one doing vexpress_defconfig on a TC2).
> 
I just tried and it works fine. If CONFIG_MCPM and CONFIG_ARCH_VEXPRESS_TC2_PM,
it requires some changes in board configurations(for bootmon), I assume you have
done those changes.

Regards,
Sudeep
