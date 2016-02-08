From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2016 17:00:29 +0000
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <20160208163935.GN10826@n2100.arm.linux.org.uk>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000351.GX10826@n2100.arm.linux.org.uk>
 <CAKv+Gu_kYWczCazqgRC3y-n7s3WRTDhJXLO1RM1FE-6h1BhSUw@mail.gmail.com>
 <20160203091331.GB10826@n2100.arm.linux.org.uk>
 <CAKv+Gu8jbfs6HuzoFTQV2z-0LLiEZ9p0ZHO6eF3itE8p1LMwBA@mail.gmail.com>
 <20160208163935.GN10826@n2100.arm.linux.org.uk>
Message-ID: <20160208170029.GO10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 04:39:35PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 03, 2016 at 10:16:46AM +0100, Ard Biesheuvel wrote:
> > There are 34 section headers, starting at offset 0x10a6e60:
> > 
> > Section Headers:
> >   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
> >   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
> >   [16] .vectors          PROGBITS        00000000 a40000 000020 00  AX  0   0  2
> >   [17] .stubs            PROGBITS        00001000 a41000 0002c0 00  AX  0   0 32
> >   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
> ...
> > Section Headers:
> >   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
> >   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
> >   [16] .stubs            PROGBITS        c0c35000 a35000 0002c0 00  AX  0   0 32
> >   [17] .vectors          PROGBITS        c0c34000 a44000 000020 00  AX  0   0  2
> >   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
> 
> Sorry, but I'm going to re-iterate my objection, and I believe that
> because you're looking at readelf's output, you're making assumptions
> when interpreting its output.
> 
> These figures do not truely describe how the file is laid out.  The
> tool to use for this is objdump -h.  Let's compare:
> 
> $ readelf -S vmlinux
> Section Headers:
>   [Nr] Name        Type         Addr     Off    Size   ES Flg Lk Inf Al
>   [13] .notes      NOTE         c093afd0 93afd0 000024 00  AX  0   0  4
>   [14] .vectors    PROGBITS     00000000 940000 000020 00  AX  0   0  4
>   [15] .stubs      PROGBITS     00001000 941000 0002c0 00  AX  0   0 32
>   [16] .init.text  PROGBITS     c093b2e0 94b2e0 04862c 00  AX  0   0 32
> 
> $ objdump -h vmlinux
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>  12 .notes        00000024  c093afd0  c093afd0  0093afd0  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>  13 .vectors      00000020  00000000  c093b000  00940000  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>  14 .stubs        000002c0  00001000  c093b020  00941000  2**5
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>  15 .init.text    0004862c  c093b2e0  c093b2e0  0094b2e0  2**5
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> 
> Note that objdump -h has one additional piece of information here: the
> LMA - load memory address.  This tells us where the file contents
> (offset into the ELF file at "File off") are to be loaded into memory,
> as opposed to the VMA which describes where (at run time) the object is
> to be found.
> 
> With this new information, we can see that .vectors is loaded to
> 0xc093b000, and occupies only 32 bytes in the binary memory image, even
> though it occupies 4k in the ELF file.)  .stubs is loaded at 0xc093b020,
> and occupies 0x2c0 bytes.  Furthermore, we can see .init.text is located
> at 0xc093b2e0.
> 
> So, there is no memory wastage here - .vectors, .stubs and the init text
> are all packed tightly together.  That's something which the readelf -S
> output doesn't show us.
> 
> Please, replace the readelf -S output with objdump -h output so that we
> can see what's /really/ going on here.
> 
> In any case, I still don't like your patch.  At least having these at 0
> and 0x1000 means that (for some CPUs) they are located at the real VMA
> address that they may appear at, though for modern CPUs, locating them
> at 0xffff0000 and 0xffff1000 VMA would be more reasonable.  This has the
> advantage that (jtag) debuggers are able to correctly parse the vmlinux
> file and insert breakpoints into the vectors.

Another down-side to your patch is that you're placing the VMA of
.vectors 4096 bytes below .stubs - but we can have other symbols in
that VMA space.  That means you're creating the very real possibility
of confusing output we have real data at the location where you're
placing .vectors.

So no, I _really_ don't like this.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
