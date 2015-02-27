From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 26 Feb 2015 17:28:22 -0800
Subject: [PATCH v6 4/7] clk: Add clock driver for mb86s7x
In-Reply-To: <1423188649-17216-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1423188007-17047-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1423188649-17216-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <20150227012822.421.16727@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Vincent Yang (2015-02-05 18:10:49)
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
>  The CRG11 clock controller is managed by remote f/w.
> This driver simply maps Linux CLK ops onto mailbox api.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
> ---
>  .../bindings/clock/fujitsu,mb86s70-crg11.txt       |  26 ++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-mb86s7x.c                          | 386 +++++++++++++++++++++
>  3 files changed, 413 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
>  create mode 100644 drivers/clk/clk-mb86s7x.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt b/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
> new file mode 100644
> index 0000000..3323962
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
> @@ -0,0 +1,26 @@
> +Fujitsu CRG11 clock driver bindings
> +-----------------------------------
> +
> +Required properties :
> +- compatible : Shall contain "fujitsu,mb86s70-crg11"
> +- #clock-cells : Shall be 3 {cntrlr domain port}
> +
> +The consumer specifies the desired clock pointing to its phandle.
> +
> +Example:
> +
> +       clock: crg11 {
> +               compatible = "fujitsu,mb86s70-crg11";
> +               #clock-cells = <3>;
> +       };
> +
> +       mhu: mhu0 at 2b1f0000 {
> +               #mbox-cells = <1>;
> +               compatible = "arm,mhu";
> +               reg = <0 0x2B1F0000 0x1000>;
> +               interrupts = <0 36 4>, /* LP Non-Sec */
> +                            <0 35 4>, /* HP Non-Sec */
> +                            <0 37 4>; /* Secure */
> +               clocks = <&clock 0 2 1>; /* Cntrlr:0 Domain:2 Port:1 */

Some preprocessor definitions would be better than hardcoding the values
for Cntrlr, Domain and Port. The DT include chroot should help you
here. Doing so will help you maintain this stuff into the future :-)

Regards,
Mike
