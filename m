From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Sep 2013 10:08:57 +0100
Subject: [PATCH] ARM: entry: fix tracing of ARM-private syscalls
In-Reply-To: <20130918210911.GB11181@obsidianresearch.com>
References: <1379520765-20778-1-git-send-email-will.deacon@arm.com>
 <20130918210911.GB11181@obsidianresearch.com>
Message-ID: <20130919090857.GA24866@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 10:09:11PM +0100, Jason Gunthorpe wrote:
> On Wed, Sep 18, 2013 at 05:12:45PM +0100, Will Deacon wrote:
> > Commit 377747c40657 ("ARM: entry: allow ARM-private syscalls to be
> > restarted") reworked the low-level syscall dispatcher to allow
> > restarting of ARM-private syscalls. Unfortunately, this relocated the
> > label used to dispatch a private syscall from the trace path, so that
> > the invocation would be bypassed altogether!
> > 
> > This causes applications to fail under strace as soon as they rely on
> > a private syscall (e.g. set_tls):
> > 
> >   set_tls(0xb6fad4c0, 0xb6fadb98, 0xb6fb1050, 0xb6fad4c0, 0xb6fb1050)
> >       = -1 ENOSYS (Function not implemented)
> > 
> > This patch fixes the label so that we correctly dispatch private
> > syscalls from the trace path.
> > 
> > Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Worked here
> 
> Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Thanks Jason, I'll send this to Russell.

> This should probably go into the 3.11 stable series too?

This problem was introduced during the merge window, so 3.11 shouldn't be
affected.

Will
