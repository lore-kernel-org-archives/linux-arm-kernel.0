From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 5 Nov 2012 12:35:09 -0600
Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
In-Reply-To: <60e4cbf9-52b4-4c02-8537-ecd3a7dbbf06@CO1EHSMHS020.ehs.local>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200310.GB6713@beefymiracle.amer.corp.natinst.com>
 <0d1c4cf8-70d8-4d12-bd77-393009d32b22@CH1EHSMHS001.ehs.local>
 <20121027140053.GB5190@beefymiracle.amer.corp.natinst.com>
 <4fd22fac-49c4-4000-9e70-12e94f248753@AM1EHSMHS010.ehs.local>
 <20121027144253.GC5190@beefymiracle.amer.corp.natinst.com>
 <60e4cbf9-52b4-4c02-8537-ecd3a7dbbf06@CO1EHSMHS020.ehs.local>
Message-ID: <20121105183509.GA1254@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 03:20:59PM +0000, Michal Simek wrote:
> On Saturday, October 27, 2012 4:43 PM, Josh Cartwright wrote:
> > On Sat, Oct 27, 2012 at 02:06:45PM +0000, Michal Simek wrote:
> > [...]
> > > I am not big fan to use dtsi solution because dts can be simple
> > > generated directly From Xilinx design tool based on your hw design.
> > > That's why I can't see any benefit To have dtsi file.
> >
> > Can I ask you to reconsider?
>
> I am open to all solution which will help others. I am not definitely
> saying NO for this features I just haven't found a reason to support
> it.
>
> > We, for example, don't make any use of the Xilinx
> > dev tools to generate our device trees.
>
> Ok. How does your working flow looks like?  I mean you don't get any
> information from hardware guys how does your hw design look like?

Our usecase may admittedly be a bit weird, because what logic is in the
PL is ultimately determined (and even implemented) by the end user and
is loaded at runtime.  There is a lot of machinery to make that happen,
but the point is that I don't have sufficient knowledge upfront to
generate appropriate bindings for what's in the PL.

> > Having a dtsi allows for easy extension of the zynq-7000 platform
> > for our boards, without having to carry duplicate data.
>
> ok. I think that make sense if you send the next your series as RFC to
> see how exactly you would like to use it.

It seems like you caught a glimpse of this in my COMMON_CLK patchset. :)

> In my workflow we generate DTS directly from design tool which I
> expect your hw guys use because it is probably needed to generate
> boot.bin/fsbl/etc.  Then there is one more additional step to setup
> device-tree bsp to generate DTS which directly fits to your HW design.
> If you have the same boards with different programmable logic I
> understand that you would like to share that PS part and then just add
> it that IPs in PL.
[..]
> From my point of view. You have to use design tools at least once to
> get bitstream and boot.bin with fsbl. Please correct me if I am wrong.
> In this step you can use device-tree BSP to generate DTS ( I doesn't
> need to be perfect with all attached devices on i2c,spi, phys, etc but
> it reflects your hardware).  You will get it in some seconds and your
> dts has correct irq numbers/ip description, compatible strings,
> addresses, position in the system - if you use bus bridges, etc) and
> you can just directly use it and kernel will boot. If you need to do
> changes in dts by hand, you can of course do it.

I wouldn't be as opposed to device tree generation if the device tree
generator was in tree.  Device tree bindings change, how would/could an
out-of-tree generator possibly handle changes in bindings?  Would a user
target the generator at a specific version of the kernel?  (An in tree
generator would also seem to necessitate a more formal specification
language for DT bindings).

It is odd to me that the use of a generator would be required to create
what is completely static data.  What I'm referring to here is the
collection of peripherals on the zynq-7000 that are not in the PL.  For
me, this requirement adds an unnecessary dependency on the Xilinx EDK
that I would like to avoid.

Would it make sense to limit what the device tree generator produces to
only what is in the PL?  (Forgive my ignorance about this tool, I've
never used it.)

This could just be an extension of what I've started to do with the
COMMON_CLK patchset.  A zynq board would be described using several
device tree snippets, one for the baked-in zynq-7000 peripheral set, one
for a generated description of what is in the PL, and one describing any
board-specific details (phy, etc).  Something like below:

zynq-7000.dtsi  : description of static zynq-7000 peripherals

	/ {
		amba : amba at 0 {
			slcr: slcr at f8000000 {
				clocks {
					ps_clk : ps_clk {
						compatible = "fixed-clock";
					};
					...
				}
			};
			i2c0 : i2c0 at e0004000 {
				compatible = "xlnx,i2cps";
				...
			};
			eth0 : eth0 at e000b000 {
				compatible = "xlnx,emacps";
				...
			};
		};
	};

zynq-zc702-pl.dtsi : generated description of what is in the PL

	&amba {
		/* PL IP generated descriptions here. */
	};

zynq-zc702.dts  : board-specific descriptions (osc freq, i2c, spi, phys, etc)

	/include/ "zynq-7000.dtsi"
	/include/ "zynq-zc702-pl.dtsi"
	&ps_clk {
		clock-frequency = <33333330>;
	};
	&i2c0 {
		pca9548 at 74 {
			...
			reg = <0x74>;
			...
		};
	};
	&eth0 {
		phy at 7 {
			compatible = "marvell,888e1116r";
			...
			reg = <0x7>;
		};
	};

Thoughts?

Thanks,
  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/261d059b/attachment-0001.sig>
