From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Wed, 4 Dec 2013 16:37:36 +0100
Subject: [GIT PULL] Cacheflush updates for 3.12
In-Reply-To: <20130812173155.GI25995@mudshark.cambridge.arm.com>
References: <20130812173155.GI25995@mudshark.cambridge.arm.com>
Message-ID: <CAH9NwWd1AfN_YnO-fj94+wTbE8768H518=EndVcX=dFCV9WESg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/12 Will Deacon <will.deacon@arm.com>:
> Hello again,
>
> Please pull the following user-cacheflush updates for 3.12. This series both
> improves performance of cacheflush-heavy workloads (i.e. browser benchmarks)
> and also addresses a DoS issue on non-preemptible systems.
>
> Will
>
> --->8
>
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/cacheflush
>
> for you to fetch changes up to d3065541b5a95e5d0ef37e0dc8ada80fd1fba963:
>
>   ARM: cacheflush: don't bother rounding to nearest vma (2013-07-22 10:49:00 +0100)
>
> ----------------------------------------------------------------
> Will Deacon (4):
>       ARM: entry: allow ARM-private syscalls to be restarted
>       ARM: cacheflush: split user cache-flushing into interruptible chunks
>       ARM: cacheflush: don't round address range up to nearest page
>       ARM: cacheflush: don't bother rounding to nearest vma
>

Hi all.

I spend the last day running a bisect and I think I have found a problem :)

I have a simple automated test case running, which looks like this:

imx6d based device running X, chromium and x11vnc <----> windows pc connected
via VNC to the device. With this patchset applyed the browser tab
crashed after about
5 minutes hitting the F5/refresh button every 1-3 seconds.

The last good kernel is 3.11.10 and the first bad one is 3.12. This is
the result of my bisect:

root at arm:~/kernel/linux-3.12.2# cat ~/bisect.log
Bisecting: a merge base must be tested
[6e4664525b1db28f8c4e1130957f70a94c19213e] Linux 3.11
Bisecting: 5700 revisions left to test after this (roughly 13 steps)
[cc998ff8811530be521f6b316f37ab7676a07938] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
Bisecting: 2850 revisions left to test after this (roughly 12 steps)
[f9121153fdfbfaa930bf65077a5597e20d3ac608] mm/hwpoison: don't need to
hold compound lock for hugetlbfs page
Bisecting: 1428 revisions left to test after this (roughly 11 steps)
[327fff3e1391a27dcc89de6e0481689a865361c9] Merge branch 'misc' of
git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild
Bisecting: 775 revisions left to test after this (roughly 10 steps)
[8e73e367f7dc50f1d1bc22a63e5764bb4eea9b48] Merge tag
'cleanup-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
Bisecting: 247 revisions left to test after this (roughly 8 steps)
[39eda2aba6be642b71f2e0ad623dcb09fd9d79cf] Merge branch 'next' of
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc
Bisecting: 205 revisions left to test after this (roughly 8 steps)
[22e04f6b4b04a8afe9af9239224591d06ba3b24d] Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid
Bisecting: 110 revisions left to test after this (roughly 7 steps)
[2e032852245b3dcfe5461d7353e34eb6da095ccf] Merge branch 'for-linus' of
git://git.linaro.org/people/rmk/linux-arm
Bisecting: 55 revisions left to test after this (roughly 5 steps)
[5cc91e0460889c8461620904968e193dddb1beb3] Merge branch
'for-rmk/cacheflush-v2' of
git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into
devel-stable
Bisecting: 11 revisions left to test after this (roughly 4 steps)
[6af396a6b6c698eb3834184518fc9a59bc22c817] ARM: cacheflush: use -ishst
dsb variant for ensuring flush completion
Bisecting: 5 revisions left to test after this (roughly 3 steps)
[b4f656eea63376da79b0b5a17660c4ce14b71b74] Pull branch 'for-rmk' of
git://git.linaro.org/people/ardbiesheuvel/linux-arm into devel-stable
Bisecting: 2 revisions left to test after this (roughly 2 steps)
[d9524dc32cab52714dee0c8e59c7437ee33a239a] ARM: cacheflush: don't
round address range up to nearest page
Bisecting: 0 revisions left to test after this (roughly 1 step)
[28256d612726a28a8b9d3c49f2b74198c4423d6a] ARM: cacheflush: split user
cache-flushing into interruptible chunks
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[377747c40657eb35ad98a56439606d96a928425a] ARM: entry: allow
ARM-private syscalls to be restarted
28256d612726a28a8b9d3c49f2b74198c4423d6a is the first bad commit
commit 28256d612726a28a8b9d3c49f2b74198c4423d6a
Author: Will Deacon <will.deacon@arm.com>
Date:   Mon May 13 15:21:49 2013 +0100

    ARM: cacheflush: split user cache-flushing into interruptible chunks

    Flushing a large, non-faulting VMA from userspace can potentially result
    in a long time spent flushing the cache line-by-line without preemption
    occurring (in the case of CONFIG_PREEMPT=n).

    Whilst this doesn't affect the stability of the system, it can certainly
    affect the responsiveness and CPU availability for other tasks.

    This patch splits up the user cacheflush code so that it flushes in
    chunks of a page. After each chunk has been flushed, we may reschedule
    if appropriate and, before processing the next chunk, we allow any
    pending signals to be handled before resuming from where we left off.

    Signed-off-by: Will Deacon <will.deacon@arm.com>

:040000 040000 33ebf747dde46884ce4e7d4ce922fef3cd5b580e
22cdb8a0bc6dc72cb92d93c13ed1a45081269f77 M      arch


If I revert 28256d612726a28a8b9d3c49f2b74198c4423d6a and
97c72d89ce0ec8c73f19d5e35ec1f90f7a14bed7 my "test" runs hours.


What debug options should I enable to get meaningful output from the kernel?


greets
--
Christian Gmeiner, MSc
