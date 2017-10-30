From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Oct 2017 16:38:17 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <8737601u4d.fsf@free-electrons.com>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
 <20171030154855.GO20805@n2100.armlinux.org.uk>
 <87bmko1v6f.fsf@free-electrons.com>
 <20171030161207.GS20805@n2100.armlinux.org.uk>
 <8737601u4d.fsf@free-electrons.com>
Message-ID: <20171030163816.GA27404@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 05:24:34PM +0100, Gregory CLEMENT wrote:
> Hi Russell King,
>  
> Here you will find all the objects included the vmlinux:
> 
> http://free-electrons.com/~gregory/pub/compressed.tgz

Thanks.  Unfortunately, nothing stands out, but I do see a difference
between the output of your linker from mine.

Yours:

Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00005ef8  00000000  00000000  00010000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

Mine:

Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00005f00  00000000  00000000  00010000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

That has the effect of moving the addresses of the following
sections in your vmlinux down by 8 bytes.  However, I don't think
that's the cause of this - but it does hint at something being
different in binutils in the way sections are processed in the
linker.

Please add to your linker script after the assignment of _edata:

  .image_end (NOLOAD) : {
    _edata_foo = .;
  }

relink the decompressor, and see what value _edata_foo ends up with
compared to _edata?  They should be the same, but I suspect using
your linker, they will be different.

Also try adding
    BYTE(0);

after the _edata_foo assignment as a separate test, and see whether
that makes any difference - with that you should end up with the
.image_end section in the output image.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
