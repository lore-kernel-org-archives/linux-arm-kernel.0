From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 23:53:29 +0000
Subject: [PATCH] scripts/kallsyms: filter symbols not in kernel address
 space
In-Reply-To: <20131031155831.4dce58a80c621cf450967de0@linux-foundation.org>
References: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
 <20131031154311.e65d16d79ba540ced736413b@linux-foundation.org>
 <20131031225022.GJ16735@n2100.arm.linux.org.uk>
 <20131031155831.4dce58a80c621cf450967de0@linux-foundation.org>
Message-ID: <20131031235329.GK16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 03:58:31PM -0700, Andrew Morton wrote:
> On Thu, 31 Oct 2013 22:50:22 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Thu, Oct 31, 2013 at 03:43:11PM -0700, Andrew Morton wrote:
> > > On Mon, 28 Oct 2013 23:48:59 +0800 Ming Lei <tom.leiming@gmail.com> wrote:
> > > 
> > > > This patch uses CONFIG_PAGE_OFFSET to filter symbols which
> > > > are not in kernel address space because these symbols are
> > > > generally for generating code purpose and can't be run at
> > > > kernel mode, so we needn't keep them in /proc/kallsyms.
> > > > 
> > > > For example, on ARM there are some symbols which are
> > > > linked in relocatable code section, then perf can't parse
> > > > symbols any more from /proc/kallsyms, and this patch fixes
> > > > the problem.
> > > 
> > > This is a non-back-compatible change and I'd like to see a much
> > > stronger assurance that it is safe to merge and will not break any
> > > existing application on the planet, please.
> > > 
> > > For a start, please describe with great precision what these excluded
> > > symbols are (examples would help) and explain why no application will
> > > conceivably have had any use for them.
> > 
> > These symbols are used to build what is relocatable code; the code which
> > ends up being placed in the machine vectors and the following page.
> > 
> > Rather than have to manually calculate them, I merged a patch which used
> > the tools we have, namely the assembler and linker, to do the job for us.
> 
> OK.  Do you recall which patch that was?  And is it the case that this
> patch excludes only the symbols which that patch accidentally added?

It's not a case of "accidentally added" - as we include all symbols in
kallsyms which are marked as text/data etc, irrespective of whether they
are local or global.

b9b32bf70f2fb made the change, backported to stable trees.  e39e3f3ebfef
depended on that change so that it could get at the correct offset to
copy FIQ code.

Both commits are part of closing an information leak from the kernel
as part of a security report back in July.
