From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Jun 2013 17:02:50 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130611215023.GA12649@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130609014506.GB10027@obsidianresearch.com>
 <20130611135737.GC3996@localhost> <20835253.Agl4DfuI3k@wuerfel>
 <20130611215023.GA12649@obsidianresearch.com>
Message-ID: <20130612200248.GA23012@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Tue, Jun 11, 2013 at 03:50:23PM -0600, Jason Gunthorpe wrote:
> On Tue, Jun 11, 2013 at 05:26:47PM +0200, Arnd Bergmann wrote:
> 
> > That looks ok to me, yes. If you have just one device under some of the nodes
> > however, I think it's easier use an empty ranges property and do
> > 
> >  	devbus-bootcs {
> >  		ranges;
> >  		nor {
> >  			reg = <0x012f0000 0 0x1000000>;
> >  		};
> > 
> > The 'ranges' here is most useful if you have multiple devices
> > add different offsets. I would also predefine those ranges to
> > be as large as possible so you don't have to adapt them when
> > the child device grows beyond it.
> 
> It isn't super critical, but the ranges does keep the 0x012f0000 value
> in the SOC .dtsi and the board level doesn't have to be exposed to the
> value, it just uses 0 to setup the NOR.
> 
> Also, it makes it much simpler for the mbus driver to detect which
> target id's are required so they can be allocated/setup - the rule
> would be every child stanza should have a ranges with the target(s) it
> needs.
> 
> The full version probably looks like this:
> 
> mbus {
>     ranges ....
> 
>                         devbus-bootcs at 10400 {
>                                 compatible = "marvell,mvebu-devbus";
>                                 reg = <INTERNAL_REGS + 0x10400 0x8>;
>                                 ranges = <0 DEVBUS_BOOTCS 0x1000000>;
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
>                                 clocks = <&coreclk 0>;
> 
> 				// In board .dts:
>                                 nor at 0 {
>                                         compatible = "cfi-flash";
>                                         reg = <0 0x1000000>;
>                                         bank-width = <2>;
>                                 };
>                         };
> };
> 
> And notice here that we need to offset INTERNAL_REGS to make this
> work. To me, this is the primary reason why the 2nd cell of the mbus
> address format *must* be the address offset within the target, and not
> anything else.
> 

I tried to implement something like the above, but adding numbers
does not seem to work using the preprocessor on the DT.

I'm probably missing something, but... are you sure that's supposed to work?

I ended up implementing something similar, see below.
The defines shown are very early/hacky, just to get it working.
I'll implement them better, so omit them for now.

#define INTERNAL_REGS_ID 0xffff0001

#define INTERNAL_REGS INTERNAL_REGS_ID 0
#define DEVBUS_BOOTCS 0x012f0000 0
#define BOOTROM       0x01e00000 0

#define INTERNAL_REGS_BASE 0 0xd0000000
#define DEVBUS_BOOTCS_BASE 0 0xf0000000
#define BOOTROM_BASE       0 0xfff00000
...
 
soc {
	ranges = <INTERNAL_REGS INTERNAL_REGS_BASE 0x100000
		  BOOTROM       BOOTROM_BASE       0x100000
		  DEVBUS_BOOTCS DEVBUS_BOOTCS_BASE 0x1000000>;

	devbus-bootcs {
		compatible = "marvell,mvebu-devbus";
		reg = <INTERNAL_REGS_ID 0x10400 0x8>;
		ranges = <0 DEVBUS_BOOTCS 0x1000000>;
		#address-cells = <1>;
		#size-cells = <1>;
		status = "disabled";
		
		nor at 0 {
			compatible = "cfi-flash";
			reg = <0 0x1000000>;
			bank-width = <2>;
		};
	};
};

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
