From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 28 Sep 2009 15:07:00 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B63@dlee02.ent.ti.com>
References: <20090928092919.GA30271@localhost>
	<20090928124922.GA19778@shareable.org>
	<20090928131624.GK30271@localhost>
	<20090928131926.GB19778@shareable.org>
	<A24693684029E5489D1D202277BE89444B781B63@dlee02.ent.ti.com>
Message-ID: <20090928140700.GE19778@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aguirre Rodriguez, Sergio Alberto wrote:
> In OMAP3 specifically, we were looking for this to happen, since we have
> big buffers that we need to share with other subsystems.
> 
> For example, when we take a 8 megapixel RAW 10-bit image (16MB) and
> we want to send it to the DSP bridge driver, doing a memcpy to another kernel
> allocated and mmaped buffer is a very suboptimal idea.
> (which is our only option as per your statement)

I used to think that about moving compressed video data around.  I
wanted my video decoding application to avoid copying compressed data
(which is about 20Mbit/s).  But then I did some back-of-the-envelope
calculations and decided it was so much easier to copy:

You're copying 16MB.  Let me guess - 32 bit data bus?  According to
Wikipedia, OMAP3 CPU is 600 to 1000MHz.  I've no idea what you're RAM
bus speed is, but is it somewhere around 200MHz?

Just guesstimating here: 16MB on 32-bit bus at 200MHz, copying to RAM
and back again = 200/8 = 0.04 seconds.

Is 0.04 seconds copying time worth devising zero-copy schemes for?  If
that's every frame of a video I'd say yes (but you'd have other
problems first); if it's non-video camera processing then I'd say no.
It's _nice_ to shave off 0.04 seconds, but weight it up against the
difficulties (and overheads) of making reliable DMA in this case.

-- Jamie
