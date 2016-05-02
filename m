From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 May 2016 11:40:49 +0100
Subject: [PATCH V17 2/3] dmaengine: qcom_hidma: add debugfs hooks
In-Reply-To: <20160502092552.GC2274@localhost>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
 <20160426033029.GB2274@localhost>
 <b068ead6474f2ffee5acef9ea799aba3@codeaurora.org>
 <20160426162529.GK2274@localhost> <571F9D76.2060809@codeaurora.org>
 <20160427081501.GV2274@localhost>
 <2c7ac0732fb16f952db24b7c70065318@codeaurora.org>
 <57258799.70803@codeaurora.org> <20160502092552.GC2274@localhost>
Message-ID: <20160502104049.GB6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 02:55:52PM +0530, Vinod Koul wrote:
> On Sun, May 01, 2016 at 12:35:37AM -0400, Sinan Kaya wrote:

> > My evaluation turned out negative. The regmap code is nice for bus like peripherals
> > like I2C and SPI where everything is bitwise accessed. This is not the case
> > in this code. 

> I do not entirely agree with the statements here, it does give big benefit
> on our systems with MMIO. I am going to ask Mark to comment on this, he
> know better and understands ARM.

> I am probably going to be okay with this not using regmap and it is debug
> but you should give that a try in future for better performance and ofcourse
> you can add to regmap to get a better model for your device

I've no idea what "this" is, sorry.  All I've got here is an enormous
backtrace with a bunch of the messages not even word wrapped.

Please be aware that I get CCed on so much irrelevant crap that copying
me into the middle of a thread about some other subsystem is likely to
get missed - almost always it's review of some patch I've got no
interest in.

> > Barriers are really expensive on ARM. I paid very special attention in the 
> > code to decide when to use relaxed version vs. the readl version. I lose 
> > all of this optimization. 

Drivers should not be using the relaxed accessors, they are there for
the generic code to build on not for drivers and they really need the
cache flush operations.  Getting the cache flush operations right,
especially on ARM, isn't easy and needs detailed review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/15836f4d/attachment.sig>
