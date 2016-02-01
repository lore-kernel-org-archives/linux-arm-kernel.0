From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 07:32:56 +0100
Subject: [PATCH 3/3] clk: Provide OF helper to mark clocks as CRITICAL
In-Reply-To: <56A95811.8010200@arm.com>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
 <56A95811.8010200@arm.com>
Message-ID: <20160201063256.GE32462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Wed, Jan 27, 2016 at 11:51:45PM +0000, Andr? Przywara wrote:
> Hi,
> 
> On 18/01/16 14:28, Lee Jones wrote:
> > This call matches clocks which have been marked as critical in DT
> > and sets the appropriate flag.  These flags can then be used to
> > mark the clock core flags appropriately prior to registration.
> 
> I like the idea of having a generic property very much. Also this solves
> a problem I have in a very elegant way.

Not really. It has a significant set of drawbacks that we already
detailed in the initial thread, which are mostly related to the fact
that the clocks are to be left on is something that totally depends on
the software support in the kernel. Some clocks should be reported as
critical because they are simply missing a driver for it, some should
be because the driver for it as not been compiled, some should because
we don't have the proper clocks drivers yet for one of their
downstream clocks.

Basically, it all boils down to this: some clocks should never ever be
shutdown because <hardware reason>, and I believe it's the case Lee is
in. But most of the current code that would use it might, and might
even need at some point to shut down such a clock.

Mike's solution with the flags + handover was solving all this, I'm
not sure why he's not pushed it forward.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/7cc643aa/attachment.sig>
