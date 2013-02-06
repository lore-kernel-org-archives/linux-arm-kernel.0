From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Feb 2013 22:51:50 +0000
Subject: [PATCH] arm: Preserve TPIDRURW on context switch
In-Reply-To: <5112DC7E.4020108@dawncrow.de>
References: <5112DC7E.4020108@dawncrow.de>
Message-ID: <20130206225150.GL17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 11:43:10PM +0100, Andr? Hentschel wrote:
> There are more and more applications coming to WinRT, Wine could support them,
> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
> This register must be preserved per thread instead of being cleared.

I'd prefer this was done a little more sensitively to those CPUs where
loads/stores are expensive, namely:

> +
> +	@ preserve TPIDRURW register state
> +	get_tls2	r3, r4, r5
> +	str	r3, [r1, #TI_TP2_VALUE]
> +	ldr	r3, [r2, #TI_TP2_VALUE]
> +	set_tls2	r3, r4, r5

those two loads/stores get omitted from the thread switching if the CPU
doesn't support it.  Do you think that's something you could do?
