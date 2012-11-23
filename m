From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Nov 2012 11:36:31 +0100
Subject: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <87zk2djox6.fsf@dell.be.48ers.dk>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
 <1353338956-19420-4-git-send-email-zonque@gmail.com>
 <87zk2djox6.fsf@dell.be.48ers.dk>
Message-ID: <50AF51AF.4050003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 19.11.2012 21:52, Peter Korsgaard wrote:
>>>>>> "D" == Daniel Mack <zonque@gmail.com> writes:
> 
> Hi,
> 
>  D> This patch adds basic DT bindings for OMAP GPMC.
>  D> The actual peripherals are instanciated from child nodes within the GPMC
> 
> s/instanciated/instantiated/

Thanks, fixed.

> 
>  D> node, and the only type of device that is currently supported is NAND.
> 
>  D> Code was added to parse the generic GPMC timing parameters and some
>  D> documentation with examples on how to use them.
> 
>  D> Successfully tested on an AM33xx board.
> 
>  D> Signed-off-by: Daniel Mack <zonque@gmail.com>
>  D> ---
>  D>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  84 ++++++++++
>  D>  arch/arm/mach-omap2/gpmc.c                         | 170 +++++++++++++++++++++
>  D>  2 files changed, 254 insertions(+)
>  D>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> 
>  D> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>  D> new file mode 100644
>  D> index 0000000..20aa5b9
>  D> --- /dev/null
>  D> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>  D> @@ -0,0 +1,84 @@
>  D> +Device tree bindings for GPMC connected NANDs
>  D> +
>  D> +GPMC connected NAND (found on OMAP boards) are represented as child nodes of
>  D> +the GPMC controller with a name of "nand".
>  D> +
>  D> +All timing relevant properties as well as generic gpmc child properties are
>  D> +explained in a separate documents - please refer to
>  D> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> 
> Which this patch seems to be missing?

True - sorry for that. Will be back at v5.

>  D> +
>  D> +For NAND specific properties such as ECC modes or bus width, please refer to
>  D> +Documentation/devicetree/bindings/mtd/nand.txt
>  D> +
>  D> +
>  D> +Required properties:
>  D> +
>  D> + - reg:		The CS line the peripheral is connected to
>  D> +
>  D> +Optional properties:
>  D> +
>  D> + - nand-bus-width: 		Set this numeric value to 16 if the hardware
>  D> +				is wired that way. If not specified, a bus
>  D> +				width of 8 is assumed.
>  D> + - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
>  D> +
>  D> +	Layouts for 1-bit ecc: stored at end of spare area:
>  D> +
>  D> +		"software"	Software method (default)
>  D> +		"hw"		Hardware method (let gpmc do the error detection)
> 
> Nit: why are you spelling out 'software' when everything else is shortened?

Right. Fixed.

> 
>  D> +
>  D> +	Layouts for 1-bit ecc: stored at beginning of spare area as romcode:
>  D> +
>  D> +		"hw-romcode"	gpmc method & romcode layout
>  D> +		"bch4"		4-bit BCH ecc code
>  D> +		"bch8"		8-bit BCH ecc code
>  D> +
> 
> These are not 1-bit - Well, romcode might be depending on SoC. Looking at
> omap2.c it seems to be an alias for hw, so that isn't really helpful on
> E.G. am33xx where you should select bch8 to have something compatible
> with the romcode.

Not sure whether I follow you here. drivers/mtd/nand/omap2.c handles
cases for pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW, so the DT bindings
need to offer a way to set it.

Or are you purely referring to the comments only?

>  D> + - ti,nand-ecc-use-elm:		Property without value to specify that the
>  D> +				hardware error correction mode should be used.
> 
> It's called the error location module. Like you pointed out yourself,
> this property isn't really nice. I haven't looked at the elm bindings in
> detail, but couldn't the nand driver automatically use the elm if the
> device tree provides a node for it? Perhaps the elm should be a subnode
> of the nand one?

That is to be discussed for the elm driver then. I'm not sure though
whether the elm should always be used when its DT node is present.

For now, I would leave it the way it is and have an optional
"ti,nand-ecc-use-elm". I just added some more lines of documenation to
describe the fact that the elm driver is needed in order to make it work.



Daniel
