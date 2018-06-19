From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Jun 2018 13:45:31 -0700
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
In-Reply-To: <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net>
 <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
Message-ID: <20180619204531.GB28370@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:34:38PM +0200, Ard Biesheuvel wrote:
> On 19 June 2018 at 22:32, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
> >> Work around the mindless and backward incompatible change in GAS that
> >> prevents us from using a simple addition to set the Thumb bit in local
> >> symbol references taken using 'adr' instructions (#2)
> >>
> >> As a preparatory step, remove badr occurrences in ARM code sequences
> >> contained in Thumb2 kernels.
> >>
> >> Ard Biesheuvel (2):
> >>   ARM: avoid badr macro for switching to Thumb-2 mode
> >>   ARM: assembler: prevent ADR from setting the Thumb bit twice
> >>
> >
> > This doesn't work for images built with a toolchain based on gcc 7.3.0
> > and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
> > binutils 2.30.
> >
> 
> Sigh.
> 
> So does it fail? Or is the resulting binary broken?

Hard to say. It crashes early in boot, even before earlycon can say
anything.

Qemu exec trace, broken:

race 0: 0x7fffcf92c0c0 [00000000/00000008/0x11080001]
Trace 0: 0x7fffcf92c300 [00000000/21008000/0x11080001] stext
Trace 0: 0x7fffcf92c480 [00000000/210099ce/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c480 [210099ce] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c780 [210099ea] index 0 -> 0x7fffcf92c8c0 [210099dc]
Trace 0: 0x7fffcf92c8c0 [00000000/210099dc/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 0 -> 0x7fffcf92ca80 [210099f6]
Trace 0: 0x7fffcf92ca80 [00000000/210099f6/0x11080001] __lookup_processor_type
Trace 0: 0x7fffcf92cb80 [00000000/2100800c/0x11080001] stext
Linking TBs 0x7fffcf92cb80 [2100800c] index 1 -> 0x7fffcf92cc80 [21008014]
Trace 0: 0x7fffcf92cc80 [00000000/21008014/0x11080001] stext
Trace 0: 0x7fffcf92cdc0 [00000000/2120477e/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d400 [00000000/212047bc/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d500 [00000000/212047be/0x11280000] __v7m_setup
                                           ^^^^^^^^^^
Trace 0: 0x7fffcf92d600 [00000000/2100b830/0x11280001] __invalid_entry
Trace 0: 0x7fffcf92d880 [00000000/2100b842/0x11280001] __invalid_entry
Trace 0: 0x7fffcf92e100 [00000000/21025780/0x11280001] printk
Trace 0: 0x7fffcf92e640 [00000000/21025a7c/0x11280001] vprintk_func

Qemu exec trace, ok:

Trace 0: 0x7fffcf92c0c0 [00000000/00000008/0x11080001]
Trace 0: 0x7fffcf92c300 [00000000/21008000/0x11080001] stext
Trace 0: 0x7fffcf92c480 [00000000/210099ce/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c480 [210099ce] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c780 [210099ea] index 0 -> 0x7fffcf92c8c0 [210099dc]
Trace 0: 0x7fffcf92c8c0 [00000000/210099dc/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 0 -> 0x7fffcf92ca80 [210099f6]
Trace 0: 0x7fffcf92ca80 [00000000/210099f6/0x11080001] __lookup_processor_type
Trace 0: 0x7fffcf92cb80 [00000000/2100800c/0x11080001] stext
Linking TBs 0x7fffcf92cb80 [2100800c] index 1 -> 0x7fffcf92cc80 [21008014]
Trace 0: 0x7fffcf92cc80 [00000000/21008014/0x11080001] stext
Trace 0: 0x7fffcf92cdc0 [00000000/2120477e/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d400 [00000000/212047bc/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d500 [00000000/212047be/0x11280001] __v7m_setup
Trace 0: 0x7fffcf92d600 [00000000/212047c0/0x11280001] __v7m_setup
Trace 0: 0x7fffcf92d900 [00000000/212047d2/0x11280001] __v7m_setup
Linking TBs 0x7fffcf92d900 [212047d2] index 1 -> 0x7fffcf92dcc0 [212047e0]
Trace 0: 0x7fffcf92dcc0 [00000000/212047e0/0x11280001] __v7m_setup
Trace 0: 0x7fffcf92e0c0 [00000000/21008020/0x11280001] stext
Trace 0: 0x7fffcf92e200 [00000000/210099c8/0x11280001] __after_proc_init

Guenter
