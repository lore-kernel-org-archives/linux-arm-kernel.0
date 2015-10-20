From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 20 Oct 2015 17:11:00 +0800
Subject: [PATCH 0/4] 
Message-ID: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
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

Tested on box board.



Caesar Wang (4):
  dt-bindings: Sync the dts to this document
  thermal: rockchip: ensure the otp state before resetting the
    controller
  thermal: rockchip: change the TSHUT default state
  ARM: dts: rockchip: Add the OTP gpio pinctrl

 .../bindings/thermal/rockchip-thermal.txt          |  5 ++--
 arch/arm/boot/dts/rk3288.dtsi                      |  9 ++++--
 drivers/thermal/rockchip_thermal.c                 | 34 +++++++++++++++++++++-
 3 files changed, 43 insertions(+), 5 deletions(-)

-- 
1.9.1
