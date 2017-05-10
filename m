From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 May 2017 23:49:57 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170510024524.GB390@ZenIV.linux.org.uk>
References: <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170509130250.GA11381@infradead.org>
 <20170509160322.GA15902@infradead.org>
 <20170510021118.GA390@ZenIV.linux.org.uk>
 <20170510024524.GB390@ZenIV.linux.org.uk>
Message-ID: <20170510064957.GB4115@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 03:45:24AM +0100, Al Viro wrote:
> FWIW, some parts of that queue are obviously sane; it's the conversions of
> kernel_write() and friends to ->read_iter/->write_iter() that are non-starters.

And that part is the main point!

> That stuff is used in too many situations; we can't guarantee that all of
> them will be for files that have those.

That's why this series handles ITER_KVEC for this case, which is all
that's really needed for kernel_read/write.  If you insiste the bvec
and pipe cases are handled as well that couod be added fairly easily.

> As for default_file_splice_read(), I seriously suspect that with your change
> we could as well just make it return -EINVAL and be done with that; places
> that have ->read_iter() tend to have explicit ->splice_read() and it looks
> like the ones that do not should simply use generic_file_read_iter().
> I hadn't checked that, but there's not a lot of those:

Making ->splice_read to default to the ->read_iter based implementation
and returning -EINVAL if neither that nor an explicit ->splice_read
is provided is useful, but wasn't the aim of this series.  Similar
on the write side.
