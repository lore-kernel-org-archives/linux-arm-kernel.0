From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 2 Jun 2010 08:19:20 +0200
Subject: Fwd: [RFC, PATCH 1/3] ARM: PL08X: Add PL08x AMBA DMA Controller
	driver.
In-Reply-To: <AANLkTilXKWWvn6HLjfbcC0XFEn-Z7jSf4f6CKHBuW8Qb@mail.gmail.com>
References: <1227275251-12005-1-git-send-email-protected@arm.com>
	<1227275251-12005-2-git-send-email-protected@arm.com>
	<AANLkTilXKWWvn6HLjfbcC0XFEn-Z7jSf4f6CKHBuW8Qb@mail.gmail.com>
Message-ID: <AANLkTimoZRr5P_k4QH75upXAWRwkBKJjAfrStm5Znn5S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops this was onto the old list address, Peter is busy so does anybody
else know about
address boundaries in the RealViews?

Linus Walleij


---------- Forwarded message ----------
From: Linus Walleij <linus.ml.walleij@gmail.com>
Date: 2010/5/30
Subject: Re: [RFC, PATCH 1/3] ARM: PL08X: Add PL08x AMBA DMA Controller driver.
To: Peter Pearse <peter.pearse@arm.com>
Kopia: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>


Hi,

as you know I'm hacking around with this PL08x driver since the Versatile
support is in the way for getting my DMA work merged.

Now this piece I don't quite get:

2008/11/21 Peter Pearse <protected@arm.com>:


> +/*
> + * Return number of bytes to fill to boundary, or len
> + */
> +static int pl08x_pre_boundary(int addr, int len)
> +{
> + ? ? ? int boundary;
> +
> + ? ? ? if (len <= 0)
> + ? ? ? ? ? ? ? printk(KERN_ERR "PL08X::pre_boundary() - zero length\n");
> +
> + ? ? ? boundary = ((addr >> PL08X_BOUNDARY_SHIFT) + 1) << PL08X_BOUNDARY_SHIFT;
> +
> + ? ? ? if (boundary < addr + len)
> + ? ? ? ? ? ? ? return boundary - addr;
> + ? ? ? else
> + ? ? ? ? ? ? ? return len;
> +}

This PL08X_BOUNDARY_SHIFT is defined to
#define PL08X_BOUNDARY_SHIFT ? ? ? ? ? (10) ? ?/* 1KB 0x400 */
#define PL08X_BOUNDARY_SIZE ? ? ? ? ? ?(1 << PL08X_BOUNDARY_SHIFT)

And then later:

> +/*
> + * Note that we assume we never have to change the burst sizes
> + */
> +int fill_LLIS_for_desc(struct pl08x_txd *local_txd, int pl08x_chan_num)
> +{
> (...)
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Make largest possible LLIs until less than one bus width left
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? while (remainder > (mbus->buswidth - 1)) {
> + ? ? ? ? ? ? ? ? ? ? ? int lli_len, target_len;
> + ? ? ? ? ? ? ? ? ? ? ? int tsize;
> + ? ? ? ? ? ? ? ? ? ? ? int odd_bytes;
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* If enough left try to send max possible,
> + ? ? ? ? ? ? ? ? ? ? ? ?* otherwise try to send the remainder
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? target_len = remainder;
> + ? ? ? ? ? ? ? ? ? ? ? if (remainder > max_bytes_per_lli)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? target_len = max_bytes_per_lli;
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* ?Set bus lengths for incrementing busses
> + ? ? ? ? ? ? ? ? ? ? ? ?* ?to number of bytes which fill
> + ? ? ? ? ? ? ? ? ? ? ? ?* ?to next memory boundary
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? if (cctl_parm.bits.si)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? local_txd->srcbus.fill_bytes
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? = pl08x_pre_boundary(local_txd->srcbus.addr
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? , remainder);
> + ? ? ? ? ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? local_txd->srcbus.fill_bytes
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? = max_bytes_per_lli;

Here the transfer lengths for lli:s crawls up tp a boundary.
Now, the DMAC PL08x cannot move past a 0x400 boundary on the RealViews,
so much is clear. But: is this a thing that will affect:

- All RealView / Versatile equipment
- All implementations of PL08x on all silicon
- All ARM architectures and nothing to do with the PL08x at all, rather
?with some AMBA stuff or so?

Yours,
Linus Walleij
