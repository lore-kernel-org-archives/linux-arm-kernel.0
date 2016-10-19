From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 19 Oct 2016 17:46:01 +0200
Subject: [PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <20161019173704.75592f52@bbrezillon>
References: <20161019145523.6763-1-narmstrong@baylibre.com>
 <20161019173704.75592f52@bbrezillon>
Message-ID: <0f5398bb-52f1-d5bb-834c-dead4f708fd3@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 05:37 PM, Boris Brezillon wrote:
> On Wed, 19 Oct 2016 16:55:23 +0200
> Neil Armstrong <narmstrong@baylibre.com> wrote:

[...]

>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
>> @@ -0,0 +1,24 @@
>> +* Oxford Semiconductor OXNAS NAND Controller
>> +
>> +Please refer to nand.txt for generic information regarding MTD NAND bindings.
>> +
>> +Required properties:
>> + - compatible: "oxsemi,ox820-nand"
>> + - reg: Base address and length for NAND mapped memory.
>> +
>> +Optional Properties:
>> + - clocks: phandle to the NAND gate clock if needed.
>> + - resets: phandle to the NAND reset control if needed.
>> +
>> +Example:
>> +
>> +nand: nand at 41000000 {
> 
> nandc: nand-controller at 41000000 {
> 
>> +	compatible = "oxsemi,ox820-nand";
>> +	reg = <0x41000000 0x100000>;
>> +	nand-ecc-mode = "soft";
>> +	clocks = <&stdclk CLK_820_NAND>;
>> +	resets = <&reset RESET_NAND>;
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	status = "disabled";
>> +};
> 
> You should probably provide an example where the NAND controller is
> enabled and at least one nand chip is connected to the NAND bus.

Indeed, I forgot that.

[...]

>> +
>> +static uint8_t oxnas_nand_read_byte(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct oxnas_nand *oxnas = nand_get_controller_data(chip);
>> +
>> +	return readb(oxnas->io_base);
>> +}
>> +
>> +static void oxnas_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct oxnas_nand *oxnas = nand_get_controller_data(chip);
>> +
>> +	ioread8_rep(oxnas->io_base, buf, len);
>> +}
>> +
>> +static void oxnas_nand_write_buf(struct mtd_info *mtd,
>> +				 const uint8_t *buf, int len)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct oxnas_nand *oxnas = nand_get_controller_data(chip);
>> +
>> +	iowrite8_rep(oxnas->io_base + oxnas->ctrl, buf, len);
>> +}
>> +
>> +/* Single CS command control */
>> +static void oxnas_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>> +				unsigned int ctrl)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct oxnas_nand *oxnas = nand_get_controller_data(chip);
>> +
>> +	if (ctrl & NAND_CTRL_CHANGE) {
>> +		if (ctrl & NAND_CLE)
>> +			oxnas->ctrl = OXNAS_NAND_CMD_CLE;
>> +		else if (ctrl & NAND_ALE)
>> +			oxnas->ctrl = OXNAS_NAND_CMD_ALE;
>> +		else
>> +			oxnas->ctrl = 0;
>> +	}
>> +
>> +	if (cmd != NAND_CMD_NONE)
>> +		writeb(cmd, oxnas->io_base + oxnas->ctrl);
> 
> There's no need to test the NAND_CTRL_CHANGE here, and I don't think
> the CLE or ALE flag is ever set when cmd == CMD_NONE. So, you can kill
> the ->ctrl field and simply do:
> 
> 	if (ctrl & NAND_CLE)
> 		writeb(cmd, oxnas->io_base + OXNAS_NAND_CMD_CLE);
> 	else if (ctrl & NAND_ALE)
> 		writeb(cmd, oxnas->io_base + OXNAS_NAND_CMD_ALE);
> 
>> +}

Hmm, except it's needed back in the oxnas_nand_write_buf() call (don't ask me why)
so I don't see how to simplify more this function.
