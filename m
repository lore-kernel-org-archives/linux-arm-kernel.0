From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 23 Aug 2013 18:01:43 -0500
Subject: [PATCHv5 2/3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <5217E24B.3090302@wwwdotorg.org>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
 <1377272686-13253-2-git-send-email-dinguyen@altera.com>
 <5217E24B.3090302@wwwdotorg.org>
Message-ID: <1377298903.26742.14.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-23 at 16:29 -0600, Stephen Warren wrote:
> On 08/23/2013 09:44 AM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> > +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
> > +		this where the register that controls the CIU clock phases
> > +		reside.
> > +
> > +* altr,ciu-clk-offset: The order of the cells should be:
> > +	- First Cell: Offset of the register in the system_mgr node that controls
> > +		the smpsel bits.
> > +	- Second Cell: Shift value of the drvsel bits.
> > +	- Third Cell: Shift value of the smpsel bits.
> 
> This almost solves the issues I was thinking of. A few more thoughts though:
> 
> * What if the sysmgr node has multiple reg entries. Is the offset cell
> in altr,ciu-clk-offset an offset from the first reg entry, or across all
> reg entries? It might be better to specify this as a reg index plus
> offset, or allow the sysmgr node to define the format (#sysmgr-cells
> perhaps).
> 
> * What if the drvsel and smpsel bits are in different registers, even
> different sysmgr blocks? Wouldn't it be better to have 2 separate
> properties, each one defining the location of one bit-field?
> 
> * bikeshed: altr,ciu-clk-offset isn't a great name; the value is more
> than just an offset.
> 
> Putting those together, I might expect the following properties:
> 
> sysmgr: sysmgr {
>     /* binding for sysmgr node must specify what those 3 cells are */
>     #sysmgr-cells = <3>;
> }
> 
> dwmmc {
>     altr,drvsel-reg-field = <
>         &sysmgr /* sysmgr phandle */
>         0 /* reg index */
>         0 /* reg offset */
>         0 /* field bit position */
>         3 /* field bit size */>;
>     altr,smpsel-reg-field = <
>         &sysmgr /* sysmgr phandle */
>         0 /* reg index */
>         0 /* reg offset */
>         3 /* field bit position */
>         3 /* field bit size */>;
> };
> 
> That would allow the whole sysmgr concept to be completely generic.
> 
> But, this is a bit like representing raw register I/O in DT, which has
> been frowned upon in the past.
> 
> Finally, what if the values for drvsel, smpsel are different in
> different sysmgr implementations? Do you need a property that defines
> that values?
> 
> Another option might be to define a semantic API between the two, such
> that you only need a sysmgr=<&sysmgr> property, yet the driver for the
> sysmgr node exposes a function sysmgr_set_dwmmc_drvsel_smpsel(struct
> device_node *sysmgr_node, uint drvsel, uint smpsel); Now, the sysmgr
> driver would have to implement that on any SoC that supported a dwmmc.

I was trying to avoid adding a driver for the sysmgr, as it really does
not represent any type of device. It is a merely a register region with
miscellaneous registers that controls other IPs in the SOC.

I'm thinking perhaps I can set this register in the arch specific file,
then the SD/MMC driver would not need to bother with it at all?

Thanks,
Dinh
> 
> 
