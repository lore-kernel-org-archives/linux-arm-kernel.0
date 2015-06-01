From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Mon, 1 Jun 2015 02:20:08 +0200
Subject: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
In-Reply-To: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the late response, I only just noticed this since I wasn't CC'd.

This "fix" was not ever Reported-By or Tested-By me as it claims. It
is in fact wrong: &rtc { system-power-controller; } needs to be
present for every variety of beaglebone (more generally every design
with a TPS65217 whose PWR_EN is connected to the PMIC_POWER_EN pin of
an AM335x).

Without a system-power-controller, the kernel has no way of turning
off the system and shutdown will leave the system halted instead.

The previously posted fix, which added  &tps {
ti,pmic-shutdown-controller; }  was correct, and ensures that a
poweroff makes the pmic enter "OFF-state" rather than "SLEEP-state"
(aka RTC-only sleep).

Matthijs
