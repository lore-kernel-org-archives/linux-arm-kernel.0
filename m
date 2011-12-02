From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 00:56:05 +0000
Subject: [PATCH 3/3] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <CAH9JG2WLO-wFT_QEv4qBeCcz-pE2CNoMqV8f8u3BKF8r+GSBvA@mail.gmail.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1322765339-29879-3-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAH9JG2WLO-wFT_QEv4qBeCcz-pE2CNoMqV8f8u3BKF8r+GSBvA@mail.gmail.com>
Message-ID: <20111202005604.GA31948@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 09:35:44AM +0900, Kyungmin Park wrote:

> I'm not sure what's the next step at s3c64xx for generic power domain.
> Related with exysno4 series, it's helpful to read following threads.
> http://68.183.106.108/lists/linux-pm/msg26291.html

> "I don't think we should control/gate the clocks with regarding power
> domain" from Mr. Kim

I tend to agree with him that gating the clocks automatically using
runtime PM would be nice as if nothing else it saves code in drivers.
I'm not sure how easy it's going to be to transition to doing that in
one jump, though - there's a lot of SoCs sharing IP right back to
S3C24xx.

Of course it should be fairly easy for most of the domains on s3c64xx
right now as there's only one actual driver involved in mainline, we
should just be gating almost all of the clocks concerned immediately
after we boot (assuming they aren't gated by default, I'd need to check)
and never touching them again anyway.  It'd only be the framebuffer
clocks that'd need some work and for a first pass we could just mark the
framebuffer domain as always on and get most of the win.  Sometimes lack
of driver support is a good thing :)
