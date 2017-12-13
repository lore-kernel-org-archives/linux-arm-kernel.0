From: will.deacon@arm.com (Will Deacon)
Date: Wed, 13 Dec 2017 10:24:19 +0000
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <CAMuHMdX1emac77CnKRbL_xEq4CFm6YyeNMHimFDUhEsDoeWBOw@mail.gmail.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <20171212103635.GD28301@arm.com>
 <CAMuHMdVoqyWU3SRJ3zSdNNf_pJz9t_9fNYZ2EQr4JECTHRREJQ@mail.gmail.com>
 <CAMuHMdVnFyFv0Q6PaBEb6RpfJYkSzpvNUy8XtEWczES+uEO=6Q@mail.gmail.com>
 <20171212165728.GC15783@arm.com>
 <CAMuHMdX1emac77CnKRbL_xEq4CFm6YyeNMHimFDUhEsDoeWBOw@mail.gmail.com>
Message-ID: <20171213102418.GB27635@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for trying to bisect this.

On Tue, Dec 12, 2017 at 09:54:05PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 12, 2017 at 5:57 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Do you reckon you can bisect between -rc1 and -rc2? We've been unable to
> > reproduce this on any of our systems, unfortunately.
> 
> I've tried, but ended up on an unrelated XFS merge commit. Probably I
> marked a few commits good due to not seeing this heisenbug.
> 
> For reference, here's the bisect log.
> 
> Bad commits showed one or both of "unhandled level 0 translation fault" and
> "invalid pointer". Good commits didn't show any during 6 tries.
> 
> git bisect start
> # bad: [ae64f9bd1d3621b5e60d7363bc20afb46aede215] Linux 4.15-rc2
> git bisect bad ae64f9bd1d3621b5e60d7363bc20afb46aede215
> # good: [4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323] Linux 4.15-rc1
> git bisect good 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
> # good: [9e0600f5cf6cecfcab5046d1453a9538c054d8a7] Merge tag
> 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good 9e0600f5cf6cecfcab5046d1453a9538c054d8a7
> # good: [503505bfea19b7d69e2572297e6defa0f9c2404e] Merge branch
> 'drm-fixes-4.15' of git://people.freedesktop.org/~agd5f/linux into
> drm-fixes
> git bisect good 503505bfea19b7d69e2572297e6defa0f9c2404e
> # good: [ae753ee2771a1bacade56411bb98037b2545c929] Merge tag
> 'afs-fixes-20171201' of
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
> git bisect good ae753ee2771a1bacade56411bb98037b2545c929
> # good: [e1ba1c99dad92c5917b22b1047cf36e4426b124a] Merge tag
> 'riscv-for-linus-4.15-rc2_cleanups' of
> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux
> git bisect good e1ba1c99dad92c5917b22b1047cf36e4426b124a

^^ This one is the first "good" commit containing the arm64-fixes pull.
Maybe try stressing it a bit more and see if it also fails?

That said, I'm still suspicious that nobody else is seeing this -- I also
checked the various build/boot farms and everything looks ok.

Will
