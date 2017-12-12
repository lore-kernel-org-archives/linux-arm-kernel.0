From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 12 Dec 2017 21:54:05 +0100
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <20171212165728.GC15783@arm.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <20171212103635.GD28301@arm.com>
 <CAMuHMdVoqyWU3SRJ3zSdNNf_pJz9t_9fNYZ2EQr4JECTHRREJQ@mail.gmail.com>
 <CAMuHMdVnFyFv0Q6PaBEb6RpfJYkSzpvNUy8XtEWczES+uEO=6Q@mail.gmail.com>
 <20171212165728.GC15783@arm.com>
Message-ID: <CAMuHMdX1emac77CnKRbL_xEq4CFm6YyeNMHimFDUhEsDoeWBOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Dec 12, 2017 at 5:57 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Dec 12, 2017 at 05:00:33PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Dec 12, 2017 at 4:11 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Tue, Dec 12, 2017 at 11:36 AM, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Tue, Dec 12, 2017 at 11:20:09AM +0100, Geert Uytterhoeven wrote:
>> >>> During userspace (Debian jessie NFS root) boot on arm64:
>> >>>
>> >>> rpcbind[1083]: unhandled level 0 translation fault (11) at 0x00000008,
>> >>> esr 0x92000004, in dash[aaaaadf77000+1a000]
>> >>> CPU: 0 PID: 1083 Comm: rpcbind Not tainted
>> >>> 4.15.0-rc3-arm64-renesas-02176-g14f9a1826e48e355 #51
>> >>> Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
>> >>> pstate: 80000000 (Nzcv daif -PAN -UAO)
>> >>> pc : 0xaaaaadf8a51c
>> >>> lr : 0xaaaaadf8ac08
>> >>> sp : 0000ffffcffeac00
>> >>> x29: 0000ffffcffeac00 x28: 0000aaaaadfa1000
>> >>> x27: 0000ffffcffebf7c x26: 0000ffffcffead20
>> >>> x25: 0000aaaacea1c5f0 x24: 0000000000000000
>> >>> x23: 0000aaaaadfa1000 x22: 0000aaaaadfa1000
>> >>> x21: 0000000000000000 x20: 0000000000000008
>> >>> x19: 0000000000000000 x18: 0000ffffcffeb500
>> >>> x17: 0000ffffa22babfc x16: 0000aaaaadfa1ae8
>> >>> x15: 0000ffffa2363588 x14: ffffffffffffffff
>> >>> x13: 0000000000000020 x12: 0000000000000010
>> >>> x11: 0101010101010101 x10: 0000aaaaadfa1000
>> >>> x9 : 00000000ffffff81 x8 : 0000aaaaadfa2000
>> >>> x7 : 0000000000000000 x6 : 0000000000000000
>> >>> x5 : 0000aaaaadfa2338 x4 : 0000aaaaadfa2000
>> >>> x3 : 0000aaaaadfa2338 x2 : 0000000000000000
>> >>> x1 : 0000aaaaadfa28b0 x0 : 0000aaaaadfa4c30
>> >>>
>> >>> Sometimes it happens with other processes, but the main address, esr, and
>> >>> pstate values are always the same.
>> >>>
>> >>> I regularly run arm64/for-next/core (through bi-weekly renesas-drivers
>> >>> releases, so the last time was two weeks ago), but never saw the issue
>> >>> before until today, so probably v4.15-rc1 is OK.
>> >>> Unfortunately it doesn't happen during every boot, which makes it
>> >>> cumbersome to bisect.
>> >>>
>> >>> My first guess was UNMAP_KERNEL_AT_EL0, but even after disabling that,
>> >>> and even without today's arm64/for-next/core merged in, I still managed to
>> >>> reproduce the issue, so I believe it was introduced in v4.15-rc2 or
>> >>> v4.15-rc3.
>> >>
>> >> Urgh, this looks nasty. Thanks for the report! A few questions:
>> >>
>> >>  - Can you share your .config somewhere please?
>> >
>> > I managed to reproduce it on plain v4.15-rc3 using both arm64_defconfig, and
>> > renesas_defconfig (from Simon's repo).
>>
>> v4.15-rc2 is affected, too.
>
> Do you reckon you can bisect between -rc1 and -rc2? We've been unable to
> reproduce this on any of our systems, unfortunately.

I've tried, but ended up on an unrelated XFS merge commit. Probably I
marked a few commits good due to not seeing this heisenbug.

For reference, here's the bisect log.

Bad commits showed one or both of "unhandled level 0 translation fault" and
"invalid pointer". Good commits didn't show any during 6 tries.

git bisect start
# bad: [ae64f9bd1d3621b5e60d7363bc20afb46aede215] Linux 4.15-rc2
git bisect bad ae64f9bd1d3621b5e60d7363bc20afb46aede215
# good: [4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323] Linux 4.15-rc1
git bisect good 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
# good: [9e0600f5cf6cecfcab5046d1453a9538c054d8a7] Merge tag
'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 9e0600f5cf6cecfcab5046d1453a9538c054d8a7
# good: [503505bfea19b7d69e2572297e6defa0f9c2404e] Merge branch
'drm-fixes-4.15' of git://people.freedesktop.org/~agd5f/linux into
drm-fixes
git bisect good 503505bfea19b7d69e2572297e6defa0f9c2404e
# good: [ae753ee2771a1bacade56411bb98037b2545c929] Merge tag
'afs-fixes-20171201' of
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect good ae753ee2771a1bacade56411bb98037b2545c929
# good: [e1ba1c99dad92c5917b22b1047cf36e4426b124a] Merge tag
'riscv-for-linus-4.15-rc2_cleanups' of
git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux
git bisect good e1ba1c99dad92c5917b22b1047cf36e4426b124a
# bad: [2db767d9889cef087149a5eaa35c1497671fa40f] Merge tag
'nfs-for-4.15-2' of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect bad 2db767d9889cef087149a5eaa35c1497671fa40f
# good: [22a6c83777ac7c17d6c63891beeeac24cf5da450] xfs: ubsan fixes
git bisect good 22a6c83777ac7c17d6c63891beeeac24cf5da450
# bad: [788c1da05b73aee68ed98f05b577c308351f5619] Merge tag
'xfs-4.15-fixes-4' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad 788c1da05b73aee68ed98f05b577c308351f5619
# good: [3b42d385753c22b29d259ccb9d4c3f419e583b30] xfs: scrub inode
mode properly
git bisect good 3b42d385753c22b29d259ccb9d4c3f419e583b30
# good: [373b0589dc8d58bc09c9a28d03611ae4fb216057] xfs: Properly retry
failed dquot items in case of error during buffer writeback
git bisect good 373b0589dc8d58bc09c9a28d03611ae4fb216057
# first bad commit: [788c1da05b73aee68ed98f05b577c308351f5619] Merge
tag 'xfs-4.15-fixes-4' of
git://git.kernel.org/pub/scm/fs/xfs/xfs-linux

Tomorrow there's another day in bisection paradise...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
