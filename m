From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 11:44:04 +0000
Subject: [RFC 1/1] ARM: imx6q: move clock register map to
 machine_desc.map_io
In-Reply-To: <CAMPhdO9bzAO5DgLCHD7EsM5mjoE-+4d9QvcgiUqKvDFFD4AnrA@mail.gmail.com>
References: <1321494612-24795-1-git-send-email-richard.zhao@linaro.org>
 <CAMPhdO8vE4cer-EQZ53VDQrZpQ1JVvus2=RpDCfdJRa7gwLUqg@mail.gmail.com>
 <20111117032012.GF14656@S2100-06.ap.freescale.net>
 <20111117084453.GK9581@n2100.arm.linux.org.uk>
 <20111117090731.GG14656@S2100-06.ap.freescale.net>
 <CAMPhdO8u0jjR0po_rrd6w-pimX7ypvXdri933mANTQ3APt=3zg@mail.gmail.com>
 <20111117092815.GH14656@S2100-06.ap.freescale.net>
 <CAMPhdO9bzAO5DgLCHD7EsM5mjoE-+4d9QvcgiUqKvDFFD4AnrA@mail.gmail.com>
Message-ID: <20111117114404.GP9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 07:22:51PM +0800, Eric Miao wrote:
> On Thu, Nov 17, 2011 at 5:28 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > I do not see any more possible static IO mapping in the future. On the
> > contrary, the static mapping for clocks could possibly be removed when
> > we migrate to common clock framework and create clocks dynamically from
> > device tree.
> 
> Fair enough and it would be ideal if static IO mapping is not necessary.
> 
> And I don't have a strong preference of having a single array for all these
> mappings or having separate function for each of them. It just looks a bit
> redundant to have a one-line function here.

You have to do static IO mapping if you need the mapping before the
memory allocators are up and running - because until that's the case,
ioremap won't work.

Your choices for setting up device mappings are:

1. iotable_init() or create_mapping() in the map_io callback (and no
   other callback.)

2. ioremap() after the memory allocators are up and running, which (in
   the sequence of functions in the machine description - they've always
   been ordered according to their called sequence) is at the point where
   init_irq is called.

.init_early can then access anything which the static mappings have
setup, but it can't in any way setup any further mappings.  If you're
registering your clocks at init_early() time, and you need to access
the devices, then you must have created those mappings at map_io time.

.init_irq, the timer init, and .init_machine can all use ioremap() to
setup further mappings but must not use iotable_init() nor create_mapping()
to do so.
