From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 29 May 2015 07:55:49 +0200
Subject: [PATCHv3 1/2] dts: Adding docs for Xilinx LogiCORE IP mailbox
 driver.
In-Reply-To: <1432849928-25457-2-git-send-email-moritz.fischer@ettus.com>
References: <1432849928-25457-1-git-send-email-moritz.fischer@ettus.com>
 <1432849928-25457-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <5567FF65.5040208@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 11:52 PM, Moritz Fischer wrote:
> Changes from v2:
> - Addressed Michal's stylistic comments
> - Fixed typo in compatible string
> 
> Changes from v1:
> - Added common clock framework support
> 
> Changes from v0:
> - Fixed example bindings
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  .../bindings/mailbox/xilinx-mailbox.txt         | 44 ++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> new file mode 100644
> index 0000000..ca76efd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> @@ -0,0 +1,44 @@
> +Xilinx Mailbox Driver
> +=====================
> +
> +Required properties:
> +- compatible       : "xlnx,mailbox-2.1".
> +- reg              :  physical base address of the mailbox and length of
> +                      memory mapped region.
> +- #mbox-cells      :  common mailbox binding property to identify the number
> +                      of cells required for the mailbox specifier, should be 1
> +- clocks           :  phandle to clock provider
> +- clock-names      :  must be 'mbox'
> +
> +Optional properties:
> +- interrupt-parent : interrupt source phandle
> +- interrupts       : interrupt number, The interrupt specifier format
> +                     depends on the interrupt controller parent.
> +
> +Example:
> +	mbox: mailbox at 40400000 {
> +		compatible = "xlnx,mailbox-2.1";
> +		reg = <0x40400000 0x3c>;
> +		interrupt-parent = <&intc>;
> +		interrupts = <5>;
> +		#mbox-cells = <1>;
> +		clocks = <&clkc 15>;
> +		clock-names = "mbox";
> +	};
> +
> +Mailbox client
> +===============
> +"mboxes" and the optional "mbox-names" (please see
> +Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
> +of the mboxes property should contain a phandle to the mailbox controller
> +device node and second argument is the channel index. It must be 0 (hardware
> +support only one channel). The equivalent "mbox-names" property value can be
> +used to give a name to the communication channel to be used by the client user.
> +
> +Example:
> +	mclient0: mclient0 at 400 {
> +		compatible = "client-1.0";
> +		reg = <0x400 0x10>;
> +		mbox-names = "mbox";
> +		mboxes = <&mbox 0>;
> +	};
> 

I see you still keep there 0x3c but that's minor detail.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
