From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 00:35:34 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170510072746.GF390@ZenIV.linux.org.uk>
References: <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <20170510021118.GA390@ZenIV.linux.org.uk>
 <20170510024524.GB390@ZenIV.linux.org.uk>
 <20170510031254.GC390@ZenIV.linux.org.uk>
 <20170510065301.GC4115@infradead.org>
 <20170510072746.GF390@ZenIV.linux.org.uk>
Message-ID: <20170510073534.GA19359@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 08:27:47AM +0100, Al Viro wrote:
> And you *still* do the same.  Christoph, this is ridiculous - the worst
> part of the area is not a couple of functions in fs/read_write.c, it's
> a fucking lot of ->read() and ->write() instances in shitty driver code,
> pardon the redundance.  And _that_ is still done under set_fs(KERNEL_DS).

For now yes.  But it provides a sane API on top, and then we can
start moving the drivers that matter to the iter variants and drop
support for the rest soon.  Most in-kernel I/O is done to files, and
the rest to a very limited set of devices. (not accounting for sockets
through their own APIs, thats another story)

> That's what I'm objecting to.  Centralized kernel_readv() et.al. - sure,
> and fs/read_write.c is the right place for those.  No arguments here.
> Conversion to those - absolutely; drivers have no fucking business touching
> set_fs() at all.  But your primitives are trouble waiting to happen.
> Let them take kvec arrays.  And let them, in case when there's no
> ->read_iter()/->write_iter(), do set_fs().  Statically, without this
> if (iter->type & ITER_KVEC) ... stuff.

Oh we?l.  I can do that first, but I think eventually we'll have to
get back to what I've done now.
