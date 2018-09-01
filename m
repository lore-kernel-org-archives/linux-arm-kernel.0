From: ebiggers@kernel.org (Eric Biggers)
Date: Fri, 31 Aug 2018 23:42:17 -0700
Subject: [PATCH] crypto: arm/chacha20 - faster 8-bit rotations and other
 optimizations
In-Reply-To: <CAKv+Gu-KAbGo3MKNkz26o5qG13283AY6vNrrCLwyi8KQR0Vc0w@mail.gmail.com>
References: <20180831080140.20553-1-ebiggers@kernel.org>
 <CAKv+Gu_zbuo0ApR2fPC=-w1QNXnSDu6omgALqKm7k6g_y5B51g@mail.gmail.com>
 <CAKv+Gu-KAbGo3MKNkz26o5qG13283AY6vNrrCLwyi8KQR0Vc0w@mail.gmail.com>
Message-ID: <20180901064216.GB6466@sol.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 06:51:34PM +0200, Ard Biesheuvel wrote:
> >>
> >> +       adr             ip, .Lrol8_table
> >>         mov             r3, #10
> >>
> >>  .Ldoubleround4:
> >> @@ -238,24 +268,25 @@ ENTRY(chacha20_4block_xor_neon)
> >>         // x1 += x5, x13 = rotl32(x13 ^ x1, 8)
> >>         // x2 += x6, x14 = rotl32(x14 ^ x2, 8)
> >>         // x3 += x7, x15 = rotl32(x15 ^ x3, 8)
> >> +       vld1.8          {d16}, [ip, :64]
> 
> Also, would it perhaps be more efficient to keep the rotation vector
> in a pair of GPRs, and use something like
> 
> vmov d16, r4, r5
> 
> here?
> 

I tried that, but it doesn't help on either Cortex-A7 or Cortex-A53.
In fact it's very slightly worse.

- Eric
