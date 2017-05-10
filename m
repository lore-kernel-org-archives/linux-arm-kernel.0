From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 10 May 2017 04:21:37 +0100
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
Message-ID: <20170510032137.GD390@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 04:12:54AM +0100, Al Viro wrote:

> Broken commit: "net: don't play with address limits in kernel_recvmsg".
> It would be OK if it was only about data.  Unfortunately, that's not
> true in one case: svc_udp_recvfrom() wants ->msg_control.
> 
> Another delicate place: you can't assume that write() always advances
> file position by its (positive) return value.  btrfs stuff is sensitive
> to that.
> 
> ashmem probably _is_ OK with demanding ->read_iter(), but I'm not sure
> about blind asma->file->f_pos += ret.  That's?begging for races.  Actually,
> scratch that - it *is* racy.

kvec_length(): please, don't.  I would rather have the last remaining
iov_length() gone...   What do you need it for, anyway?  You have only
two users and both have the count passed to them (as *count and *cnt resp.)
