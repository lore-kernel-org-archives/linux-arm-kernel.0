From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Nov 2014 16:00:15 +0100
Subject: [PATCH 4/7] pinctrl: zynq: Document DT binding
In-Reply-To: <1415041531-15520-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-5-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdazagbSZdMvHTggQuAFm9uObn2ARoCwcyM-sspuLTXqkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Add documentation for the devicetree binding for the Zynq pincontroller.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
(...)
> +Example:
> +       pinctrl0: pinctrl at 700 {
> +               compatible = "xlnx,pinctrl-zynq";
> +               reg = <0x700 0x200>;
> +               syscon = <&slcr>;
> +
> +               pinctrl_uart1_default: pinctrl-uart1-default {
> +                       common {
> +                               groups = "uart1_10_grp";
> +                               function = "uart1";
> +                               slew-rate = <0>;
> +                               io-standard = <1>;
> +                       };

I don't really like that you mix multiplexing and config in the
same node. I would prefer if the generic bindings say we have
muxing nodes and config nodes, and those are disparate.

Can't you just split this:

common-mux {
    groups = "uart1_10_grp";
    function = "uart1";
};

common-config {
    groups = "uart1_10_grp";
    slew-rate = <0>;
    io-standard = <1>;
};

That way we can identify nodes as mux nodes (have "function")
or config nodes (have "groups" or "pins" but not "function") which
I think makes things easier to read.

Yours,
Linus Walleij
