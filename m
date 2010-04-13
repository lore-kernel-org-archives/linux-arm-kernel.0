From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 13 Apr 2010 10:14:53 +0200
Subject: [PATCH 2/2] AT91 slow-clock resume: don't restore the PLL
	settings when the PLL was off
In-Reply-To: <1270724213l.12911l.1l@i-dmzi_al.realan.de>
References: <x2qcd73a99e1004061445j8698c478z9f021d5f3dd8f81b@mail.gmail.com>
	<1270724213l.12911l.1l@i-dmzi_al.realan.de>
Message-ID: <w2ocd73a99e1004130114g1e46ed2blbcfeef1c9cec0001@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Anders,

> at91: slow-clock resume: Don't wait for a disabled PLL to lock.
>
> We run into this problem with the PLLB on the at91: ohci-at91 disables the PLLB
> when going to suspend. The slowclock code however tries to do the same: It
> saves the PLLB register value and when restoring the value during resume, it
> waits for the PLLB to lock again. However the PLL will never lock and the loop
> would run into its timeout because the slowclock code just stored and restored
> an empty register.
> This fixes the problem by only restoring PLLA/PLLB when they were enabled
> at suspend time.
>
> Signed-off-by: Anders Larsen <al@alarsen.net>
> Cc: Andrew Victor <avictor.za@gmail.com>
> Cc: Julien Langer <julien.langer@gmail.com>

> + ? ? ? tst ? ? r3, #(AT91_PMC_MUL & ?0xff0000)
> + ? ? ? bne ? ? 1f
> + ? ? ? tst ? ? r3, #(AT91_PMC_MUL & ~0xff0000)
> + ? ? ? beq ? ? 2f
> +1:
> ? ? ? ?wait_pllblock
> +2:

AT91_PMC_MUL is 11 bits (so 0x7ff0000)

Is the mask (0xff0000) correct in the above code?
It looks like wait_pllblock will be skipped if the MUL field is set to
0x100, 0x200, 0x300, etc.


Regards,
  Andrew Victor
