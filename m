From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 May 2013 11:35:03 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <51A1103F.6000702@schinagl.nl>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
 <51969EA9.1060602@free-electrons.com>
 <5197B82F.8010809@schinagl.nl> <519FE0AE.2010102@schinagl.nl>
 <20130525122208.GD17847@lukather> <51A1103F.6000702@schinagl.nl>
Message-ID: <20130526093503.GH17847@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 09:25:51PM +0200, Oliver Schinagl wrote:
> On 05/25/13 14:22, Maxime Ripard wrote:
> >What about:
> >
> >val = ioread32be(base + (key / 4));
> >val >>= (key % 4) * 8;
> >return val & 0xff;
> >
> >No lookup table, no weird swich statement, and you get the endianness
> >conversion only when you need it.
> Ok I think I like the Endianess, ioread32be does the right thing
> then? I'll read up on that.
> As for key / 4; how will that work without the lut?
> 
> Lets take byte 14 (out of the available 16). Byte 14 (0x0e) is
> located in SID_KEY3, so base + 0x0c. We need to write a whole 32bit
> word to keep with alignment, the registers go wakko if you do
> unaligned reads. So we need to read the entire 32 bits, then find
> our byte.
> 
> key / 4 for 14 yields 0x03. So we have base + 0x03, which is not
> what we want. We want base + 0x0c, which is either ((key >> 2) <<
> 2)) Or, ((key / 4) * 4)) which to me, are both equally confusing.

The statement you make that 3 isn't the index you want depends on your
pointer type so it might be what you want, or might not.

If it's still not what you want, you can always use round_down(key, 4).

> So we either use the look up table, which is a little cleaner and is a
> bit more future proof if either a) there's more 'eeprom like'
> storage which can be combined herein or b) 'a' next version has
> non-continuing regions. Granted neither is something to worry about
> right now.

I don't see how it's cleaner (you have three indirections to get
the value that is actually used) or future proof (you have to extend
this lookup table every time you have a slightly larger size).

So I'm sorry but this lookup table holding only the index times 4 is
a non-sense, could we please stop arguing about this?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
