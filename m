From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2016 09:13:31 +0000
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <CAKv+Gu_kYWczCazqgRC3y-n7s3WRTDhJXLO1RM1FE-6h1BhSUw@mail.gmail.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000351.GX10826@n2100.arm.linux.org.uk>
 <CAKv+Gu_kYWczCazqgRC3y-n7s3WRTDhJXLO1RM1FE-6h1BhSUw@mail.gmail.com>
Message-ID: <20160203091331.GB10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 08:56:35AM +0100, Ard Biesheuvel wrote:
> On 3 February 2016 at 01:03, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 02, 2016 at 02:19:32PM +0100, Ard Biesheuvel wrote:
> >> The sections themselves are emitted 4 KB apart, as required:
> >>   ...
> >>   [16] .stubs       PROGBITS   c0c35000 a35000 0002c0 00  AX  0   0 32
> >>   [17] .vectors     PROGBITS   c0c34000 a44000 000020 00  AX  0   0  2
> >>   ...
> >
> > ... which means we end up wasting most of a page for absolutely no
> > purpose what so ever.  Sorry, I'm really not happy about this
> > gratuitous wastage.
> >
> 
> No, we don't. Here's some more context:
> 
> Before:
>   [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
>   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
>   [16] .vectors          PROGBITS        00000000 a40000 000020 00  AX  0   0  2
>   [17] .stubs            PROGBITS        00001000 a41000 0002c0 00  AX  0   0 32
>   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
> 
> After
>   [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
>   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
>   [16] .stubs            PROGBITS        c0c35000 a35000 0002c0 00  AX  0   0 32
>   [17] .vectors          PROGBITS        c0c34000 a44000 000020 00  AX  0   0  2
>   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32

Meaningless numbers... Do you think you can quote with the header
please?  I don't tend to carry around the objdump headers in my head.
Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
