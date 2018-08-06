From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 6 Aug 2018 10:44:51 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <20180805213615.GA1862@amd>
 <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
Message-ID: <20180806084451.GB19523@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-08-06 09:04:33, Ramana Radhakrishnan wrote:
> On Sun, Aug 5, 2018 at 10:36 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
> >> > strange problem.
> >> >
> >> > When I use the links browser in graphics mode on the framebuffer, I get
> >> > occasional pixel corruption. Links does memcpy, memset and 4-byte writes
> >> > on the framebuffer - nothing else.
> >> >
> >> > I found out that the pixel corruption is caused by overlapping unaligned
> >> > stp instructions inside memcpy. In order to avoid branching, the arm64
> >> > memcpy implementation may write the same destination twice with different
> >> > alignment. If I put "dmb sy" between the overlapping stp instructions, the
> >> > pixel corruption goes away.
> >> >
> >> > This seems like a hardware bug. Is it a known errata? Do you have any
> >> > workarounds for it?
> >>
> >> Yes fix Links not to use memcpy on the framebuffer.
> >> It is undefined behavior to use device memory with memcpy.
> >
> > No, I don't think so. Why do you think so?
> 
> It is undefined behaviour in the architecture.

Why do you think so? Pointer to documentation would be helpful.

Normal access is used for mmapped areas, and I don't think we want to
 change that.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180806/53c42960/attachment.sig>
