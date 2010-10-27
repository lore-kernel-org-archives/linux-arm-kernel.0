From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Oct 2010 23:14:28 +0100
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
References: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20101027221428.GB28391@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 02:58:08PM -0700, Daniel Walker wrote:
> Originally there was an ifdef case to handle when no debug uart
> was selected. In commit 0ea1293009826da45e1019f45dfde1e557bb30df
> that case was removed which causes the following build failure,
> 
> linux-2.6/arch/arm/kernel/debug.S: Assembler messages:
> linux-2.6/arch/arm/kernel/debug.S:174: Error: bad instruction `addruart r1,r2'
> linux-2.6/arch/arm/kernel/debug.S:176: Error: bad instruction `waituart r2,r3'
> linux-2.6/arch/arm/kernel/debug.S:177: Error: bad instruction `senduart r1,r3'
> linux-2.6/arch/arm/kernel/debug.S:178: Error: bad instruction `busyuart r2,r3'
> linux-2.6/arch/arm/kernel/debug.S:190: Error: bad instruction `addruart r1,r2'
> 
> This is a partial revert to add back the case which was removed.

It wants fixing properly, not just reverting.  Even though it's only
a minor difference, it's important to reflect the API in assembly
macros, especially when it has changed.

> +#else
> +	.macro	addruart, rx, tmp

addruart is now expected to return two values, and 'tmp' ends up being
misleading.  This is a recipe for mistakes unless this is corrected.
It should be 'rp, rv' instead of 'rx, tmp'.
