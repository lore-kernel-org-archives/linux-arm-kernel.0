From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Dec 2013 19:37:57 +0100
Subject: [PATCH RFC 08/10] net: stmmac:sti: Add STi SOC glue driver.
In-Reply-To: <529C8198.7000106@st.com>
References: <1384264311-7308-1-git-send-email-srinivas.kandagatla@st.com>
 <1384264383-7653-1-git-send-email-srinivas.kandagatla@st.com>
 <20131129193715.GA3441@lukather> <529C8198.7000106@st.com>
Message-ID: <20131206183757.GH24519@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On Mon, Dec 02, 2013 at 12:48:24PM +0000, srinivas kandagatla wrote:
> Hi Maxime,
> 
> Thankyou for the comments.
> 
> On 29/11/13 19:37, Maxime Ripard wrote:
> >> +
> >> > +ethernet0: ethernet0{
> >> > +	#address-cells = <1>;
> >> > +	#size-cells = <1>;
> >> > +	compatible		= "st,stih415-dwmac";
> >> > +	reg			= <0x148 0x4>;
> >> > +	resets			= <&softreset STIH415_ETH0_SOFTRESET>;
> >> > +	st,syscon		= <&syscfg_rear>;
> >> > +	st,tx-retime-src	= "clk_125";
> >> > +	ranges;
> >> > +
> >> > +	dwmac0:dwmac at fe810000 {
> >> > +		device_type 	= "network";
> >> > +		compatible	= "snps,dwmac", "snps,dwmac-3.610";
> >> > +		reg 		= <0xfe810000 0x8000>;
> >> > +		interrupts 	= <0 147 0>;
> >> > +		interrupt-names = "macirq";
> >> > +		...
> >> > +	};
> >> > +};
> > Sorry for stepping up so late, but I dont' think this is the right way
> > to do it.
> > 
> Not a issue.
> 
> > DT is to describe how the hardware is laid out in a system agnostic
> > way, hence, it should not be impacted by the implementation details.
> > 
> If "hardware is laid out" means at SoC level? Then I attempted to do
> describe it in system agnostic way.
> 
> On ST SoCs "snps,dwmac" IP always has a hw glue layer on top of it.
> 
> > The fact that you use a glue to the dwmac driver *is* an
> > implementation detail.
> 
> Glue layer described here is actually a hardware glue on ST SoCs.

Ho, ok, it makes sense then :)

Sorry for the noise.

> > I think you'd rather have something like:
> > 
> > dwmac0: ethernet at fe810000 {
> > 	compatible		= "st,stih415-dwmac";
> > 	reg 			= <0xfe810000 0x8000 0x148 0x4>;
> > 	resets			= <&softreset STIH415_ETH0_SOFTRESET>;
> > 	st,syscon		= <&syscfg_rear>;
> > 	st,tx-retime-src	= "clk_125";
> > 	interrupts 		= <0 147 0>;
> > 	interrupt-names 	= "macirq";Am happy to go with 
> > 	...
> > };
> > 
> > Then, the driver can have its init functions associated to the
> > compatible you're using, through the .data field of the of_device_id
> > structure, and you just call it in the generic driver at probe's time.
> 
> This is changing the device tree bindings for the generic driver.
> Is this something Acceptable?

It really depends. As long as these are based on new compatibles, and
you require these new properties only for this new compatible, it's
fine most of the time.

> Peppe, are you Ok with such intrusive changes to the driver?
> 
> I did try few things before I sent this patch,
> 
> 1> Doing it via AUXDATA which was discouraged by Arnd.
> 
> 2> Doing it the way you suggested which did not fit in very neatly,
> which looked like lot of SOC specific changes are added to generic driver.
> 
> 3> Doing it as this patch, influenced by dwc3 code drivers/usb/dwc3/,
> Which fitted in very neatly without touching the existing generic driver.
> 
> stmmac driver is a generic synopsis driver which ST has written the
> driver, so I did not want to pollute this driver with ST specific glue
> logic bindings.

Yeah, I didn't know that. My apologies.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/0a0431ce/attachment.sig>
