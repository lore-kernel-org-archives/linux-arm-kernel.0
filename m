From: ore@pengutronix.de (Oleksij Rempel)
Date: Fri, 23 Jun 2017 16:35:37 +0200
Subject: [RFC PATCH 2/3] remoteproc: imx_rproc: add a NXP/Freescale imx
 rproc driver
In-Reply-To: <42620944-14b6-1591-e2b4-4c15a577774a@ti.com>
References: <20170614204855.18347-1-o.rempel@pengutronix.de>
 <20170614204855.18347-3-o.rempel@pengutronix.de>
 <96edc898-ad2b-c781-b7eb-0645902837df@ti.com>
 <f146c11f-1cca-68db-325b-036b0f614963@pengutronix.de>
 <42620944-14b6-1591-e2b4-4c15a577774a@ti.com>
Message-ID: <20170623143537.e2bfsssxwdnft3pe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 04:09:26PM -0500, Suman Anna wrote:
> Hi Oleksij,
> 
> On 06/19/2017 02:43 AM, Oleksij Rempel wrote:
> > Hi,
> > 
> > Thank you for your review!
> > 
> > On 15.06.2017 21:01, Suman Anna wrote:
> >> Hi Oleksij,
> >>
> >> On 06/14/2017 03:48 PM, Oleksij Rempel wrote:
> >>> From: Oleksij Rempel <linux@rempel-privat.de>
> >>>
> >>> this driver was tested on NXP imx7d but should work on
> >>> imx6sx as well.
> >>> It will upload firmware to OCRAM, which shared memory between
> >>> Cortex A7 and Cortex M4, then turn M4 on.
> >>
> >> Mostly looks fine, need to address few comments. I take it that you
> >> haven't added the binding since this is just an RFC.
> >>
.....
> >>> +
> >>> +static const char *mem_names[IMX7D_RPROC_MEM_MAX] = {
> >>> +    [IMX7D_RPROC_IMEM]    = "imem",
> >>> +    [IMX7D_RPROC_DMEM]    = "dmem",
> >>> +};
> >>
> >> Do you really need these to be globally defined? You only need them in
> >> the addr_init function, they can be made local to that function.
> > 
> > I don't needed. At least not with my testing remote code.
> > It is mostly copy/paste from existing drivers.
> > 
> > But according to this page, there are multiple memory regions, with
> > different mapping for data and code.
> > http://developer.toradex.com/knowledge-base/freertos-on-the-cortex-m4-of-a-colibri-imx7#Memory_areas
> > 
> > 
> > "The Cortex-M4 CPU has two buses connected to the main interconnect
> > (modified Harvard architecture). One bus is meant to fetch data (system
> > bus) whereas the other bus is meant to fetch instructions (code bus). To
> > get optimal performance, the program code should be located and linked
> > for a region which is going to be fetched through the code bus, while
> > the data area (e.g. bss or data section) should be located in a region
> > which is fetched through the system bus.
> 
> Yeah that's standard Cortex-M4 address/bus access architecture based on
> memory addresses it sees, and the addresses are as per what the CPU
> views them at.
> 
>  There are multiple example
> > linker files in the platform/devices/MCIMX7D/linker/ sub directory which
> > can be used and/or modified. All example firmware below use the
> > MCIMX7D_M4_tcm.ld linker file (TCML region for code, and the TCMU region
> > for data)."
> > 
> > What is the proper way to implement it with remoteproc?
> 
> So, TCML and TCMU looks to be internal memories within the Cortex-M4
> subsystem from the link you shared. The rproc_da_to_va() is being used
> today to provide the translations from the CPU device address (da) to
> the kernel virtual address for the same memory (va) so that memcpy can
> be used for loading the section data into those memories. The ioremap
> from the A7 should be using the bus addresses.

I was reading linker and Make files provided by the git repo in the page
 posted before. So far:
- different app examples can use different linker configurations
  (MCIMX7D_M4_ddr.ld, MCIMX7D_M4_ocram.ld or MCIMX7D_M4_tcm.ld)
- only one configuration was used at the time.

I assume, to cover all this cases:
- for each momory range should be created own DT node, with probably own
  clock entry.  At leas *_tcm.ld and *_ocram.ld seems to fit in this pattern.

Should actually all possible variants be covered?

what is the best practice to proceed with shared ddr space? Should it be
reserved-memory node in DT?
Should the translation map created in DeviceTree or in driver?

> 
> >>> +
> >>> +/**
> >>> + * struct imx_rproc_mem - slim internal memory structure
> >>> + * @cpu_addr: MPU virtual address of the memory region
> >>> + * @bus_addr: Bus address used to access the memory region
> >>> + * @size: Size of the memory region
> >>> + */
> >>> +};
> >>> +
> >>> +struct imx_rproc_dcfg {
> >>> +    int offset;
> >>> +};
> >>> +
> >>> +struct imx_rproc {
> >>> +    struct device            *dev;
> >>> +    struct regmap            *regmap;
> >>> +    struct rproc            *rproc;
> >>> +    const struct imx_rproc_dcfg    *dcfg;
> >>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
