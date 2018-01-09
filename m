From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 9 Jan 2018 13:30:18 +0530
Subject: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1515109891-17133-3-git-send-email-jliang@xilinx.com>
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
 <1515109891-17133-3-git-send-email-jliang@xilinx.com>
Message-ID: <CABb+yY00n6fLiQXftj-TMhT6q=KopZMkLYr6DpYE8CvxH-gz8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 5, 2018 at 5:21 AM, Wendy Liang <wendy.liang@xilinx.com> wrote:
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
>
shmem is option and external to the controller. It should be passed
via client's binding.
Please have a look at Sudeep's proposed patch
https://www.spinics.net/lists/arm-kernel/msg626120.html

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
Andre almost implemented the generic driver. Can you please have a
look at https://www.spinics.net/lists/arm-kernel/msg595416.html
and see if you can just finish it off?

Thanks
