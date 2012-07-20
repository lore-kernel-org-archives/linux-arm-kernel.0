From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 Jul 2012 22:30:11 -0600
Subject: Boot breaks in -next from LEGACY to LINEAR conversion
In-Reply-To: <20120718161023.GE4495@opensource.wolfsonmicro.com>
References: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
 <20120718161023.GE4495@opensource.wolfsonmicro.com>
Message-ID: <CACxGe6utvV6XbJEck_UuVJxsqckPFZXG3psEgeQ1vZSBGAwm9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 10:10 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 17, 2012 at 07:57:49PM +0100, Mark Brown wrote:
>> -next fails to boot for me today on my s3c64xx based systems.  Walking
>> back to the last time I tried and bisecting likely branches I find that
>> commit 910139 (irqdomain: Replace LEGACY mapping with LINEAR) is the one
>> that introduces the build break.  Unfortunately the boot fails before I
>> get a console which makes diagnosis somewhat more tricky than would be
>> ideal.  Any ideas?
>
> Further data: the irq_domain_associate_many() calls that we're now doing
> are also causing WARN_ON()s to go off during boot after commit 98aa46
> (irqdomain: Support for static IRQ mapping and association) causing
> breakage for my interrupt using MFDs.

Okay, I've got a theory about what the issue is now. The .map()
callback is failing (returning non-zero) for one of the hwirqs. The
new code is stricter about associations, and actually unwinds the
associations if one of them fails. The old legacy code simply called
all the .map() hooks blindly without any error checking. Can you send
me the kernel log after backing out those changes.

The other possibility is that irqs aren't being reserved correctly.
Seeing the backtrace will tell me which issue it is.

In the mean time I've backed out the top three commits from irqdomain/next.

g.
