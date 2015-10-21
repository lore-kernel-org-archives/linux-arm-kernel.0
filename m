From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 21 Oct 2015 10:42:58 +0800
Subject: [PATCH v1 0/2] fix the TSHUT issue on rockchip thermal
Message-ID: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

Says:
The TSHUT temperature is setting more than 80 degree, the default
tshut polarity is HIGH.

If T > 80C, the OTP output the High Signal.
If T < 80C, the OTP output the Low Signal.

On the moment, the TSADC controller is reset, the tshut polarity will be
Low in a short period of time.

So:
If T < 80C, the OTP output the High Signal.
If T > 80C, the OTP output the Low Signal.

In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
accept the reset response time to avoid this issue.

In other words, the system will be always reboot if we make the OTP pin
is connected the others IC to control the power.

This series patchs are depend on Doug's patch.(https://patchwork.kernel.org/patch/7454081/)

This series patchs are based on the Linus master branch.

c51a571 ARM: dts: rockchip: Add the OTP gpio pinctrl
e1ecae4 dt-bindings: Sync the dts to this document
150426c drivers/pinctrl: Add the concept of an "init" state
ce1fad2 Merge branch 'keys-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
1099f86 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
911b79c KEYS: Don't permit request_key() to construct a new keyring
37850e3 net: bcmgenet: Fix early link interrupt enabling
afc050d Merge tag 'wireless-drivers-for-davem-2015-10-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers
e277de5 tunnels: Don't require remote endpoint or ID during creation.
740dbc2 openvswitch: Scrub skb between namespaces
....

Tested on box board.


Changes in v1:
  - As the Doug comments, add the 'init' property to sync document.
  - As the Doug comments, drop the thermal driver patchs since
    we can with pinctrl changing to work.
  - As the Doug's patch to add the 'init' property.

Caesar Wang (2):
  dt-bindings: Sync the dts to this document
  ARM: dts: rockchip: Add the OTP gpio pinctrl

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
 arch/arm/boot/dts/rk3288.dtsi                                  | 9 +++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
1.9.1
