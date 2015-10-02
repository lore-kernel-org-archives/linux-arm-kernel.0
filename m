From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Oct 2015 13:48:27 -0500
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <20151002180255.GK12338@codeaurora.org>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org>
Message-ID: <20151002184827.GB5552@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 02, 2015 at 11:02:55AM -0700, Stephen Boyd wrote:
> On 10/02, Mason wrote:
> > [ Adding original reporter ]
> > 
> > On 02/10/2015 11:52, Mason wrote:
> > 
> > > [ take 1 was sent on 2015-03-26 ]
> > > 
> > > Hello everyone,
> > > 
> > > In http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348
> > > Stephen Boyd wrote:
> > > 
> > >> I don't see any problem with the TWD dropping the dependency on SMP.
> > >> The code should work the same on a UP configuration [...]
> > > 
> > > And Arnd recently said:
> > > 
> > >> I think this has come up before and should be fixed. Could you
> > >> send a patch that allows using TWD in uniprocessor configurations?
> > > 
> > > Basically, this means reverting Shawn Guo's 904464b91eca patch.
> > > and removing "depends on SMP" for HAVE_ARM_TWD.
> > > 
> > > However, Shawn's patch fixed an issue, therefore it seems likely
> > > that simply reverting is not the proper solution?
> > > 
> > > What should I do?
> > 
> > For reference, the warning used to be:
> > 
> >     ------------[ cut here ]------------
> >     WARNING: at arch/arm/kernel/smp_twd.c:345
> >     twd_local_timer_of_register+0x7c/0x90()
> >     twd_local_timer_of_register failed (-6)
> >     Modules linked in:
> >     Backtrace:
> >     [<80011f14>] (dump_backtrace+0x0/0x10c) from [<8044dd30>]
> >     (dump_stack+0x18/0x1c)
> >      r7:805e9f58 r6:805ba84c r5:80539331 r4:00000159
> >     [<8044dd18>] (dump_stack+0x0/0x1c) from [<80020fbc>]
> >     (warn_slowpath_common+0x54/0x6c)
> >     [<80020f68>] (warn_slowpath_common+0x0/0x6c) from [<80021078>]
> >     (warn_slowpath_fmt+0x38/0x40)
> >      r9:412fc09a r8:8fffffff r7:ffffffff r6:00000001 r5:80633b8c
> >     r4:80b32da8
> >     [<80021040>] (warn_slowpath_fmt+0x0/0x40) from [<805ba84]
> >     (twd_local_timer_of_register+0x7c/0x90)
> >      r3:fffffffa r2:8053934b
> >     [<805ba7d0>] (twd_local_timer_of_register+0x0/0x90) from [<805c0bec>]
> >     (imx6q_timer_init+0x18/0x4c)
> >      r5:80633800 r4:8053b701
> >     [<805c0bd4>] (imx6q_timer_init+0x0/0x4c) from [<805ba4e8>]
> >     (time_init+0x28/0x38)
> >      r5:80633800 r4:805dc0f4
> >     [<805ba4c0>] (time_init+0x0/0x38) from [<805b6854>]
> >     (start_kernel+0x1a0/0x310)
> >     [<805b66b4>] (start_kernel+0x0/0x310) from [<10008044>] (0x10008044)
> >      r8:1000406a r7:805f3f8c r6:805dc0c4 r5:805f0518 r4:10c5387d
> >     ---[ end trace 1b75b31a2719ed1c ]---
> > 
> > 
> > I cannot reproduce on v4.2 + my platform...
> 
> The warning has been removed in commit 5028090d1da1 (ARM: 8434/1:
> Revert "7655/1: smp_twd: make twd_local_timer_of_register() no-op
> for nosmp", 2015-09-14) sitting in linux-next. Oddly, that commit
> doesn't remove the depends on SMP for the Kconfig. So it seems
> that we can apply this patch and everyone is happy? We could also
> drop the "if SMP" part of most of the platform selects if anyone
> actually cares.

heh, sorry about that. I forgot omap2plus_defconfig enables everything. I could
refresh that patch if Russell is still okay taking a newer version of
it. Russell ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/5962cbea/attachment.sig>
