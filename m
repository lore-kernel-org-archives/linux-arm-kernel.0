From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 01:25:18 +0100
Subject: [PATCH 5/9] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1386590958.7152.135.camel@host5.omatika.ru>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <52A59991.1060305@gmail.com> <1386590958.7152.135.camel@host5.omatika.ru>
Message-ID: <201312100125.18754.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, Sergei Ianovich wrote:
> On Mon, 2013-12-09 at 11:21 +0100, Daniel Mack wrote:
> > On 12/09/2013 10:34 AM, Sergei Ianovich wrote:
> > > Nice to have Daniel in this conversation. Your patch series is a big and
> > > important work. However, I am not sure I will ever land as is exactly
> > > for this reason.
> > 
> > Well, I wouldn't be so certain about that statement. As I wrote in the
> > cover letter, most of the work is actually done, and I successfully
> > tested the new DMA support with a some of the drivers I ported. Others
> > were ported blindly, and in case of no reaction, I'd dare to merge them
> > and wait for people to report back in case of trouble.
> 
> If breaking things is an option, I am definitely wrong. I assumed the
> opposite.

We never intentionally break things that people are using, but there are
cases where doing blind changes is the best way forward. We should
always try to find people to test patches on real hardware if possible,
which is only possible if there are people around that have the hardware
and that are going to run new kernels on them.

In case of PXA dmaengine support, I think the benefits of applying the
series far outweigh the breakage potential. A lot of the drivers are
shared with MMP, which is going to be DT-only eventually and will require
the new dmaengine code. Some PXA drivers may be shared with SA1100,
which has also converted to dmaengine although there are no plans to
ever support DT on sa1100.

> > > My proposal in to actually add new drivers for each platform device with
> > > DMA and mark new ones EXPERIMENTAL.
> > 
> > That would cause tree-wide cross-dependencies between drivers, because
> > the two DMA controllers can't be used at the same time, and the PXA
> > specific API will be unavailable when the mmp-dma driver is selected. My
> > patch series (and the DMA controller framework for that matter) aims for
> > the opposite - the unification of APIs and drivers.
> 
> Not sure I got this point. My proposal is to keep the existing DMA
> intact until we are ready to remove it. I understand this approach
> requires considerably more work inside DMA to allow both driver to
> coexist than wholesale replacement. I still think big change is risky.

We certainly need to be extra careful if we want to move things over
at once and cannot test all the drivers. I'd be happier if it could
be done gradually by having some drivers use the new interface and
other drivers use the old one, but I don't see how that can be done
here.

	Arnd
