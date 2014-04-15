From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 13:46:27 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415174330.GA10558@redhat.com>
References: <20140415154637.GA3560@redhat.com> <534D6A1F.70102@linaro.org>
 <20140415174330.GA10558@redhat.com>
Message-ID: <20140415.134627.1895466146177627985.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 15 Apr 2014 19:43:30 +0200

> Finally, let me repeat, you should verify that this
> __copy_to_user_page(page, uaddr, kaddr) will not something bad if uaddr
> is not mmapped, or its mapping do not match area->page.

Just directly access userspace with the usual exception mechanism we
use for copy_to_user(), put_user(), et al. and if it faults you'll get
-EFAULT and handle it.

This also avoids the D-cache aliasing issues entirely as I explained
in my other reply.
