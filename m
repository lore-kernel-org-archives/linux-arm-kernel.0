From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Jan 2013 20:59:31 +0100
Subject: [PATCH 2/2] pinctrl: nomadik: Allow prcm_base to be extracted
 from Device Tree
In-Reply-To: <1357919129-1928-2-git-send-email-lee.jones@linaro.org>
References: <1357919129-1928-1-git-send-email-lee.jones@linaro.org>
 <1357919129-1928-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbRosdAOeGo7W=05kC5H4OLbxNUjZydcpLc0OZVcZj+Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 4:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Nomadik Pinctrl driver requires access to some PRCMU registers
> in order to run with full functionality. When Device Tree is
> disabled the required PRCMU base address is passed in via platform
> data, so in order for Device Tree booting to be as functional, we
> need a similar mechanism to fetch it from Device Tree.
>
> The new semantics goes like this: Parse the Device Tree and look
> for the PRCMU node using a provided Phandle. Obtain the ioremaped
> address from that node. If one was supplied via platform data
> over-write it with anything found in Device Tree. Fail if either
> the prcm_base can't be found if we're running on anything other
> than an STN8815 ASIC.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied as well, notice I had to add this hunk to the first
patch to have things working:

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 05d97f6..96f518b 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -192,6 +192,7 @@
                prcmu: prcmu at 80157000 {
                        compatible = "stericsson,db8500-prcmu";
                        reg = <0x80157000 0x1000>;
+                       reg-names = "prcmu";
                        interrupts = <0 47 0x4>;
                        #address-cells = <1>;
                        #size-cells = <1>;

Lest the code won't find the prcmu registers.

Yours,
Linus Walleij
