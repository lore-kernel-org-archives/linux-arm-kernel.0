From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 10:04:07 +0000
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <87d2xcfeew.fsf@xmission.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk> <87ehhxahd1.fsf@xmission.com>
 <20130107144812.GD3222@n2100.arm.linux.org.uk> <87d2xcfeew.fsf@xmission.com>
Message-ID: <20130111100407.GB30875@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 09:59:35PM -0800, Eric W. Biederman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Sun, Jan 06, 2013 at 05:53:30PM -0800, Eric W. Biederman wrote:
> >> I have cleaned up the mess that is the reboot path once a bunch of years
> >> ago, and apparently it is deteriorating again.
> >
> > Unfortunately, that's what happens when lots of cooks get their fingers
> > in a pie with no coordination.  This is why having maintainers is soo
> > important for code - a good maintainer ensures that the code remains
> > high quality by whatever means.
> >
> > Code without maintainers is subject to modification in all kinds of
> > random ways, including duplicating code amongst architectures which
> > should be generic code - that happens because no one wants to understand
> > what other architectures require.
> 
> I don't think you meant to but I have been rather strongly insulted.

Why would you be insulted by the above?  It's a statement of fact that
is true for anything.  Ever heard of the expression "Too many cooks
spoil the broth" ?  Does that expression insult you too?

You've admitted that you don't have time to look at the shutdown/reboot
paths very much, so they are by way of that fact lacking in maintainer
input - but if you read the rest of what I wrote, I also commented that
they were still in pretty good shape inspite of that.

So actually, there's a complement there.  Shame you missed it.

> Now sometimes_dangerously_hotunplug_all_but_one_cpu() on the reboot path 
> was added just a few months ago in Oct 2012, and it appears to due to
> weird ARM maintainership.

Err.  No.  Stop trying to accuse people of being crap when there's no
evidence:

commit f96972f2dc6365421cf2366ebd61ee4cf060c8d5
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Thu Oct 4 17:12:23 2012 -0700

    kernel/sys.c: call disable_nonboot_cpus() in kernel_restart()
...
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

No ARM maintainers were involved in that change.  I just checked my
mailboxes for September 2012 which is when it was mailed to the list.
It got missed, and Andrew replied and accepted the patch (as is
illustrated by the sign-offs).  And even if _I_ had been involved with
it, _I_ would not have spotted the x86 behaviour, just the same that
Andrew didn't.

Is this not itself evidence of my comment above: had the above change
gone through someone who had a deep understanding of that code - iow,
a maintainer, it probably would not have been committed to the kernel?

To accuse others who have nothing to do with the area, and weren't
involved with the change in any way of being responsible for that
change is... well... I don't think there's anything that can be said
to that which isn't inflamatory.

It seems that, given your comments, the above commit needs to be reverted,
and then _maybe_ the disable_nonboot_cpus() call should be added to ARMs
machine_shutdown() instead.
