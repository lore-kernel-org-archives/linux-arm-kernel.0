From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Oct 2017 17:05:10 +0100
Subject: HAVE_EFFICIENT_UNALIGNED_ACCESS on ARM32 (was: Alignment issues
 in zImage with Linux 4.12, LZ4 and GCC5.3)
In-Reply-To: <CAK8P3a2XjZ6ZfHVu8gbAQ2ncj+GTR30Zj6oKUG8CTH4iswOnTw@mail.gmail.com>
References: <CAGkQfmOKqFWisiRjkCHBHDwgY5A0HA_+hcLYSeDYaoGQ6CVu6Q@mail.gmail.com>
 <CAK8P3a3AQ43t2q1MVN9PoqQXZiuXQo1uDcGnRAPCiT66_oDyLg@mail.gmail.com>
 <CAKv+Gu_6kxidH-4YwuCorJx25WSZDsOdtbZ6MZCv+R4ufzUjrw@mail.gmail.com>
 <CAK8P3a1xX5RfM1kao7WZBmS=0J=MgNZTH2_c-nSOY+GNmjNsUA@mail.gmail.com>
 <CAKv+Gu_UO_Td2kkN-2k1LzTWJGXO8vZaZdQkN-xnqsK=K5T20g@mail.gmail.com>
 <CAK8P3a0ECzB5ahbdmgM7=1NGkOaEc+wzr_EHbuQJij0+nygbLQ@mail.gmail.com>
 <CAKv+Gu8by5B52L=xD5to2dP1hzVkc9e5p+SwWU5mumdf3VkZnQ@mail.gmail.com>
 <CAK8P3a2XjZ6ZfHVu8gbAQ2ncj+GTR30Zj6oKUG8CTH4iswOnTw@mail.gmail.com>
Message-ID: <20171020160509.GF20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 10:06:28PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 7, 2017 at 1:31 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On 7 September 2017 at 00:18, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Thu, Sep 7, 2017 at 12:48 AM, Ard Biesheuvel
> 
> >> I see lots of unaligned helpers in the lz4 code, is this not what
> >> we hit?
> >>
> >> $ git grep unaligned lib/
> >> lib/lz4/lz4_compress.c:#include <asm/unaligned.h>
> >> lib/lz4/lz4_decompress.c:#include <asm/unaligned.h>
> >> lib/lz4/lz4defs.h:#include <asm/unaligned.h>
> >> lib/lz4/lz4defs.h:      return get_unaligned((const U16 *)ptr);
> >> lib/lz4/lz4defs.h:      return get_unaligned((const U32 *)ptr);
> >> lib/lz4/lz4defs.h:      return get_unaligned((const size_t *)ptr);
> >> lib/lz4/lz4defs.h:      put_unaligned(value, (U16 *)memPtr);
> >>
> >
> > Yes, you are right. The code I looked at before does cast a char* to a
> > U32*, but it is in the compression path, so it has nothing to do with
> > this issue.
> >
> > So I agree that access_ok.h is unsuitable for any 32-bit ARM core, and
> > we should be using the struct version instead. My only remaining
> > question is why we need access_ok.h in the first place: it is worth a
> > try to check whether both produce the same code on AArch64.
> 
> It's been a while since I looked into this problem, but from my memory,
> it turned out rather hard to analyze single files after the change, as
> gcc inlining decisions and register allocation tend to be non-deterministic.
> However, my conclusion then was that those changes are rather random,
> usually no effect, sometimes better and sometimes worse by chance,
> with the only real differences being the few cases we avoid the ldrd/ldm/...
> instructions.
> 
> I have no idea which compiler version I tried back then, so it's very
> possible that some older compilers actually do produce slightly worse
> code with the struct version, the question is what the oldest compiler
> is that we care about enough to investigate. Maybe gcc-4.8?

Arnd,

Gregory Clement has been trying to get traction on an issue over the
last few weeks, and we've been hoping that you'd respond.  It's related
to this one, and it results in some platforms being unbootable.  I think
from what I remember of the discussion, switching to le_struct.h fixes
the issue there as well.

>From what's been said in this thread, it seems like switching to
le_struct.h is the right solution for ARM irrespective of that anyway.

PXA is also having problems with double-word instructions in the
decompressor as well, and this might solve it (so adding everyone from
that thread to the CC list).

So, we have potentially three groups of people that the alignment stuff
is currently biting.  Do we have a way forward on this subject from you?

Do we need the changes in https://pastebin.com/apPTPXys mentioned
previously in this thread?

What's the status?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
