From: ahs3@redhat.com (Al Stone)
Date: Mon, 9 Oct 2017 16:46:17 -0600
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <20170927103406.GC32150@leverpostej>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170927103406.GC32150@leverpostej>
Message-ID: <7e1bd635-8c17-634e-aaae-ac7ec4a1e351@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2017 04:34 AM, Mark Rutland wrote:
> On Tue, Sep 26, 2017 at 04:23:21PM -0600, Al Stone wrote:
>> As ARMv8 servers get deployed, I keep getting the same set of questions
>> from end-users of those systems: what do all the hex numbers mean in 
>> /proc/cpuinfo and could you make them so I don't have to carry a cheat
>> sheet with me all the time?
> 
> I appreciate that /proc/cpuinfo can be opaque to end users, but I do not
> believe that this is the right solution to that problem.
> 
> There are a number of issues stemming from the face that /proc/cpuinfo
> is ill-defined and overused for a number of cases. Changes to it almost
> certainly violate brittle de-facto ABI details people are relying on,
> and there's a very long tail on fallout resulting from this. In
> addition, many niceties come at an excessive maintenance cost, and are
> simply unreliable as an ABI.

Instead of dealing with the replies to the specific patches, I'd like to deal
with the real gist of the matter first -- details can be worked out later.

While I don't disagree -- cpuinfo is enormously fragile -- what _is_ a good
solution, then?  Right now, things are not terribly useful.  Yes, it is true
/sys/firmware/dmi has info in it, but again it is all numeric (or in a file
named 'raw').  Any one who wishes to read the values will need to put some
interpretation on them somehow.  My personal preference is that the kernel
control that interpretation instead of random admin tools scattered over a raft
of different companies.

> So, as with all other patches modifying /proc/cpuinfo, I must NAK this
> series.

Hrm.  I suggest that policy needs to be rethought.  I understand the reasoning,
but it puts my end-users in a very difficult position; they now have to justify
modifying management software that is already in operation in order to purchase
and integrate ARM servers.  And while I really don't want distro-specific code,
I'd have to consider it as a possibility.

To be completely fair, though, I'm not completely fixated on cpuinfo as the only
possible answer.  It has been the most requested, however.

> For the MPIDR and product info, I think we can expose this in a more
> structured way (e.g. under sysfs). IIUC the product info is all derived
> from DMI -- do we not expose that already?

Agreed; the MPIDR I think could just as easily be in /sys/devices/cpu/* as
a hex value.  It doesn't have the value to end-users that the other info does,
either -- for debugging, definitely, but not necessarily sysadmin.  I'll put
something together for this.

The DMI info is in sysfs but it is not in a fashion normally consumed, hence
the questions from end-users, in a way.  They're not expecting to have to do
the interpretation, and they are expecting the platform to be able to tell
them what "Model: 2" means.

> For the human-readable names I must NAK such patches. This is an
> extremely brittle ABI that cannot be forwards compatible, and comes with
> hilarious political problems. This should be managed in userspace alone.
> 
> I thought tools like lscpu and lshw were intended to gather such
> information for users. What are these missing today?

All of the above human-readable parts -- lscpu reads model information from
/proc/cpuinfo, for example, and would require new code to read this info from
somewhere else, and then figure out how to interpret it.  All I get is a lovely
'2' for 'model' :).  We could obviously change the userspace tools, but I'm
guessing it just moves the political hilarity from the kernel to userspace,
correct?  It also runs the risk of even greater silliness, like perhaps lscpu
gets a product name right, but lshw calls it something different, and so on.

The other approach that occurs to me is to blend what x86 does and sysfs; i.e.,
would it be acceptable to modify cputype.h to include comments (as x86 does)
that are then munged by a script somewhat like arch/x86/kernel/cpu/mkcapflags.sh
that then produces a header file with proper human-readable content that can
then be exposed in sysfs?  I don't think we can ever remove the brittleness
completely, but perhaps this would at least mitigate it.  This would still
require userspace modifications, too, but they could at least rely on a uniform
source of data -- and perhaps a single place to focus when hilarity ensues :).
I'll bodge some patches together and maybe start over as an RFC, if there's a
chance this would be accepted.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
