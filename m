From: wmb@firmworks.com (Mitch Bradley)
Date: Mon, 30 May 2011 10:53:25 -1000
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <BANLkTi=hkScxYpt449CQCky+bLU3UvkC_A@mail.gmail.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
	<8d2515b13c817cc956b185d043bcef00@kernel.crashing.org>
	<BANLkTi=hkScxYpt449CQCky+bLU3UvkC_A@mail.gmail.com>
Message-ID: <4DE403C5.7060003@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perhaps the interrupt-mapping binding is not the best model.  Interrupt 
hardware in general is hierarchical but is not isomorphic to the 
physical addressing hierarchy of the device tree.

GPIOs share the need to "point across the tree to different nodes", but 
it is unclear that there is a need for a entirely different hierarchy.

That suggests the possibility of using the device tree addressing 
mechanism as much as possible.  Normal device tree addresses could be 
used to specify GPIO numbers.

Suppose we have:

	gpio-controller1: gpio-controller {
                 #address-cells = <2>;
		#mode-cells = <2>;
                 gpio1: gpio at 12,0 {
                     reg = <12 0>;
                     mode = <55 66>;
                     usage = "Audio Codec chip select";  /* Optional */
                 }
	};
	gpio-controller2: gpio-controller {
                  #address-cells = <1>;
		 #mode-cells = <1>;
                  gpio2: gpio at 4 {
                      reg = <4>;
                      #mode-cells = <1>;
                  }
	};
	[...]
	chipsel-gpio =  <&gpio1>,
			<&gpio-controller1 13 0 55 77>,
			<0>, /* holes are permitted, means no GPIO 2 */
			<&gpio2 88>,
                         <&gpio-controller2 5 1>;


A GPIO spec consist of:

1) A reference to either a gpio-controller or a gpio device node.

2) 0 or more address cells, according to the value of #address-cells in 
the referenced node.  If the node has no #address-cells property, the 
value is assumed to be 0.

3) 0 or more mode cells, according to the value of #mode-cells in the 
referenced node.

In the example, the chipsel-gpio specs are interpreted as:

<&gpio1>  -  refers to a pre-bound gpio device node, in which the 
address (12 0) and mode (55 66) are specified within that node.

<&gpio-controller1 13 0 55 77>  -  refers to a GPIO controller node, 
specifing the address (13 0) and the mode (55 77) in the client's GPIO spec.

<gpio2>  -  another reference to a gpio node on a different controller. 
  In this case the address (4) is bound in the gpio node, but the mode 
(88) is passed in from the client's GPIO spec.

<&gpio-controller2 5 1>  -  another reference to a controller node, with 
a one-cell address (5) and a one-cell mode (1), according to the values 
of #address-cells and #mode-cells in that controller node.

I expect that the "pre-bound gpio node" case would get a lot of use in 
practice, as it lets you isolate the client from the details of the 
interrupt controller addressing and modes.  In my experience, GPIOs 
often get reassigned between revisions of the same board, especially 
early in the development cycle.
