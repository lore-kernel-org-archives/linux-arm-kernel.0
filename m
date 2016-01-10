From: kernel@martin.sperl.org (Martin Sperl)
Date: Sun, 10 Jan 2016 12:05:52 +0100
Subject: [PATCH 5/5] dt-bindings: bsm2835: fix bindings documentation to
 use new clock framework
In-Reply-To: <20160109224523.GA17329@rob-hp-laptop>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-6-git-send-email-kernel@martin.sperl.org>
 <20160109224523.GA17329@rob-hp-laptop>
Message-ID: <ED21A42A-EE91-495D-857E-04C533CD718C@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 09.01.2016, at 23:45, Rob Herring <robh@kernel.org> wrote:
> 
> On Sat, Jan 09, 2016 at 09:25:57AM +0000, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> The bcm2835-i2s driver has been updated to use the new clock framework
>> for the bcm2835 SOC.
> 
> You are breaking compatibility with the driver change. New kernels will 
> not work with old dtbs as you have found. What should be done is fix the 
> driver to work with the old and new dtb.

Actually the driver/device-tree is already broken with commit 94cb7f76caa0
("ARM: bcm2835: Switch to using the new clock driver support?)

Because there we already have the following conflicting definitions:

clocks: cprman at 7e101000 {
	compatible = "brcm,bcm2835-cprman";
	#clock-cells = <1>;
	reg = <0x7e101000 0x2000>;
	/* CPRMAN derives everything from the platform's
	* oscillator.
	*/
	clocks = <&clk_osc>;
};

i2s: i2s at 7e203000 {
	compatible = "brcm,bcm2835-i2s";
	reg = <0x7e203000 0x20>,
	      <0x7e101098 0x02>;
	dmas = <&dma 2>,
	       <&dma 3>;
	dma-names = "tx", "rx";
	status = "disabled";
};

The i2s driver fails to load because the second reg range
overlaps with the range from clocks (which was introduced
with the commit mentioned above.

This patch only changes the driver to work again without
this second reg address range and using the clocks property
instead.

> 
>> This patch documents the required changes to the bindings.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +++----
>> 1 file changed, 3 insertions(+), 4 deletions(-)
> 
> But I leave it to platform maintainers to decide if breaking 
> compatibility is okay, so:
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
	Martin
