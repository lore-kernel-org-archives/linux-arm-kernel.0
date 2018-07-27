From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Fri, 27 Jul 2018 14:23:26 -0700
Subject: [PATCH v2 0/7] Add clock config and pm support to bcm iProc mdio mux
Message-ID: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The patchset is based on David Miller's "net-next" repo.

The patchset extends the Broadcom iProc mdio mux to add support for
suspend/resume and the ability to configure the internal clock
divider. The patchset also sets the scan control register to
disable external master access.

The base address of the mdio-mux-bcm-iproc is modified to point to the
start of the mdio block's address space, to be able to access all the
mdio's registers. The missing registers are required to configure the
internal clock divider registers in some of the Broadcom SoC's.

Changes from v1:
 - Addressed Andrew's comments.
   - Reworked the patches to be based on 'net-next'
   - Removed 'fixes' from the commit messages, the changes are related
     to the new features being added.
   - Maintained backward compatibility to older dt-blob's specifying
     base addresse with an offset. The correction is applied in the
     driver and a message is printed to update the dt-blob.
   - Re-worked and re-ordered the last four patches (4-7).
     - Added setting of the scan control register as a new patch
     - Added a call to 'clk_prepare_enable()' in the patch that adds
       the clock config support, removed the debug message when clock
       is not passed.
     - Simplified the pm support patch (removed the array used for the
       save/restore logic).

Thanks
Arun

Arun Parameswaran (7):
  dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
  net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
  arm64: dts: Fix the base address of the Broadcom iProc mdio mux
  net: phy: Disable external master access in bcm mdio mux driver
  dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
  net: phy: Add support to configure clock in Broadcom iProc mdio mux
  net: phy: Add pm support to Broadcom iProc mdio mux driver

 .../bindings/net/brcm,mdio-mux-iproc.txt           |   7 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   4 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 109 +++++++++++++++++++--
 4 files changed, 109 insertions(+), 15 deletions(-)

-- 
1.9.1
