From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Aug 2018 18:11:32 +0100
Subject: [PATCH RESEND] arm64: don't dump stack for usermode address in
 show_regs
In-Reply-To: <e5f4011a-e0a0-b5be-599f-5adc32155d87@huawei.com>
References: <0003f02c-fc35-b4e9-3d3d-82ee8d02acb7@huawei.com>
 <20180829115402.GB1125@arm.com>
 <e5f4011a-e0a0-b5be-599f-5adc32155d87@huawei.com>
Message-ID: <20180829171131.GA11160@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 10:58:00PM +0800, Ding Tianhong wrote:
> On 2018/8/29 19:54, Will Deacon wrote:
> > This looks like we're somehow dereferencing the user frame-pointer from the
> > READ_ONCE_NOCHECK in unwind_frame(). However, I really don't see how that
> > can happen, since the kernel entry code pushes a dummy frame record or
> > zeroes, which will terminate any backtrace before we hit the user
> > addresses. Furthermore, we explicitly check that the frame pointer points
> > to an accessible stack before we dereference it. Hmm.
> > 
> 
> I found the patch 12964443e8d1 ("arm64: add on_accessible_stack()")
> already fix this in kernel v4.14, my kernel version is older than this and
> miss this patch for a long time, so I think this is the reason that I met
> this problem, thanks for remind me.

Ok, but in future please state up-front if you're reporting an issue that
you're seeing on something older than mainline. I spent an hour reading
through this code today looking for a bug we'd already fixed :(

Will
