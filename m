From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Sep 2013 11:51:52 +0100
Subject: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not
 yet ready
In-Reply-To: <20130921104734.GJ12758@n2100.arm.linux.org.uk>
References: <20130921120006.47b00fe7@armhf>
 <20130921104734.GJ12758@n2100.arm.linux.org.uk>
Message-ID: <20130921105151.GK12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 11:47:34AM +0100, Russell King - ARM Linux wrote:
> Another comment.  This is broken - it will never fall through if a
> 'dev' is given, because of_clk_get_by_name() will always return an
> -EPROBE_DEFER error pointer in that case.
> 
> So this approach is unworkable.

And another comment:

This whole approach is broken - while Mark is correct that we should
find a way to return -EPROBE_DEFER if a clock is specified, the solution
here does not allow that - it will return -EPROBE_DEFER whenever the
clock is not found _or_ is not specified.

This has the effect of making the external clock *non*optional for the
kirkwood-i2s driver, which is also completely broken.
