From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 01:14:31 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170510080841.GG390@ZenIV.linux.org.uk>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <CAK8P3a2j6h2MAx3h2NCtadcFsNuFcf158F5OV1e2SK37acZRRg@mail.gmail.com>
 <20170510080841.GG390@ZenIV.linux.org.uk>
Message-ID: <20170510081431.GA16610@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 09:08:41AM +0100, Al Viro wrote:
> On Wed, May 10, 2017 at 09:37:04AM +0200, Arnd Bergmann wrote:
> 
> > > How about trying to remove all of them?  If we could actually get rid
> > > of all of them, we could drop the arch support, and we'd get faster,
> > > simpler, shorter uaccess code throughout the kernel.
> 
> BTW, not all get_user() under KERNEL_DS are plain loads.  There is an
> exception - probe_kernel_read().

And various calls that looks like opencoded versions, e.g. drivers/dio
or the ELF loader.

But in the long run we'll just need a separate primitive for that,
but that can wait until the set_fs calls outside the core code are
gone.
