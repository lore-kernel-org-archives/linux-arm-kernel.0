From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 18 Jun 2018 13:51:53 +0200
Subject: [PATCH v2 2/4] dt-bindings: mailbox: provide imx-mailbox
 documentation
In-Reply-To: <9d436d3a9c534b0c7af339aa13e91c1293a55503.camel@nxp.com>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
 <20180615095107.24610-3-o.rempel@pengutronix.de>
 <9d436d3a9c534b0c7af339aa13e91c1293a55503.camel@nxp.com>
Message-ID: <acce6810-65d7-4264-13d0-ad405639cd6f@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On 18.06.2018 10:53, Leonard Crestez wrote:
> On Fri, 2018-06-15 at 11:51 +0200, Oleksij Rempel wrote:
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  .../bindings/mailbox/imx-mailbox.txt          | 35 +++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
> 
> A recent patch was posted which adds a similar but different binding
> for the MU on 8qm/8qxp SOCs:
> 
> https://patchwork.kernel.org/patch/10468885/
> 
> Looking at manuals side-by-side the hardware seems to be the same so
> there should be a single binding. Right?

yes. This is why it make no sense to create imx8 specific MU driver.

> That series I pointed to uses the MU to implement a communication with
> a special "SCU" core which runs NXP firmware for handling details like
> power management. However imx8 socs also have other MUs and M4 cores
> for customers to use pretty exactly like they would on 7d.
> 
> The hardware exposes a very generic interface and my impression is that
>  drivers for the MU are actually highly specific to what is on the
> other side of the MU. For example your driver code seems to be mapping
> the 4 MU registers to separate "channels" but for SCU messages are
> written in all registers in a round-robin way.

ok.. let's take some of IMX8 SCU driver code to see if there any difference:

-- this part of the code is blocking write procedure for one channeler
per write-- correct?
+void mu_send_msg(struct mu_priv *priv, uint32_t index, uint32_t msg)
+{
+	uint32_t mask = MU_SR_TE0_MASK >> index;
+
+	/* Wait TX register to be empty. */
+	while (!(readl_relaxed(priv->base + MU_ASR) & mask))
+		;
+	writel_relaxed(msg, priv->base + MU_ATR0  + (index * 4));
+}
+EXPORT_SYMBOL_GPL(mu_send_msg);

+static void sc_ipc_write(struct sc_ipc *sc_ipc, void *data)
+{
+	sc_rpc_msg_t *msg = (sc_rpc_msg_t *) data;
+	uint8_t count = 0;
+
+	/* Check size */
+	if (msg->size > SC_RPC_MAX_MSG)
+		return;
+
+	/* Write first word */
+	mu_send_msg(sc_ipc->mu_base, 0, *((uint32_t *) msg));
+	count++;

--- in this loop we are writing to one channel per loop and waiting
until the channel was done ----

+	/* Write remaining words */
+	while (count < msg->size) {
+		mu_send_msg(sc_ipc->mu_base, count % MU_TR_COUNT,
+			    msg->DATA.u32[count - 1]);
+		count++;
+	}
+}


... and here is a proof that sc_ipc_write will do in some cases 5 rounds
(5 * 4 bytes = 20 bytes single message) with probable busy waiting for
each channel, which make me think that shared memory would be a better deal.

+sc_err_t sc_misc_seco_image_load(sc_ipc_t ipc, uint32_t addr_src,
+				 uint32_t addr_dst, uint32_t len, bool fw)
+{
+	sc_rpc_msg_t msg;
+	uint8_t result;
+
+	RPC_VER(&msg) = SC_RPC_VERSION;
+	RPC_SVC(&msg) = (uint8_t)SC_RPC_SVC_MISC;
+	RPC_FUNC(&msg) = (uint8_t)MISC_FUNC_SECO_IMAGE_LOAD;
+	RPC_U32(&msg, 0) = addr_src;
+	RPC_U32(&msg, 4) = addr_dst;
+	RPC_U32(&msg, 8) = len;
+	RPC_U8(&msg, 12) = (uint8_t)fw;
+	RPC_SIZE(&msg) = 5;
+
+	sc_call_rpc(ipc, &msg, false);
+
+	result = RPC_R8(&msg);
+	return (sc_err_t)result;
+}
+

So, the same code with mailbox framework will be some thing like this:

	/* Write remaining words */
	while (count < msg->size) {
		mbox_send_message(sc_ipc->mbox_chan[count % MU_TR_COUNT],
msg->DATA.u32[count - 1]);
		count++;
	}

to provide identical behavior we should set mbox_client->tx_block = true
and implement polling mode in the mailbox driver.

Please note. I don't think sc_ipc_write() implementation is good. I just
don't expect it will be ever changed.

> Shouldn't your MU-using driver be a separate node which references the
> MU by phandle? Like in this patch:

sure. But it is generic, not mailbox controller specific and make no
sense to describe client binding again in the controller binding.

> https://patchwork.kernel.org/patch/10468887/
> 
>> diff --git a/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
>> new file mode 100644
>> index 000000000000..1577b86f1206
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
>> @@ -0,0 +1,35 @@
>> +i.MX Messaging Unit
>> +===================
>> +
>> +The i.MX Messaging Unit (MU) contains two register sets: "A" and "B". In most
>> +cases they are accessible from all Processor Units. On one hand, at least for
>> +mailbox functionality, it makes no difference which application or processor is
>> +using which set of the MU. On other hand, the register sets for each of the MU
>> +parts are not identical.
>> +
>> +Required properties:
>> +- compatible :	Shell be one of:
>> +                    "fsl,imx7s-mu-a" and "fsl,imx7s-mu-b" for i.MX7S or i.MX7D
>> +- reg :		physical base address of the mailbox and length of
>> +		memory mapped region.
>> +- #mbox-cells:	Common mailbox binding property to identify the number
>> +		of cells required for the mailbox specifier. Should be 1.
>> +- interrupts :	The interrupt number
>> +- clocks     :  phandle to the input clock.
>> +
>> +Example:
>> +	mu0a: mailbox at 30aa0000 {
>> +		compatible = "fsl,imx7s-mu-a";
>> +		reg = <0x30aa0000 0x28>;
>> +		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&clks IMX7D_MU_ROOT_CLK>;
>> +		#mbox-cells = <1>;
>> +	};
>> +
>> +	mu0b: mailbox at 30ab0000 {
>> +		compatible = "fsl,imx7s-mu-b";
>> +		reg = <0x30ab0000 0x28>;
>> +		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&clks IMX7D_MU_ROOT_CLK>;
>> +		#mbox-cells = <1>;
>> +	};

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/1f171821/attachment-0001.sig>
