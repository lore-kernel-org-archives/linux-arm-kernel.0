From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Aug 2016 19:17:39 +0100
Subject: [PATCH 0/8] ARM: clean up PC-relative arithmetic
In-Reply-To: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160803181739.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 05:38:42PM +0200, Ard Biesheuvel wrote:
> There are various places in the ARM kernel where the following pattern
> is used to create a PC-relative reference that is valid even before the
> MMU is on:
> 
>      adr    rX, 1f
>      ldr    rY, [rX]
>      add    rX, rX, rY
>      ...
>   1: .long  <symbol> - .   
> 
> or
>      adr    rX, 1f
>      ldmia  rX, {rY .. rY+n}
>      sub    rX, rX, rY
>      add    rY+1, rY+1, rX
>      add    rY+2, rY+2, rX
>      ...
>   1: .long  .
>      .long  <symbolY>
>      .long  <symbolY+1>
>      ...
> 
> Both cases can be greatly simplified by letting the linker do the
> calculations for us. This series implements adr_l, ldr_l and str_l
> macros, and uses them to simplify a couple of instances of the above
> patterns.

I don't buy that argument, sorry, and the argument is actually wrong.
No, we're _not_ letting the linker do the calculations for us, we're
letting the linker do _some_ of the calculation, but not all.

What you're replacing the above with is stuff like (I guess, because
I've no idea what this :pc_g0: notation is):

	add	rX, pc, #(sym - . - 8) & 0xff
	add	rX, rX, #(sym - . - 4) & 0xff00
	add	rX, rX, #(sym - .) & 0xff0000

which I think is a more complex (and less obvious) way to calculate it.
It's also buggy when we end up with a relative offset greater than 16MB,
which we have in multi-zImage kernels.

So no, I don't like this at all.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
