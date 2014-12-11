From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 11 Dec 2014 01:46:28 +0100
Subject: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
In-Reply-To: <20141210150049.GD4602@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-3-git-send-email-balbi@ti.com>
 <54882967.60302@ti.com> <20141210150049.GD4602@saruman>
Message-ID: <20141211004627.GB5585@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 10, 2014 at 09:00:49AM -0600, Felipe Balbi wrote:
> On Wed, Dec 10, 2014 at 04:37:19PM +0530, Lokesh Vutla wrote:
> > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > In order to get rid of some more hwmod data, we
> > > introduce a few extra properties to OMAP DT
> > > data in order to be able to pass the needed
> > > information through DT.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > index 4f6a82c..c6b9515 100644
> > > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > @@ -23,6 +23,13 @@ Optional properties:
> > >    during suspend.
> > >  - ti,no-reset-on-init: When present, the module should not be reset at init
> > >  - ti,no-idle-on-init: When present, the module should not be idled at init
> > > +- ti,rev_offs: IP block revision register offset (defaults to 0)
> > > +- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
> > > +- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
> > > +- ti,srst_udelay: Delay needed after a softreset in usecs (defaults to 0)
> > > +- ti,idlemodes: Slave and Master supported idling modes
> > > +- ti,clockact: default value of clock activity bits (defaults to 0)
> > > +- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (defaults to 1)
> > Once if all the hwmod data comes to dt it will be very dufficult to see all the data
> > together. Can we separate out hwmod class data like clocks data is separated out into different node
> > or something of the sort like below?
> > 
> > 	ti, hwmod_class {
> > 		ti,class_name = <>;
> 
> this can be done, but I don't want to pass a class name. It's anyways
> just the hwmod name without the digits. For those which are not, I would
> rather change the class name to match.

I did some initial thinking on this some weeks ago, too (and then
was short of time, so I did not continue). My suggestion for the
binding would be:

* OCP_SYSCONFIG (power-management of IP-Cores connected to OMAP processors)

Each IP-Core connected to the bus of OMAP processors has
three registers, which specify the IP-Core's version, its
status and setup of PM features.

Required Properties:
- ti,prcm-type: must be one of the following:
   1 for OMAP2+ register style,
   2 for OMAP4+ register style,
   3 for AM33xx register style
- reg: offset to revision, config and status registers
       relative to module base address

Optional Properties:
- ti,idlemodes:                bit field of flags (SIDLE)
   PRCM_IDLE_FORCE               (1 << 0)
   PRCM_IDLE_NO                  (1 << 1)
   PRCM_IDLE_SMART               (1 << 2)
   PRCM_IDLE_SMART_WKUP          (1 << 3)
- ti,standbymodes:             bit field of flags (MIDLE)
   PRCM_STANDBY_FORCE            (1 << 0)
   PRCM_STANDBY_NO               (1 << 1)
   PRCM_STANDBY_SMART            (1 << 2)
   PRCM_STANDBY_SMART_WKUP       (1 << 3)
- ti,sysc-has-autoidle:        config register has AUTOIDLE bit
- ti,sysc-has-softreset:       config register has SOFTRESET bit
- ti,sysc-has-enawakeup:       config register has ENAWAKEUP bit
- ti,sysc-has-emufree:         config register has EMUFREE bit
- ti,sysc-has-clock-activity:  config register has CLOCKACTIVITY bit
- ti,sysc-has-dma-disable:     config register has DMADISABLE bit
- ti,sysc-has-reset-status:    config register has RESETDONE bit
- ti,syss-has-reset-status:    status register has RESETDONE bit
- ti,reset-delay-us:           reset delay in us

Example:

ocp {
	gpio1: gpio@48310000 {
		compatible = "ti,omap3-gpio";

		... /* IP-Core specific properties */

		ti,sysconfig {
			ti,prcm-type = <1>;
			reg = <0x00>, <0x10>, <0x14>;
			ti,idlemodes = <(PRCM_IDLE_FORCE | PRCM_IDLE_NO | PRCM_IDLE_SMART)>;
			ti,sysc-has-enawakeup;
			ti,sysc-has-autoidle;
			ti,sysc-has-softreset;
			ti,syss-has-reset-status;
		};
	};
};

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/856e193c/attachment.sig>
