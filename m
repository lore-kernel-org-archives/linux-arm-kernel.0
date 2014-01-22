From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 22:40:39 +0000
Subject: [PATCH v3 16/24] drm/i2c: tda998x: add DT documentation
In-Reply-To: <CAOesGMhngiw+f8bkfB9C4COTPksXg_ZsYA-p1r5WJ6FZuBE3KQ@mail.gmail.com>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195844.0c975b90@armhf>
 <CAOesGMi96wkHM8jfHNVnM7RJyW2vVoP6FT4YyYzKp-kfc0jTuQ@mail.gmail.com>
 <20140120105410.15705f32@armhf>
 <CAOesGMhngiw+f8bkfB9C4COTPksXg_ZsYA-p1r5WJ6FZuBE3KQ@mail.gmail.com>
Message-ID: <20140122224039.GM15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 10:17:56AM -0800, Olof Johansson wrote:
> Ok, this is a classic case where the binding should describe how
> things are configured/wired up instead of hardcoding a register value
> like this. From the data sheet there seems to be a _lot_ of settings,
> so selecting the needed subset for now might be acceptable (and go
> with defaults on the rest).

The issue is not that simple, because the register is kind of backwards.

Rather than describing what is on each nibble of the input bus, you
specify how each nibble of the internal bus maps to the external world.
The internal bus is mostly fixed as to which nibbles are red, green and
blue (there is internal support for swapping red/blue on the internal
bus, but we don't use that - it just adds extra unnecessary headaches
to the mapping.)

The way I ended up describing it in platform data was via the individual
nibble settings for the register:

        .swap_a = 2,
        .swap_b = 3,
        .swap_c = 4,
        .swap_d = 5,
        .swap_e = 0,
        .swap_f = 1,

which gives you a way to refer back to the data sheet.  There's also the
control whether the nibble is bit-big-endian or bit-little-endian.

So basically, swap_a controls which nibble of the input bus is mapped to
the internal bus bits 23:20, and mirror_a whether it's bit 0123 -> 0123
or 0123 -> 3210.

This means it's possible to tell the chip that each nibble of the interal
bus comes from the same four pins!

If we want to describe what each nibble set on the input pins does, it's
going to make for some complex code to convert that from "forward" notation
(which we'll have to invent) to the "reverse" notation that the chip needs.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
