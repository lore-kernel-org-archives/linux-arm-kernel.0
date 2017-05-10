From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 May 2017 23:53:01 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170510031254.GC390@ZenIV.linux.org.uk>
References: <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <20170510021118.GA390@ZenIV.linux.org.uk>
 <20170510024524.GB390@ZenIV.linux.org.uk>
 <20170510031254.GC390@ZenIV.linux.org.uk>
Message-ID: <20170510065301.GC4115@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 04:12:54AM +0100, Al Viro wrote:
> What's the point?  What's wrong with having kernel_read()/kernel_readv()/etc.?
> You still have set_fs() in there; doing that one level up in call chain would
> be just fine...  IDGI.

The problem is that they modify the address limit, which the whole
subthread here wants to get rid of.

> Broken commit: "net: don't play with address limits in kernel_recvmsg".
> It would be OK if it was only about data.  Unfortunately, that's not
> true in one case: svc_udp_recvfrom() wants ->msg_control.

Dropped, but we'll need to fix that eventually.

> Another delicate place: you can't assume that write() always advances
> file position by its (positive) return value.  btrfs stuff is sensitive
> to that.

If we don't want to assume that we need to pass pointer to pos to
kernel_read/write.  Which might be a good idea in general.

> ashmem probably _is_ OK with demanding ->read_iter(), but I'm not sure
> about blind asma->file->f_pos += ret.  That's?begging for races.  Actually,
> scratch that - it *is* racy.

I think the proper fix is to not even bother to maintain f_pos of the
backing file, as we don't ever use it - all reads from it pass in
an explicit position anyway.
