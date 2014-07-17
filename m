From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jul 2014 19:12:45 +0200
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <CAJe_ZhdM88x883DqxerW-JWpVeiFR9yA7s_=gpPZ7w1qPDJR=A@mail.gmail.com>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
 <13950816.fBdtyDiPqD@wuerfel>
 <CAJe_ZhdM88x883DqxerW-JWpVeiFR9yA7s_=gpPZ7w1qPDJR=A@mail.gmail.com>
Message-ID: <13232839.EhWsHsNIV6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 22:24:43 Jassi Brar wrote:
> On 17 July 2014 19:18, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 17 July 2014 19:02:53 Jassi Brar wrote:

> >> From a few hundred micro-sec for CPU reset, to potentially tens of
> >> milli-sec for some I2C transaction ... yes we do have for I2C over
> >> mailbox! ;)
> >>
> >> Probably bailing out of the loop and returning -ETIMEOUT to the
> >> caller, before a WARN(), is the simplest way to die.
> >
> > If you can have multiple miliseconds here, I think the code should
> > be changed to run in non-atomic context and use msleep(1) or
> > usleep_range() as a back-off. Is that possible?
> >
> I don't think we could sleep there but that should be ok because the
> code is used only when we don't have mailbox framework ready i.e, in
> very early boot before timers are ready and also as late as during
> reboot/poweroff. Also I realize long delays like those for I2C would
> never use this code - they would always have mailbox usable during
> their lifetime.

Ok, just add a comment then, and a warning if things take too long.

> >> >> >> +struct mb86s7x_peri_clk {
> >> >> >> +     u32 payload_size;
> >> >> >> +     u32 cntrlr;
> >> >> >> +     u32 domain;
> >> >> >> +     u32 port;
> >> >> >> +     u32 en;
> >> >> >> +     u64 freqency;
> >> >> >> +} __packed;
> >> >> >
> >> >> > Just mark the last member by itself __packed. I assume you didn't
> >> >> > actually mean to change the alignment of the data structure to one
> >> >> > byte, but just want to say that the last one is misaligned.
> >> >> >
> >> >> This and others, are data packets that are passed between local and
> >> >> remote via SharedMemory. __packed is only meant to specify that these
> >> >> data structures have no holes in them.
> >> >
> >> > That would be '__packed __attribute__((aligned(4)))'. A struct of 'u32'
> >> > already has no padding on any architecture that is supported by Linux.
> >> > The only reason you need the packing here is because the u64 member is
> >> > unaligned. Note that marking the entire structure as packed means that
> >> > accesses are no longer atomic because the compiler may prefer to do them
> >> > one byte at a time, which can break the protocol on the shared memory
> >> > area.
> >> >
> >> We are not worried about the atomic access because the side sending
> >> the data doesn't touch it until the other side indicates it has
> >> consumed it.
> >
> > It's still wrong though ;-)
> >
> The remote f/w expects data to be contiguous and we can't assume how
> it reads the packet. So our firstmost priority is to have no holes in
> the region... like, say, USB descriptors.

The structures being contiguous is guaranteed by the ELF ABI, unless
you have unaligned members.

You can be explicit about it, but then you should also provide a
new minimum alignment (e.g. 4 bytes) for the structure to avoid
having the compiler turn everything into bytewise accesses.

	Arnd
