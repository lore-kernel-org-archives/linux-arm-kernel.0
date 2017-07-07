From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Jul 2017 18:11:36 +0100
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170706215902.qtmbsidwvqlr7o56@yury-thinkpad>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
 <20170706215902.qtmbsidwvqlr7o56@yury-thinkpad>
Message-ID: <20170707171135.h54fe4ea7xuxnrqt@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

Just a quick reply as I'm about to go on holiday for the next two weeks.

On Fri, Jul 07, 2017 at 12:59:02AM +0300, Yury Norov wrote:
> On Thu, Jun 29, 2017 at 05:10:36PM +0100, Catalin Marinas wrote:
> > On Mon, Jun 19, 2017 at 06:49:43PM +0300, Yury Norov wrote:
> > > This series enables aarch64 with ilp32 mode.
> > 
> > What I'd like to propose is that Will and I (as arm64 maintainers, maybe
> > with with the help of others including this series' authors) take over
> > the series and push it to a staging branch under the arm64 kernel on
> > git.kernel.org. This is aimed as a commitment to keep the ABI *stable*
> > and will be rebased with every kernel release (starting with 4.13). The
> > decision to merge upstream will be revisited every 6 months, assessing
> > the progress on the points I mentioned above, with a time limit of 2
> > years when, if still not upstream, we will stop maintaining such branch.
> 
> Thanks for the email. I appreciate your concern about long-term
> support load for a new ABI. I also think that stabilizing the ABI
> is a good idea.
> 
> At this point, most people expect the ABI to not change unless
> critical issues are uncovered. IMO, if there is a good technical reason
> to change the ABI -- the change will happen even on the "staging" branch.

What I would like is that we change the ABI *only* if there is a serious
bug, otherwise we should try hard to keep it stable. The "good technical
reason" can be subjective (i.e. let's pass 64-bit arguments in a single
register because some benchmark is slightly faster; with a wider user
base, we may get more suggestions for ABI changes that we should
reject).

> And vise-versa, if there is no need for a change, the ABI will be stable
> on my local branch, just like on staging branch you propose. I think it
> will be that way until there will appear strong community of users who
> will resist the changing of ABI. From this point of view, I don't see
> major difference for ILP32 where to host the patchset.

If we don't treat the ABI as stable now, regardless of the number of
users, then it is not ready for upstream (we already have a user in the
openSUSE build).

The arm64 git.kernel.org suggestion was more of an endorsement from the
maintainers that the ABI is stable. If you want to maintain it in your
own tree, that's fine by me. If you want wider visibility, we could
mirror it to git.kernel.org (though given how many trees are there, it
may not mean much).

> Is my understanding correct that you, Will and me will be responsible
> for rebasing and maintainance of patches? To be clear, this it not an
> automatic task - sometimes simple rebase take the whole day of my time,
> and I rebase almost every week. The rebase in 2-month timeframe may become
> unpredictable task, by time and amount of work. I think you understand what
> I mean, as once before you already told that the series is too intrusive.

I am fully aware there is significant effort to rebase the series and if
you can help maintain such branch it would be great. I don't see the
point of rebasing weekly though and it's not just the git handling
process but doing the validation of such branch, regression testing etc.

If it's too time consuming, we could do it only for LTS releases.

> To make it more easy for maintainance, I would suggest to split the series
> to 3 parts:
>  - arch and generic patches that not related to ilp32 or arm64 (already
>    done);

That's fine.

>  - arm64 patches that do cleanup and refactoring in aim to apply
>    ilp32 patches smoothly, but not ilp32-specific;

If there are such changes, that's fine. However, I wouldn't merge the
AARCH32_EL0 #ifdef'ery since it's unnecessary if we never merge the
ILP32 patches.

> If we'll follow your suggestion, does it mean that you expect the 4.12-based
> branch from me soon to put on staging?

We can create one for 4.12 if you want (in about 2-3 weeks time when I'm
back). If there is no rush we could aim for 4.13 (there are some
non-trivial conflicts in the sigframe handling code as we are preparing
it for SVE support).

> > The decision to merge upstream will be revisited every 6 months,
> > assessing the progress on the points I mentioned above, with a time
> > limit of 2 years
> 
> IIUC, this is your personal decision based on responses and comments
> from community?

Yes, as arm64 kernel maintainer.

> If so, I would like to ask you to do the first ILP32 community poll
> now, not in 6 months. So we'll collect opinions and requests from
> people interested in ILP32, and in 6 month will be able to check the
> progress. I would like to see this thread public because if we are not
> taking ILP32 to official sources right now, this is the only way to
> inform people that the project exists and is ready to use.

That's an ongoing process, I'm not going to ask for people's opinion
every 6 months. It's just that I will revisit periodically the progress
on automated testing, public availability of a cross-toolchain,
Tested/Acked/Reviewed-by tags on these patches from interested parties.
Since I haven't seen any of these now, I don't see any point in asking.

To be clear, I'm not really interested in "we need this too" opinions, I
get lots of these via the marketing channels. I'm looking for actual
users with a long-term view of making/keeping ILP32 a first class ABI.

-- 
Catalin
