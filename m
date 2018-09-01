From: mirq-linux@rere.qmqm.pl (=?iso-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Sat, 1 Sep 2018 15:45:31 +0200
Subject: [PATCH v2 00/12] remove_conflicting_framebuffers() cleanup
In-Reply-To: <153570646209.15613.3061584574975657074@skylake-alporthouse-com>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
 <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
 <20180831090439.GT21634@phenom.ffwll.local>
 <153570646209.15613.3061584574975657074@skylake-alporthouse-com>
Message-ID: <20180901134531.GA23402@qmqm.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 10:07:42AM +0100, Chris Wilson wrote:
[...]
> Ahah, someone is looking at remove_conflicting_framebuffers(). May I
> interest you in a use-after-free?

> [  378.423513] stack segment: 0000 [#1] PREEMPT SMP PTI
> [  378.423530] CPU: 1 PID: 4338 Comm: pm_rpm Tainted: G     U            4.19.0-rc1-CI-CI_DRM_4746+ #1
> [  378.423548] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./J4205-ITX, BIOS P1.10 09/29/2016
> [  378.423570] RIP: 0010:do_remove_conflicting_framebuffers+0x56/0x170
> [  378.423587] Code: 49 8b 45 00 48 85 c0 74 50 f6 40 0a 08 74 4a 4d 85 e4 48 8b a8 78 04 00 00 74 1f 48 85 ed 74 1a 41 8b 0c 24 31 db 85 c9 74 10 <8b> 55 00 85 d2 75 42 83 c3 01 41 39 1c 24 77 f0 48 85 ed 74 1a 45
> [  378.423620] RSP: 0018:ffffc900001dfa88 EFLAGS: 00010202
> [  378.423632] RAX: ffff880274470008 RBX: 0000000000000000 RCX: 0000000000000001
> [  378.423646] RDX: 0000000000000001 RSI: ffffffffa025c634 RDI: ffff88025cc3b428
> [  378.423660] RBP: 6b6b6b6b6b6b6b6b R08: 000000001edaddfa R09: ffffffffa025c634
> [  378.423673] R10: ffffc900001dfae8 R11: ffffffff820de938 R12: ffff88025cc3b428
> [  378.423687] R13: ffffffff8234ca20 R14: ffffffff8234cb20 R15: 0000000000000001
> [  378.423701] FS:  00007fcf03d0a980(0000) GS:ffff880277e80000(0000) knlGS:0000000000000000
> [  378.423717] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  378.423729] CR2: 00007fffece1fdb8 CR3: 00000001fe32e000 CR4: 00000000003406e0
> [  378.423742] Call Trace:
> [  378.423756]  remove_conflicting_framebuffers+0x28/0x40
> [  378.423856]  i915_driver_load+0x7f5/0x10c0 [i915]
[...]

Looks like registered_fb[] entry is pointing to (partially?) freed or
corrupted fb_info, but I can't see how this could be an effect of
remove_conflicting_framebuffers().

Best Regards,
Micha? Miros?aw
