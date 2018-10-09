From: sunnyliangjy@gmail.com (Wendy Liang)
Date: Tue, 9 Oct 2018 11:25:49 -0700
Subject: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1515109891-17133-3-git-send-email-jliang@xilinx.com>
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
 <1515109891-17133-3-git-send-email-jliang@xilinx.com>
Message-ID: <CAA07jV8EinRQGtfhLchrZLkbkdRao7hugPD=02CO7MMv06WUSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 3:53 PM Wendy Liang <wendy.liang@xilinx.com> wrote:
>
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> new file mode 100644
> index 0000000..5e270a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> @@ -0,0 +1,104 @@
> +Xilinx IPI Mailbox Controller
> +========================================
> +
> +The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> +messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> +agent owns registers used for notification and buffers for message.
> +
> +               +-------------------------------------+
> +               | Xilinx ZynqMP IPI Controller        |
> +               +-------------------------------------+
> +    +--------------------------------------------------+
> +ATF                    |                     |
> +                       |                     |
> +                       |                     |
> +    +--------------------------+             |
> +                       |                     |
> +                       |                     |
> +    +--------------------------------------------------+
> +            +------------------------------------------+
> +            |  +----------------+   +----------------+ |
> +Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> +            |  |  Registers     |   |                | |
> +            |  |                |   |                | |
> +            |  +----------------+   +----------------+ |
> +            |                                          |
> +            | Xilinx IPI Agent Block                   |
> +            +------------------------------------------+
> +
> +
> +Controller Device Node:
> +===========================
> +Required properties:
> +--------------------
> +- compatible:          Shall be: "xlnx,zynqmp-ipi-mailbox"
> +- reg:                 IPI buffers address ranges
> +- reg-names:           Names of the reg resources. It should have:
> +                       * local_request_region
> +                         - IPI request msg buffer written by local and read
> +                           by remote
> +                       * local_response_region
> +                         - IPI response msg buffer written by local and read
> +                           by remote
> +                       * remote_request_region
> +                         - IPI request msg buffer written by remote and read
> +                           by local
> +                       * remote_response_region
> +                         - IPI response msg buffer written by remote and read
> +                           by local
> +- #mbox-cells:         Shall be 1. It contains:
> +                       * tx(0) or rx(1) channel
> +- xlnx,ipi-ids:                Xilinx IPI agent IDs of the two peers of the
> +                       Xilinx IPI communication channel.
> +- interrupt-parent:    Phandle for the interrupt controller
> +- interrupts:          Interrupt information corresponding to the
> +                       interrupt-names property.
> +
> +Optional properties:
> +--------------------
> +- method:              The method of accessing the IPI agent registers.
> +                       Permitted values are: "smc" and "hvc". Default is
> +                       "smc".
> +
> +Example:
> +===========================
> +       /* APU<->RPU0 IPI mailbox controller */
> +       ipi_mailbox_rpu0: mailbox at ff90400 {
> +               compatible = "xlnx,zynqmp-ipi-mailbox";
> +               reg = <0x0 0xff990400 0x0 0x20>,
> +                     <0x0 0xff990420 0x0 0x20>,
> +                     <0x0 0xff990080 0x0 0x20>,
> +                     <0x0 0xff9900a0 0x0 0x20>;
> +               reg-names = "local_request_region", "local_response_region",
> +                           "remote_request_region", "remote_response_region";
> +               #mbox-cells = <1>;
> +               xlnx-ipi-ids = <0 1>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 29 4>;
> +       };
> +       /* APU<->RPU1 IPI mailbox controller */
> +       ipi_mailbox_rpu1: mailbox at ff990440 {
> +               compatible = "xlnx,zynqmp-ipi-mailbox";
> +               reg = <0x0 0xff990440 0x0 0x20>,
> +                     <0x0 0xff990460 0x0 0x20>,
> +                     <0x0 0xff990280 0x0 0x20>,
> +                     <0x0 0xff9902a0 0x0 0x20>;
> +               reg-names = "local_request_region", "local_response_region",
> +                           "remote_request_region", "remote_response_region";
> +               #mbox-cells = <1>;
> +               xlnx-ipi-ids = <0 2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 29 4>;
> +       };
The Xilinx IPI hardware one IPI agent contains multiple IPI mailboxes.
Please make ipi mailbox as subnodes to the IPI agent device node.
> +       rpu0 {
> +               ...
> +               mboxes = <&ipi_mailbox_rpu0 0>,
> +                        <&ipi_mailbox_rpu0 1>;
> +               mbox-names = "tx", "rx";
> +       };
> +       rpu1 {
> +               ...
> +               mboxes = <&ipi_mailbox_rpu1 0>,
> +                        <&ipi_mailbox_rpu1 1>;
> +               mbox-names = "tx", "rx";
> +       };
> --
> 2.7.4
>
