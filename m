From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Apr 2011 21:50:12 +0100
Subject: [PATCH] ARM: fix badly implementation of wmb
In-Reply-To: <1302884511-14152-1-git-send-email-tom.leiming@gmail.com>
References: <1302884511-14152-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110416205012.GB8955@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2011 at 12:21:51AM +0800, tom.leiming at gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> Commit e7c5650f6067f65f8e961394f376d4862808d0d2
> 
> 	ARM: 5996/1: ARM: Change the mandatory barriers implementation (4/4)
> 
> implements wmb as dsb plus outer_sync, which will make wmb
> much more strict than required. In fact, it is enough for dmb to
> keep the partial order of two stores, so restore wmb as dmb to
> fix possible performance degrade caused by the commit e7c5650f.
> 
> Also the patch defines __iowmb as mb to fix the issue which the
> commit e7c5650f addressed.

So I have another patch which changes rmb() from being a dmb to a dsb.

With these two patches combined, we end up with:

rmb() = dsb()
wmb() = dmb()

which makes rmb() stronger than wmb(), which means there's something
wrong.  rmb() should never be stronger than wmb().
