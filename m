From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Sat, 09 Jul 2016 02:17:17 -0400
Subject: [kernel-hardening] Re: [PATCH 9/9] mm: SLUB hardened usercopy
 support
In-Reply-To: <57809299.84b3370a.5390c.ffff9e58SMTPIN_ADDED_BROKEN@mx.google.com>
References: <577f7e55.4668420a.84f17.5cb9SMTPIN_ADDED_MISSING@mx.google.com>
 <alpine.DEB.2.20.1607080844370.3379@east.gentwo.org>
 <CAGXu5jKE=h32tHVLsDeaPN1GfC+BB3YbFvC+5TE5TK1oR-xU3A@mail.gmail.com>
 <alpine.DEB.2.20.1607081119170.6192@east.gentwo.org>
 <CAGXu5j+UdkQA+k39GNLe5CwBPVD5ZbRGTCQLqS8VF=kWx+PtsQ@mail.gmail.com>
 <CAGXu5jKxw3RxWNKLX4XVCwJ6x_zA=_RwiU9jLDm2+VRO79G7+w@mail.gmail.com>
 <57809299.84b3370a.5390c.ffff9e58SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <24451.1468045037@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 Jul 2016 15:58:20 +1000, Michael Ellerman said:

> I then get two hits, which may or may not be valid:
>
> [    2.309556] usercopy: kernel memory overwrite attempt detected to d000000003510028 (kernfs_node_cache) (64 bytes)
> [    2.309995] CPU: 7 PID: 2241 Comm: wait-for-root Not tainted 4.7.0-rc3-00099-g97872fc89d41 #64
> [    2.310480] Call Trace:
> [    2.310556] [c0000001f4773bf0] [c0000000009bdbe8] dump_stack+0xb0/0xf0 (unreliable)
> [    2.311016] [c0000001f4773c30] [c00000000029cf44] __check_object_size+0x74/0x320
> [    2.311472] [c0000001f4773cb0] [c00000000005d4d0] copy_from_user+0x60/0xd4
> [    2.311873] [c0000001f4773cf0] [c0000000008b38f4] __get_filter+0x74/0x160
> [    2.312230] [c0000001f4773d30] [c0000000008b408c] sk_attach_filter+0x2c/0xc0
> [    2.312596] [c0000001f4773d60] [c000000000871c34] sock_setsockopt+0x954/0xc00
> [    2.313021] [c0000001f4773dd0] [c00000000086ac44] SyS_setsockopt+0x134/0x150
> [    2.313380] [c0000001f4773e30] [c000000000009260] system_call+0x38/0x108

Yeah, 'ping' dies with a similar traceback going to rawv6_setsockopt(),
and 'trinity' dies a horrid death during initialization because it creates
some sctp sockets to fool around with.  The problem in all these cases is that
setsockopt uses copy_from_user() to pull in the option value, and the allocation
isn't tagged with USERCOPY to whitelist it.

Unfortunately, I haven't been able to track down where in net/ the memory is
allocated, nor is there any good hint in the grsecurity patch that I can find
where they do the tagging.

And the fact that so far, I'm only had ping and trinity killed in setsockopt()
hints that *most* setsockopt() calls must be going through a code path that
does allocate suitable memory, and these two have different paths.  I can't
believe they're the only two binaries that call setsockopt().....

Just saw your second mail, now I'm wondering why *my* laptop doesn't die a
horrid death when systemd starts up.  Mine is
systemd-230-3.gitea68351.fc25.x86_64 - maybe there's something
release-dependent going on?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/c8bed600/attachment.sig>
