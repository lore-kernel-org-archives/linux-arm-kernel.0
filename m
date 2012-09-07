From: balbi@ti.com (Felipe Balbi)
Date: Fri, 7 Sep 2012 08:49:34 +0300
Subject: [PATCH v4 00/21] OMAP UART Patches
In-Reply-To: <87harahiv6.fsf@deeprootsystems.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
 <87harahiv6.fsf@deeprootsystems.com>
Message-ID: <20120907054932.GB3136@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 06, 2012 at 03:44:13PM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Hi guys,
> >
> > here's v4 of the omap uart patchset. No changes other than a rebase on top of
> > Greg's tty-next branch and Tony's Acked-by being added to a couple patches
> >
> > Note: I'm resending the series with Vikram's Software Flow Control fix anyway
> > as it can just be ignored if it's decided it needs to go into this merge
> > window.
> 
> Sorry to be late to the party... just getting back from some time off.
> 
> I'm assuming that this was not tested with PM, so decided I better do it

you assumed wrong. See the previous versions of the series and you'll
see I mention all the basic pm testing I did.

> myself seeing that Greg is has already merge it.  To test, I merged
> Greg's tty-next branch with v3.6-rc4 and did some PM testing.
> 
> The bad news is that it doesn't even compile (see reply to [PATCH v4
> 20/21]).  

yeah, that was an automerge issue when rebasing on greg's tty-next
branch, plus me assuming omap serial was already enabled on my .config
and not checking the compile output. Sent a patch now.

> Also, there is a big WARNING on boot[1], which seems to be triggered by
> a new check added for v3.6-rc3[2].  This appears to be introduced by
> $SUBJECT series, because I don't see it on vanilla v3.6-rc4.
> 
> The good news is that after hacking to fix up the compile problems,
> basic PM testing seems to be fine: idle to retention and off as well as
> suspend to retention and off work fine on 3430/n900, 3530/Overo,
> 3730/OveroSTORM, 3730/Beagle-xM.
> 
> Kevin
> 
> 
> [1]
> [    8.745666] WARNING: at /work/kernel/omap/pm/drivers/tty/tty_io.c:1420 tty_init_dev+0x14c/0x17c()
> [    8.755218] tty_init_dev: ttyO driver does not set tty->port. This will crash the kernel later. Fix the driver!
> [    8.765991] Modules linked in:
> [    8.769287] [<c0013d90>] (unwind_backtrace+0x0/0xf0) from [<c0036eec>] (warn_slowpath_common+0x4c/0x64)
> [    8.779327] [<c0036eec>] (warn_slowpath_common+0x4c/0x64) from [<c0036f98>] (warn_slowpath_fmt+0x30/0x40)
> [    8.789550] [<c0036f98>] (warn_slowpath_fmt+0x30/0x40) from [<c02c626c>] (tty_init_dev+0x14c/0x17c)
> [    8.799224] [<c02c626c>] (tty_init_dev+0x14c/0x17c) from [<c02c68a4>] (tty_open+0x11c/0x52c)
> [    8.808258] [<c02c68a4>] (tty_open+0x11c/0x52c) from [<c00f86ac>] (chrdev_open+0x90/0x15c)
> [    8.817108] [<c00f86ac>] (chrdev_open+0x90/0x15c) from [<c00f2b74>] (do_dentry_open+0x1e8/0x270)
> [    8.826507] [<c00f2b74>] (do_dentry_open+0x1e8/0x270) from [<c00f2c30>] (finish_open+0x34/0x4c)
> [    8.835784] [<c00f2c30>] (finish_open+0x34/0x4c) from [<c0102028>] (do_last.isra.21+0x5b0/0xbbc)
> [    8.845184] [<c0102028>] (do_last.isra.21+0x5b0/0xbbc) from [<c01026dc>] (path_openat+0xa8/0x44c)
> [    8.854675] [<c01026dc>] (path_openat+0xa8/0x44c) from [<c0102d34>] (do_filp_open+0x2c/0x80)
> [    8.863708] [<c0102d34>] (do_filp_open+0x2c/0x80) from [<c00f3b6c>] (do_sys_open+0xe8/0x184)
> [    8.872711] [<c00f3b6c>] (do_sys_open+0xe8/0x184) from [<c000db20>] (ret_fast_syscall+0x0/0x3c)
> [    8.882019] ---[ end trace e9bf408c37051346 ]---

This doesn't seem to be caused by $SUBJECT at all. See that we are
calling uart_add_one_port() which will call tty_port_register_device()
which, in turn, will call tty_port_link_device() and that will set
driver->ports[index] correctly.

Have you checked if this doesn't happen without my series before waving
your blame hammer ? FWIW, that part of the code wasn't change by
$SUBJECT at all.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120907/2a213f45/attachment.sig>
