From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Apr 2014 09:40:47 -0400
Subject: [PATCH] ARM: l2c: prima2: only call l2x0_of_init() on matching
 nodes
In-Reply-To: <20140428091532.GG26756@n2100.arm.linux.org.uk>
References: <1398644860-22973-1-git-send-email-mporter@linaro.org>
 <20140428091532.GG26756@n2100.arm.linux.org.uk>
Message-ID: <20140428134047.GA7719@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 10:15:33AM +0100, Russell King wrote:
> On Sun, Apr 27, 2014 at 08:27:40PM -0400, Matt Porter wrote:
> > l2x0_of_init() is executed unconditionally within the sirfsoc_l2x0_init()
> > early initcall. In a multi v7 kernel this causes bcm281xx and bcm21664
> > platform to fail boot since they have their own pre l2x0 init sequence
> > that is required. Fix this by checking that a matching OF ID is present
> > before calling l2x0_of_init().
> > 
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > ---
> > Applies against next-20140424 to fix the issue introduced in
> > 50655e6 ARM: l2c: prima2: remove cache size override
> 
> Err, this only "fixes" it because it effectively disables the L2 cache
> _entirely_ - in the above commit, I kill your private compatible strings.
>
> This doesn't make sense.  If the cache is already enabled, then the L2C
> code won't try to enable it again.

Ok, please suggest an alternative. You merged this commit..it looks like
it had no ack from the platform maintainer..and I don't have hardware.
The commit is wrong, we can't have every platform executing sirfsoc's
l2x0_of_init() call/parameters by having this stuff in an early initcall
like that.

It would be pretty straightforward to add those private compatibles
back so the approach works. If not, we need to move this to
.init_machine where it's guaranteed to only run on sirfsoc.

-Matt
