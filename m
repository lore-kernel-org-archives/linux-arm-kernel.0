From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 11:29:17 +0000
Subject: [PATCH v2 0/5] ARM: Manage the pl310 erratas in a dynamic way
In-Reply-To: <20130129101026.GA1063@bnru10>
References: <20130129101026.GA1063@bnru10>
Message-ID: <20130129112917.GF2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 03:40:38PM +0530, srinidhi kasagar wrote:
> - Added l2x0_quirks to manage the errata in cpu_idle path. Tried to address
>   Russell's comment on this, but could not completely. Because, neither I can
>   keep the #ifdef CONFIG_PL310_ERRATA_769419 nor remove it entirely since
>   the platform A suffers from this bug, whereas B do not but shares the same
>   defconfig.

Yes you can and I covered this situation in my email.  In that case,
you _define_ CONFIG_PL310_ERRATA_769419 such that the barrier _always_
gets included both both platforms.

As I already said, there is _no_ point making the barrier conditional;
it's probably more expensive to make it conditional than just to execute
it every time.  But we still might as well optimize it away if we are
running _only_ on platforms which _do_ _not_ have that errata.
