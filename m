From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Aug 2010 22:21:56 +0100
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
Message-ID: <20100811212156.GB827@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 12:22:54AM +0530, DebBarma, Tarun Kanti wrote:
> True; however if we go by that argument than we can also assume pdata
> is valid, so that we would not need the below check.

If pdev was ever NULL in a probe function, the kernel deserves to OOPS
so that you have a backtrace to fix the bugger.

Basically, a probe function is only called when the driver finds a
matching device to bind to - so the device _must_ already exist and
be valid.  It's basically guaranteed.  So checking for a NULL pdev is
not only a waste of space, it's a waste of CPU time and developer time
writing the check as well.

On the other hand, platform data passed in via a platform device _is_
liable to be NULL if whatever created the platform device didn't
set the platform data up.  So we can't guarantee that the platform
data will exist.  So a NULL check is appropriate here.

So, if an API in normal operation requires non-NULL data to be passed,
don't bother checking for a NULL pointer.  If you're passed a NULL
pointer in this situation, you deserve to OOPS so you get a backtrace
to fix the problem rather than silently ignoring the problem.
