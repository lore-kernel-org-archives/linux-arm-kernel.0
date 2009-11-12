From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 12 Nov 2009 18:44:40 +0000
Subject: ARM: big performance waste in memcpy_{from,to}io
References: <200911121749.49676.h.feurstein@gmail.com>
Message-ID: <ol1us6-035.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hubert Feurstein <h.feurstein@gmail.com> wrote:
> 
> I'm working with an Contec Micro9 board (ep93xx-based with two Spansion-NOR-
> Flash chips in parallel => 32bit memory-buswidth) and was wondering why the
> read-performance of the flash (through /dev/mtd*) is so quite poor. So I 
> connected a logic analyser to the data- and address-bus and recognized that 
> the accesses to the same flash-word-address happens four times. This means 
> that the flash is read byte-by-byte, which is IMO a big waste of performance 
> since it would be possible to read the full word (four bytes) at once. So I 
> digged around in the mtd-driver and found the function "memcpy_fromio" which 
> is called to read the flash data. I was really surprised when looked to the 
> implementation, which is:
> 
> [snipped]
> 
> Are there any drawbacks when using the good-and-fast "memcpy" ? On my Micro9-
> board everything is running fine so far.
> 

>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.17.1258053123.2170.linux-arm-kernel@lists.infradead.org>

NOR's too) do *not* support 32bit wide read's.  For example, if I 
remember correctly, the NAND driver for orion will let you read 32bits 
but write only 8bits at a time.  Other platforms are only 8bit wide in 
both direction.  I guess the 'slow' memcpy version is used as 
*everything* supports 8bit reads....I *guess* :)

For the NAND world, we have plat_nand and you can populate 
(read|write)_buf with your optimised version; of course you are using 
NOR so I have no idea if you have to treat that differently....

Cheers

-- 
Alexander Clouter
.sigmonster says: Make sure your code does nothing gracefully.
