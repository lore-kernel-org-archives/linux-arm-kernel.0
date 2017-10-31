From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 31 Oct 2017 10:58:19 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
Message-ID: <CA+55aFyRE0Sm3NFtY7cz8p=ZFK5WQDo-oNUHGW99+EQGr_rigA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'm very much open to udelay improvements, and if somebody sends
> patches for particular platforms to do particularly well on that
> platform, I think we should merge them. But ...

Side note: this is obviously a negative feedback circle, where because
we know we can't do all that great in general, few platforms really
bother to do as well as they perhaps could, since nobody should
generally care that deeply due to the generic problem..

Again, if a driver that has tight timing requirements can just
generate the timings from its own hardware, that tends to
JustWorks(tm).

It was what people used to do traditionally at least on the PC/AT
platform. None of this "udelay()" crud, you knew that doing a single
PIO read took one usec, so you'd just delay that way. Then the
hardware moved from ISA to EISA, and everything sped up, but that was
ok, because now it needed a shorter delay anyway...

Doing things like a status register read is often a good way
(sometimes the _only_ way) to make sure preceding writes have been
flushed all the way to the device anyway, so it can have those kinds
of incidental advantages.

Of course, all of this is relevant only for delays on the scale of
individual device accesses. But that's also when udelay/ndelay() tends
to have the most problems.

               Linus
