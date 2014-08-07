From: geoff@infradead.org (Geoff Levand)
Date: Wed, 06 Aug 2014 17:40:03 -0700
Subject: Kexec on arm64
In-Reply-To: <20140804113528.GC3197@leverpostej>
References: <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej> <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej> <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <20140804113528.GC3197@leverpostej>
Message-ID: <1407372003.8971.85.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2014-08-04 at 12:35 +0100, Mark Rutland wrote:
> > +       /*
> > +        * arm64 kernel uses area above kernel image to build
> > +        * initial page tables. Max required size for this area is 384K. It
> > +        * happens when CONFIG_ARM64_PGTABLE_LEVELS is set.
> > +        * So place dtb 512k above kernel image area.
> > +        */
> 
> The area above the kernel Image holds the BSS too, and from some
> experiments I did a while back with an allyesconfig, it was possible to
> have many megabytes of BSS.
> 
> While 512k might be adequate for a defconfig today, it will become less
> so as time goes on.
> 
> For kernel Images post v3.17 you can and should read the Image header's
> image_size field to figure out how much memory is needed from _text to
> _end (i.e. all the memory the kernel will assume is available statically
> and will happily clobber). For kernel Images prior to v3.17 the best
> thing we can do is guess as you've done here, or place the DTB below the
> kernel and page tables in the TEXT_OFFSET area; neither option is
> particularly brilliant.

I haven't looked into it yet, but booting.txt says that the dtb must be
'within the first 512 megabytes from the start of the kernel image'.  If
this restriction still holds we can't just put the dtb at
text_offset + image_size.

-Geoff
