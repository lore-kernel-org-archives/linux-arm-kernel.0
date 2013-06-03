From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Jun 2013 09:44:42 -0600
Subject: [PATCH] spi: sirf: avoid uninitialized-use warning
In-Reply-To: <2423840.pM7qIRtGlE@wuerfel>
References: <2423840.pM7qIRtGlE@wuerfel>
Message-ID: <51ACB9EA.2030807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 07:24 AM, Arnd Bergmann wrote:
> 24778be20 "spi: convert drivers to use bits_per_word_mask"
> removed the "default" statement in the spi_sirfsoc_setup_transfer
> switch, causing a new warning:
> 
> drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_setup_transfer':
> arch/arm/include/asm/io.h:90:2: warning: 'rxfifo_ctrl' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   asm volatile("str %1, %0"
>   ^
> drivers/spi/spi-sirf.c:364:19: note: 'rxfifo_ctrl' was declared here
>   u32 txfifo_ctrl, rxfifo_ctrl;
>                    ^
> 
> The compiler has correctly identified that this case may happen,
> but since we know that things are horribly broken if bits_per_word
> is ever something other than the values we tested, calling BUG()
> is an appropriate action and tells the compiler that execution
> will not continue afterwards.

I guess this is fine, although BUG() seems a little scary, even though
it is a bug.

In some of the other drivers, I converted:

if () {
} else if () {
} else {
    error
}

... to:

if () {
} else {
}

... the equivalent of which would be to just add a "default:" to, say,
the 8-bpw case in the switch. But I guess I don't feel too strongly
either way.
