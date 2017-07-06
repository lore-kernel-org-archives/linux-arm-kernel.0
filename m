From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 7 Jul 2017 00:59:02 +0300
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
Message-ID: <20170706215902.qtmbsidwvqlr7o56@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, Jun 29, 2017 at 05:10:36PM +0100, Catalin Marinas wrote:
> Hi Yury,
> 
> On Mon, Jun 19, 2017 at 06:49:43PM +0300, Yury Norov wrote:
> > This series enables aarch64 with ilp32 mode.
> 
> Thanks for putting this series together, I do appreciate the effort.
> There are still some review comments coming in but I'm happy with how
> the ABI looks now. I did some LTP testing (AArch64/LP64, AArch64/ILP32,
> AArch32) and benchmarking and didn't see any regressions (apart from an
> LTP bug with sync_file_range2). James Morse is working on reproducing
> similar testing in ARM. Szabolcs reported some glibc test-suite
> regressions on the libc-alpha list which I assume will be followed up.
> VDSO in C is another issue I'd like sorted but this is not strictly
> specific to ILP32 and can be done as a follow up. Note that I didn't run
> any big-endian tests, though this is something that needs doing.
> 
> Now, having agreed on the ABI and implementation very close to being
> ready doesn't necessarily make the code suitable for upstream. With my
> maintainer hat on, I'm trying to see where ILP32 will be in 2-5-10
> years, whether anyone still cares about it in this time frame. The
> difference from a driver or SoC support is that ABIs are very hard to
> revert, though are as (or even more) likely to bit-rot when not in use
> or regularly tested (we have the big-endian experience here).
> 
> There are two main aspects to make the code upstream-worthy:
> 
> 1. Actual/real users (current, future). I don't mean just a few distros
>    showing that it can be done but actual/planned real deployments
> 
> 2. Long term testing/maintenance plan. This is not about kernel code
>    maintenance but a healthy ILP32 ecosystem:
>    a) readily available toolchains (x86-hosted and AArch64-hosted)
>    b) filesystems (can be large distros like openSUSE or more
>       embedded-oriented like Yocto or OpenEmbedded)
>    c) suitable continuous regression testing (kernel + userland)
>    d) commitment from all parties involved (including ARM Ltd) to treat
>       the ILP32 ABI as a (nearly) first class citizen
> 
> It is pretty clear from private discussions that there are potential
> users but at the moment I can't tell if those would turn into real
> deployments of production systems. As for (2), the long term plans are
> not convincing (or I haven't spotted them yet), so I'd like to see the
> interested parties putting a plan together (something along the lines of
> kernelci.org + LTP, glibc buildbot).
> 
> What I'd like to propose is that Will and I (as arm64 maintainers, maybe
> with with the help of others including this series' authors) take over
> the series and push it to a staging branch under the arm64 kernel on
> git.kernel.org. This is aimed as a commitment to keep the ABI *stable*
> and will be rebased with every kernel release (starting with 4.13). The
> decision to merge upstream will be revisited every 6 months, assessing
> the progress on the points I mentioned above, with a time limit of 2
> years when, if still not upstream, we will stop maintaining such branch.
> 
> I am aware that the above proposal has an impact on the glibc patches
> since they will not merge a new ABI upstream until officially supported
> by the kernel. I cc'ed some of the glibc developers and they will follow
> up on the libc-alpha list.

Thanks for the email. I appreciate your concern about long-term
support load for a new ABI. I also think that stabilizing the ABI
is a good idea.

At this point, most people expect the ABI to not change unless
critical issues are uncovered. IMO, if there is a good technical reason
to change the ABI -- the change will happen even on the "staging" branch.
And vise-versa, if there is no need for a change, the ABI will be stable
on my local branch, just like on staging branch you propose. I think it
will be that way until there will appear strong community of users who
will resist the changing of ABI. From this point of view, I don't see
major difference for ILP32 where to host the patchset.

Is my understanding correct that you, Will and me will be responsible
for rebasing and maintainance of patches? To be clear, this it not an
automatic task - sometimes simple rebase take the whole day of my time,
and I rebase almost every week. The rebase in 2-month timeframe may become
unpredictable task, by time and amount of work. I think you understand what
I mean, as once before you already told that the series is too intrusive.
To make it more easy for maintainance, I would suggest to split the series
to 3 parts:
 - arch and generic patches that not related to ilp32 or arm64 (already
   done);
 - arm64 patches that do cleanup and refactoring in aim to apply
   ilp32 patches smoothly, but not ilp32-specific;
 - ilp32-specific patches.

I suggest that we push 1st and 2nd groups to linux-next as there is no
ilp32-specific code, and these changes don't add to the maintenance
overhead of the port. On the other hand, having these patches in linux
master will significantly reduce the effort to maintain ILP32 staging
branch, making rebases much less painful.

If we'll follow your suggestion, does it mean that you expect the 4.12-based
branch from me soon to put on staging?

> The decision to merge upstream will be revisited every 6 months,
> assessing
> the progress on the points I mentioned above, with a time limit of 2
> years

IIUC, this is your personal decision based on responses and comments
from community? If so, I would like to ask you to do the first
ILP32 community poll now, not in 6 months. So we'll collect opinions
and requests from people interested in ILP32, and in 6 month will be
able to check the progress. I would like to see this thread public
because if we are not taking ILP32 to official sources right now,
this is the only way to inform people that the project exists and is
ready to use.

Thanks for kind words on the work,
Yury
