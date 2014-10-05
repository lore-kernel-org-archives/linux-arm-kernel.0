From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Oct 2014 08:36:00 +0900
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CANqRtoTJNb7a9J05U0chrGoxBV7e1s6o0Xxeup0p1sOUZhE+vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for your patch! Quick comment from my side below:

On Fri, Oct 3, 2014 at 4:02 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add serial port debug macros for the SCIF(A) serial ports.
> This includes all shmobile SoCs, except for EMEV2.
>
> On SoCs using the legacy machine_desc.map_io(), an identity mapping of
> the SCIF(A) registers must be set up in .map_io(). On all but r8a7779
> this was already done.
>
> On other SoCs, debug_ll_io_init() maps the SCIF(A) registers to a fixed
> virtual address. 0xfdxxxxxx was chosen, as it should lie below
> VMALLOC_END = 0xff000000, and must not conflict with the 2 MiB reserved
> region at PCI_IO_VIRT_BASE = 0xfee00000.
>
> This was derived from the r8a7790 version by Laurent Pinchart.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on r8a7791/koelsch and r8a7740/armadillo.
> Testing on other platforms would be highly appreciated.
>
> Notes:
>   - On armadillo-multiplatform there may be a period while garbage data
>     is output.
>     This happens because sh_mobile_i2c_init() enables and disables its
>     clock during probing. As iic0 and scifa1 share the same parent
>     clock, this causes the scifa1 clock to no longer receive clock
>     ticks.
>     On armadillo-legacy, this is mitigated by the pre-CCF clock driver,
>     which never really disables clocks during boot-up for exactly this
>     reason. Cfr. "One example of this is the handling of the Mackerel
>     serial console output that shares clock with the I2C controller.",
>     in commit 794d78fea51504ba ("drivers: sh: late disabling of clocks
>     V2").
>     I'm wondering whether this can be fixed in the i2c driver? Does it
>     really have to enable and disable the clock?

I've seen this issue on several SoCs actually, and as you describe the
main issue seems to be that there are clock topologies that present
for devices used during boot (like serial) but this clock topology is
not yet managed by software. This does not trigger on all SoCs though.

It is my opinion that it has very little todo with the other devices
that happen to be using the same parent clock. The legacy clock
framework solved this by not allowing clocks to be disabled until all
devices were registered.

Cheers,

/ magnus
