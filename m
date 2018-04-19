From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 Apr 2018 11:10:50 +0200
Subject: [PATCH v5 2/6] dt-bindings: reset: renesas, rzn1-reboot: document
 RZ/N1 reboot driver
In-Reply-To: <1523963101-56725-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523963101-56725-3-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdU0rR9xcQtuoHXywv_7qpwRsPRyh8+AtHAoyY29BkiHHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Tue, Apr 17, 2018 at 1:04 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> as part of the sysctrl MFD to handle rebooting the CA7 cores.
> This documents the driver bindings.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  .../devicetree/bindings/power/renesas,rzn1-reboot.txt   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
>
> diff --git a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> new file mode 100644
> index 0000000..a553864
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> @@ -0,0 +1,17 @@
> +DT bindings for the Renesas RZ/N1 Reboot Driver
> +
> +== Reboot Driver Node ==
> +
> +The reboot driver allows restarting the RZ/N1.
> +
> +Bindings:
> ++ Required:
> +       compatible = "renesas,r9a06g032-reboot", "renesas,rzn1-reboot";
> +
> +Example:
> +       reboot at 4000c120 {
> +               compatible = "renesas,r9a06g032-reboot",
> +                               "renesas,rzn1-reboot";
> +               reg = <0x4000c120 4>,
> +                       <0x4000c198 4>;
> +       };

I'm afraid this will become a messy DT structure, once device nodes for the
registers just before, between, and after these 2 registers will be added...

There's really only a single multi-function sysctrl device here, using a 4 KiB
block at 0x4000c000, containing a mix of:
  1. Clock Control Registers (Table 6.1 [*]),
  2. Reset Control (Table 6.2 [*]),
  3. System Configuration (Table 6.3 [*]).

Looks a lot like the mix used in the Amiga's custom chip block at 0xdff000,
which also cannot be separated into logical blocks without listing individual
registers ;-)

So I suggest to have a DT binding for the whole block, and a clock driver
matching against the whole block, registering all clocks and a small reset
controller driver.

[*] RZ/N1D Group, RZ/N1S Group, RZ/N1L Group User?s Manual: System
    Introduction, Multiplexing, Electrical and Mechanical Information.
    https://www.renesas.com/en-eu/doc/products/mpumcu/doc/rz/r01uh0750ej0090-rzn1-introduction.pdf

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
