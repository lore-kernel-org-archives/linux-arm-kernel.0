From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 26 Aug 2015 14:34:48 -0700
Subject: [PATCH v10 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <07a479863eef4c53ab2ef6ef85321680@agner.ch>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-3-git-send-email-stefan@agner.ch>
 <ff2e2716578a1ae5f0c4b0e0ca8bbdc3@agner.ch>
 <20150825195411.GJ81844@google.com>
 <07a479863eef4c53ab2ef6ef85321680@agner.ch>
Message-ID: <20150826213448.GU81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 10:57:38AM -0700, Stefan Agner wrote:
> On 2015-08-25 12:54, Brian Norris wrote:
> > On Mon, Aug 03, 2015 at 11:28:43AM +0200, Stefan Agner wrote:
> >> Btw, if the ECC check fails, the controller seems kind of count the
> >> amount of bitflips. It works for most devices reliable, but we had
> >> devices for which that number was not accurate, see:
> >> http://thread.gmane.org/gmane.linux.ports.arm.kernel/357439
> > 
> > I'm a little confused there. Why would you be expecting to get a count
> > of bitflips, when the ECC engine can't correct all errors? How is it
> > supposed to know what the "right" data is if the bit errors are beyond
> > the correction strength?
> 
> When printing the ECC error count on ECC fail when reading an erased
> NAND flash, the numbers of bit flips (stuck at zero) seem to widely
> correlate with the number returned by the controller. While it seems to
> correlate widely, there are exceptions, as discussed in the thread:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/295424
> 
> Maybe this is an artifact of the ECC algorithm we just can't/shouldn't
> rely on? I am not sure where this originated, I did not found any
> indication in the reference manual about what that value contains in the
> error case.

Doesn't sound too reliable to me. And I'm not sure even if it was
reliable, that it would provide much value. We have to a lot of
re-counting anyway, so we might as well just be using our own threshold.
Or maybe I'm missing the point.

> Bill, do you have an idea why we used that value as threshold in early
> implementations?
> 
> Otherwise I also think we should just drop the use of this value.

Brian
