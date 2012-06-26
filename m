From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2012 15:33:14 +0100
Subject: [RFC PATCH 0/8] Fix restart_block syscall restarting for 3.5
In-Reply-To: <20120625091818.GB22128@mudshark.cambridge.arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
 <20120622193626.GG14083@ZenIV.linux.org.uk>
 <20120625091818.GB22128@mudshark.cambridge.arm.com>
Message-ID: <20120626143314.GO27996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 10:18:18AM +0100, Will Deacon wrote:
> Hi Al,

Hello again,

> On Fri, Jun 22, 2012 at 08:36:26PM +0100, Al Viro wrote:
> > On Fri, Jun 22, 2012 at 04:06:58PM +0100, Will Deacon wrote:
> > > I reckon the first two reverts should go in for 3.5 unless anybody has
> > > a better solution. The rest of the code is an RFC since, as Russell has
> > > said before, the code is `rather yucky'.
> > 
> > See commit 76c3f4da3ee47b68304dbe0f64e86562e7945bf3 and a couiple before it in
> > signal.git:
> 
> Thanks, I'll take a look (it may keep me occupied for some time...). Are
> these destined for 3.5 or shall we press ahead with the two reverts for now
> and fix this properly in the merge window?

For what it's worth, your patches look correct to me. The main difference
between my approach and yours is that I continue processing signals even
after the restart requirements have been filled, aborting the restart later
if further signal processing indicates that it's necessary to do so. With
your patches we stop iterating through the signals as soon as we hit a
restart and avoid the problem that way.

POSIX helpfully seems to avoid this scenario and given the asychronous
nature of signals, I'm not sure it matters either way. The only thing I
wonder about is whether restarting a syscall using restart_syscall(2) when
there are further signals pending will cause the syscall to return
-ERESTART_RESTARTBLOCK immediately and we'll go through this long-winded
sequence for each pending signal without a handler installed...

... or am I grossly confused?

Cheers,

Will
