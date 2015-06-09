From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  9 Jun 2015 17:49:56 +0800
Subject: [PATCH v6 0/3] ARM: rockchip: fix the SMP
Message-ID: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Verified on url =
    https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14
Tested by 179200 cycles are pass with CPU up/dowm test scripts.

Changes in v6:
- As Russell suggestion, detect whether of_reset_control_get() failed
- add the comment for 1ms delay.
Series-changes: 5
- back to v2 cpu on/off flow, As Heiko point out in patch v3.
- delay more time in rockchip_boot_secondary().
  From CPU up/down tests, Needed more time to complete CPU process.
  In order to ensure a more, Here that be delayed 1ms.
Series-changes: 4
- Add reset_control_put(rstc) for the non-error case.
Series-changes: 3
- FIx the PATCH v2, it doesn't work on chromium 3.14.
Series-changes: 2
- As Heiko suggestion, re-adjust the cpu on/off flow.
  CPU off:
    reset_control_assert
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))
    wait_for_power_domain_to_turn_off
  CPU on:
    regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
    wait_for_power_domain_to_turn_on
    reset_control_deassert
- Fix the delay 1ms describing.
Series-changes: 5
- Fix the patch decription.
- Add the changelog.
Series-changes: 2
- As Kever points out, Fix the subject typo WFI/WFE.
- fix the commnet Unified format.
Series-changes: 5
- Add the changelog.
Series-changes: 2
- Use the checkpatch.pl -f --subjective to check.

Caesar Wang (3):
  ARM: rockchip: fix the CPU soft reset
  ARM: rockchip: ensure CPU to enter WFI/WFE state
  ARM: rockchip: fix the SMP code style

 arch/arm/mach-rockchip/platsmp.c | 58 ++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

-- 
1.9.1
