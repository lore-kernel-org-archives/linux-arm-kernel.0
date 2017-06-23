From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 14:32:51 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#2)
In-Reply-To: <877f041a4p.fsf@free-electrons.com>
References: <877f041a4p.fsf@free-electrons.com>
Message-ID: <CAK8P3a3UuLFVxZv1o1+gKSafsGgV=vgWRM_yjnT_E4fAUPZx8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 2:26 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi,
>
> Here is the second pull request for dt64 for mvebu for v4.13.
>
> This came only now because I waited for that the drivers part was
> accepted. Now that is was done we can enable the last missing part of
> the infrastructure for the Aramda 7K/8K SoCs.

Pulled into next/dt64, thanks!

> Also note that there is a trivial merge conflict with the mvebu-fixes
> branch. In case of doubt it was resolved in the last merge commit of
> the mvebu/for-next branch.

Thanks, that helped, my initial merge ended up with a typo.

However, while doing the merge, I stumbled over an obviously
broken commit:


commit b1a97f86b7359da7bbd7a8dd2900d62352c04644
Author: Antoine Tenart <antoine.tenart@free-electrons.com>
Date:   Wed May 24 16:10:33 2017 +0200

    arm64: dts: marvell: add dma-mask in crypto nodes for 7k/8k

    The EIP197 cryptographic engine supports 64 bits address width but is
    limited to 40 bits on 7k/8k. Add a dma-mask property in the
    cryptographic engine nodes to reflect this.

    Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 576e825585c9..e02ac90f7fdf 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -242,6 +242,7 @@
                                interrupt-names = "mem", "ring0", "ring1",
                                "ring2", "ring3", "eip";
                                clocks = <&cpm_syscon0 1 26>;
+                               dma-mask = <0xff 0xffffffff>;
                                status = "disabled";
                        };
                };
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 797208a11f9d..7468fe00fc37 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -232,6 +232,7 @@
                                interrupt-names = "mem", "ring0", "ring1",
                                                  "ring2", "ring3", "eip";
                                clocks = <&cps_syscon0 1 26>;
+                               dma-mask = <0xff 0xffffffff>;
                                status = "disabled";
                        };
                };


Please send a revert for that, and remove the code that tries to
parse the dma-mask from DT from that driver!

       Arnd
