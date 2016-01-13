From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Jan 2016 18:47:07 +0000
Subject: [RFC] arm64: failed when run the command: timedatectl
 set-timezone Asia/Shanghai
In-Reply-To: <569682AE.3020300@codeaurora.org>
References: <56946932.70601@huawei.com> <569473B2.3030909@huawei.com>
 <CAPvkgC3HkZ5nP4qxDO+LRCeK5dd29zEpz9ZeK7J_mrCWXrszGA@mail.gmail.com>
 <5695A57B.1060905@huawei.com> <20160113110900.GA23370@leverpostej>
 <569682AE.3020300@codeaurora.org>
Message-ID: <20160113184707.GN23370@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 12:00:30PM -0500, Christopher Covington wrote:
> On 01/13/2016 06:09 AM, Mark Rutland wrote:
> > On Wed, Jan 13, 2016 at 09:16:43AM +0800, Xishi Qiu wrote:
> >> In your issue, Tom Schuster said it sounds like bug 910845
> >> https://bugzilla.mozilla.org/show_bug.cgi?id=910845
> > 
> > Controlled allocation as in this patch is probably a workable approach.
> > 
> > However, the arm64 kernel can be built with a very small VA range, and
> > the base chosen is outside of the minimum range. The kernel currently
> > goes as low as 36 bits (with 16K pages), though the architectural
> > minimum seems to be 24 currently.
> > 
> > To be safe for all configurations, I guess the best option is to
> > allocate as close to zero as possible, or to dynamically choose a base
> > depending on the VA range. I'm not sure how to correctly determine the
> > VA range from userspace, however.
> 
> Below is how I ended up determining TASK_SIZE for Checkpoint/Restore In
> Userspace (CRIU).
> 
> https://github.com/xemul/criu/commit/c0c0546c31e6df4932669f4740197bb830a24c8d

That's very scary. Any pages on a power of two boundary would get
unmapped, silently. That will corrupt data.

As above, the hard-code assumptions of a 39-bit minimum and a 48-bit
maximum are erroneous.

> If this is too hacky, my thought on a more proper interface would be to
> parallel how PAGE_SIZE is communicated. TASK_SIZE could be added to the
> ELF auxiliary vector, such that one could simply run `getconf TASK_SIZE`
> and sysconf(TASK_SIZE).

Assuming we don't have a reliable and safe mechanism already, something
like that sounds sensible to me.

Thanks,
Mark.
