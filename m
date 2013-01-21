From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Jan 2013 16:31:43 +0100
Subject: [GIT PULL] Renesas ARM-based SoC v3.9
In-Reply-To: <20130116234310.GA411@quad.lixom.net>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
 <20130116063750.GA11765@verge.net.au> <20130116234310.GA411@quad.lixom.net>
Message-ID: <2682612.QaV0caZ3tv@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wednesday 16 January 2013 15:43:10 Olof Johansson wrote:
> On Wed, Jan 16, 2013 at 03:37:53PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > I have some complex dependencies for mach-shmobile for v3.9 and as such I
> > am sending this email outline the dependencies of branches on each other.
> > I have also included the multiple pull requests below though I am happy to
> > post them individually including the patches they comprise if you have no
> > objections to the way the branch dependencies are arranged.
> > 
> > I would also be happy to supply a single branch with all changes with or
> > without merge commits.
> 
> Hmm, complex indeed.
> 
> Is there any way to avoid this sequence of ARM -> sh/pinctrl -> ARM ->
> sh/pinctrl dependencies? That's what really makes things look complicated
> here. If you could move the final cleanup/code removal pieces out of
> the sh/pinctrl branches such that you have a less iterative chain of:
> 
> sh/pinctrl -> ARM -> final sh/pinctrl cleanup (removal of struct members,
> etc)
> 
> ... but I haven't looked in detail at the per-patch dependencies to see how
> tough that would be to arrange.
> 
> > All branches are present in the renesas tree
> > git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
> > 
> > 1. Branch: sh-soc
> > 
> >    Description: Pre-requisites for pfc changes for SH SoCs
> >    Based on: v3.8-rc1
> > 
> > 2. Branch: clocksource
> > 
> >    Description: Pre-requisite clocksource change for soc branch
> >    Based on: v3.8-rc1
> > 
> > 3. Branch: pfc
> > 
> >    Description: PFC Updates
> >    Based on: sh-soc
> > 
> > 4. Branch: sh-soc2
> > 
> >    Description: Further PFC changes for SH SoCs
> >    Based on: pfc
> > 
> > 5. Branch: soc
> > 
> >    Description: shmobile (ARM) SoCs updates, including PFC changes.
> >    Based on: a merge of clocksource and pfc
> > 
> > 6. Branch: boards
> > 
> >    Description: Board changes, including PFC changes.
> >    Based on: A merge of timer/cleanup (present in the arm-soc tree) and
> >    soc
> > 
> > 7. Branch: pfc2
> > 
> >    Description: Further PFC changes which depend on SoC changes
> >    Based on: A merge of sh-soc2 and soc
> > 
> > 8. Branch: sh-soc3
> > 
> >    Description: Further PFC changes for SH SoCs
> >    Based on: pfc2
> > 
> > 9. Branch: soc2
> > 
> >    Description: Further PFC changes for shmobile (ARM) SoCs
> >    Based on: A merge of timer/cleanup (present in the arm-soc tree) and
> >    pfc2
> > 
> > 10. Branch: pfc3
> > 
> >     Description: Description: Further PFC changes which depend on SoC
> >     changes
> >     Based on: A merge of sh-soc3 and soc2
> 
> Looking at it from the end here, 10 contains only arch/sh and global
> changes, and depends on 8 and 9. 8 also contains only sh changes. So it
> looks like 8 and 10 could be pruned from this pull request and go through
> either SH or pinctrl.
> 
> What pieces from branch 7 are stronly needed? A couple of the added pinctrl
> modules are used by mach-shmobile boards, it seems. And the structure rename
> might also be needed.

7 prepares for the move of PFC data from board code to drivers/. The branch 
mostly adds a pinctrl module for each of the supported SoCs, to allow later 
removal of PFC data from board code (in branches 8 and 9).

> Not having to pull in the bulk of 7, 8 and 10 would make a pretty big
> difference.

One way or the other all patches will need to be pulled. If they go through 
multiple trees we'll have to synchronize the multiple pull requests during the 
merge window, which looks pretty error-prone to me (but I might be wrong on 
this).

Sure, we could push 1-6 through the ARM tree, wait until it reaches mainline, 
then push 7 through the pinctrl tree, wait until it reaches mainline, push 8 
through the SH tree and 9 through the ARM tree, wait until they reach 
mainline, and finally push 10 through the pinctrl tree again. We could even 
push each branch through the tree it belongs to, but I doubt we'll be able to 
push everything during a single merge window.

I might be able to move 1 after 7, in which case we would have a single branch 
that would combine both and touch pinctrl only. The other dependencies seem 
pretty difficult to avoid.

What are the main issues with merging the branches in their current state (or 
possibly with 5 and 6 moved aside) through the ARM tree ?

> For branch 2 (clocksource include order), I'd like to see an ack from John
> or Thomas. Does it really make sense to base that on an ifdef instead of
> always initialize early?
> 
> Branch 4 seems to be mostly sh-specific updates. With some of the later
> dependencies avoided, maybe this branch can be dropped too, not sure?

4 moves platform device registration from the sh-pfc module to board code. 
Later pinctrl patches then remove platform device registration from the sh-pfc 
module completely and continue with the rework of the sh-pfc code. 7 thus 
strongly depends on 4.

> About half of branch 5 looks like it's generic SoC-updates unrelated
> to the pinctrl rework, and branch 6 looks like mostly regular
> patches/updates, is that stronly dependent on all the pinctrl
> rework? Doesn't look like it should be?

You're right here. The non-pinctrl patches in 5 could go through a separate 
branch, they shouldn't depend on the pinctrl rework. 6 also has no dependency 
on the pinctrl rework.

-- 
Regards,

Laurent Pinchart
