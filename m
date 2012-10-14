From: zonque@gmail.com (Daniel Mack)
Date: Sun, 14 Oct 2012 17:35:23 +0200
Subject: [git pull] signals pile 3
In-Reply-To: <20121013005334.GM2616@ZenIV.linux.org.uk>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
Message-ID: <507ADBBB.9090209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On 13.10.2012 02:53, Al Viro wrote:
> The last bits of infrastructure for kernel_thread() et.al., with alpha/arm/x86
> use of those.  Plus sanitizing the asm glue and do_notify_resume() on alpha,
> fixing the "disabled irq while running task_work stuff" breakage there.
> 
> At that point the rest of kernel_thread/kernel_execve/sys_execve work can
> be done independently for different architectures.  The only pending bits
> that do depend on having all architectures converted are restrictred to
> fs/* and kernel/* - that'll obviously have to wait for the next cycle.
> I thought we'd have to wait for all of them done before we start eliminating
> the longjump-style insanity in kernel_execve(), but it turned out there's
> a very simple way to do that without flagday-style changes.
> 
> Please, pull from
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/signal for-linus
> 
> Shortlog:
> Al Viro (12):

[...]

>       arm: switch to saner kernel_execve() semantics

[...]

> Diffstat:

[...]

>  arch/arm/include/asm/unistd.h              |    1 -
>  arch/arm/kernel/entry-common.S             |   29 +--------
>  arch/arm/kernel/process.c                  |    5 +-

I rebased my ARM development branch and figured that your patch 9fff2fa
("arm: switch to saner kernel_execve() semantics") breaks the boot on my
board right after init is invoked via NFS:

[    4.682072] VFS: Mounted root (nfs filesystem) on device 0:12.
[    4.690744] devtmpfs: mounted
[    4.694395] Freeing init memory: 172K
[    5.291417] Internal error: Oops - undefined instruction: 0 [#1] SMP
THUMB2
[    5.298734] Modules linked in:
[    5.301952] CPU: 0    Not tainted  (3.6.0-11053-g56c8535 #128)
[    5.308071] PC is at cpsw_probe+0x422/0x9ac
[    5.312459] LR is at trace_hardirqs_on_caller+0x8f/0xfc
[    5.317934] pc : [<c03493de>]    lr : [<c005e81f>]    psr: 60000113
[    5.317934] sp : cf055fb0  ip : 00000000  fp : 00000000
[    5.329944] r10: 00000000  r9 : 00000000  r8 : 00000000
[    5.335413] r7 : 00000000  r6 : 00000000  r5 : c034458d  r4 : 00000000
[    5.342244] r3 : cf057a40  r2 : 00000000  r1 : 00000001  r0 : 00000000
[    5.349078] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment user
[    5.356546] Control: 50c5387d  Table: 8f434019  DAC: 00000015
[    5.362562] Process init (pid: 1, stack limit = 0xcf054240)
[    5.368395] Stack: (0xcf055fb0 to 0xcf056000)
[    5.372961] 5fa0:                                     00000001
00000000 00000000 00000000
[    5.381525] 5fc0: cf055fb0 c000d1a8 00000000 00000000 00000000
00000000 00000000 00000000
[    5.390091] 5fe0: 00000000 bee83f10 00000000 b6fdedd0 00000010
00000000 aaaabfaf a8babbaa
[    5.398664] Code: 2206a010 718ef508 0184f8da f8b1f65d (3070f8d8)
[    5.405049] ---[ end trace f92e44d0ab15d037 ]---
[    5.410424] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b


Looking at the patch, I see it does two things:

 a) kill the special treatment formerly done by ret_from_kernel_thread
 b) switch over to generic execve for ARM

I know too little about the internals here, but reverting the latter
part fixes the boot for me. Find attached the patch I used locally for
that, on top of Linus' current merge tree (4d7127d).

FWIW, the config I'm using is here: http://pastebin.com/JPwAYmrD

I can test patches if you have any for me.


Thanks,
Daniel

-------------- next part --------------
A non-text attachment was scrubbed...
Name: arm-execve-revert.diff
Type: text/x-patch
Size: 1511 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121014/bbce05db/attachment.bin>
