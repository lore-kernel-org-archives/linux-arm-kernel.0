From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 14 Aug 2018 09:22:10 -0700
Subject: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
In-Reply-To: <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
 <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
Message-ID: <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 8:24 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Looks like it's coming from that fsync():
>
>   sys_fsync
>     do_fsync
>       vfs_fsync_range
>         blkdev_fsync
>           blkdev_issue_flush
>
> I think we need to teach blkdev_issue_flush() to bail out if the bdev
> is read-only, similar to blkdev_issue_discard(), _write_zeroes(), etc.
> The question is which error code to use.  blkdev_fsync() already skips
> over EOPNOTSUPP, so it is a (no-so-good) option.  Other blkdev_issue_
> functions return EPERM.

Oh, just make issue_flush() return EROFS for a read-only device.

Or maybe we should even just consider the flush to be a read operation?

But I guess the error code gets percolated all the way to user space?
The safest option might just be to return 0.

               Linus
