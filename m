From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jan 2016 17:21:06 +0000
Subject: [PATCH v9 08/13] arch/arm64: adopt prepare_exit_to_usermode()
 model from x86
In-Reply-To: <568ADD91.1050100@ezchip.com>
References: <1451936091-29247-1-git-send-email-cmetcalf@ezchip.com>
 <1451936091-29247-9-git-send-email-cmetcalf@ezchip.com>
 <20160104203316.GE17127@leverpostej> <568ADD91.1050100@ezchip.com>
Message-ID: <20160105172106.GA7088@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 04:01:05PM -0500, Chris Metcalf wrote:
> On 01/04/2016 03:33 PM, Mark Rutland wrote:
> >Hi,
> >
> >On Mon, Jan 04, 2016 at 02:34:46PM -0500, Chris Metcalf wrote:
> >>This change is a prerequisite change for TASK_ISOLATION but also
> >>stands on its own for readability and maintainability.
> >I have also been looking into converting the userspace return path from
> >assembly to C [1], for the latter two reasons. Based on that, I have a
> >couple of comments.
> 
> Thanks!
> 
> >It seems unfortunate to leave behind portions of the entry.S
> >_TIF_WORK_MASK state machine (i.e. a small portion of ret_fast_syscall,
> >and the majority of work_pending and ret_to_user).
> >
> >I think it would be nicer if we could handle all of that in one place
> >(or at least all in C).
> 
> Yes, in principle I agree with this, and I think your deasm tree looks
> like an excellent idea.
> 
> For this patch series I wanted to focus more on what was necessary
> for the various platforms to implement task isolation, and less on
> additional cleanups of the platforms in question.  I think my changes
> don't make the TIF state machine any less clear, nor do they make
> it harder for an eventual further migration to C code along the lines
> of what you've done, so it seems plausible to me to commit them
> upstream independently of your work.

I appreciate that you don't want to rewrite all the code.

However, I think it's easier to factor out a small amount of additional
code now and evlove that as a whole than it will be to evolve part of it
and try to put it back together later.

I have a patch which I will reply with momentarily.

Thanks,
Mark.
