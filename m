From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 11:04:42 +0100
Subject: [PATCH] ARM: add warning for invalid kernel page faults
In-Reply-To: <20090928100048.GC30271@localhost>
References: <20090928092919.GA30271@localhost>
	<1254131304-32057-1-git-send-email-imre.deak@nokia.com>
	<20090928095516.GB6715@n2100.arm.linux.org.uk>
	<20090928100048.GC30271@localhost>
Message-ID: <20090928100442.GD6715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 01:00:48PM +0300, Imre Deak wrote:
> On Mon, Sep 28, 2009 at 11:55:16AM +0200, ext Russell King - ARM Linux wrote:
> > On Mon, Sep 28, 2009 at 12:48:24PM +0300, Imre Deak wrote:
> > > To easier detect code that can trigger the above error, add a check
> > > also for the case where mmap_sem is acquired. As this has an overhead
> > > make it a VM debug warning.
> > 
> > It _is_ already easy.  I'm not sure why you want even more noise, and
> > why you want to break the page fault handling.  From the warning you
> > received in your previous post, it said:
> 
> The problem is that it happens very rarely. Only if at the time of the
> fault the mmap_sem happens to be held. With the change the error would
> be apparent at the first fault the offending instruction generates.

Actually... I don't agree that your code can have any change what so
ever.

Condition 1:
                if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
                        goto no_context;

                down_read(&mm->mmap_sem);
+#ifdef CONFIG_DEBUG_VM

Condition 2:

+               if (!user_mode(regs) &&
+                   !search_exception_tables(regs->ARM_pc)) {
+                       static unsigned long last_warn_jiffies;

Condition 1 and condition 2 are identical.  They do not change on whether
the mmap_sem is held or not.  So please explain to me how you actually
get to printing any of your new warnings.
