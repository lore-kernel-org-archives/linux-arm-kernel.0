From: swboyd@chromium.org (Stephen Boyd)
Date: Fri, 23 Mar 2018 09:34:48 -0700
Subject: [PATCH v4 0/5] Support qcom pinctrl protected pins
Message-ID: <20180323163453.96495-1-swboyd@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset proposes a solution to describing the valid                                                                           
pins for a pin controller in a generic way so that qcom                                                                        
platforms can expose the pins that are really available.                                                                            
                                                                                                                                    
Typically, this has been done by having drivers and firmware                                                                        
descriptions only use pins they know they have access to, and that                                                                  
still works now because we no longer read the pin direction at                                                                      
boot. But there are still some userspace drivers and debugfs facilities                                                             
that don't know what pins are available and attempt to read everything                                                              
they can. On qcom platforms, this may lead to a system hang, which isn't                                                            
very nice behavior, even if root is the only user that can trigger it.                                                              
                                                                                                                                    
The proposal is to describe the valid pins and then not allow things to                                                             
cause problems by using the invalid pins. Obviously, the firmware may                                                               
mess this up, so this is mostly a nice to have feature or a safety net                                                              
so that things don't blow up easily.                                                                                                

Changes from v3:
 * Split out allocation of mask into subroutine
 * Moved that allocation to kmalloc_array()
 * Updated qcom driver to simplifiy ACPI logic and fix mem leak

Changes from v2:
 * Renamed binding to 'gpio-reserved-ranges'
 * Reworked gpiolib patch to not use irqdomains
 * Update qcom driver patch to use new valid_mask field
                                                                                                                                    
Changes from v1:                                                                                                                    
 * Pushed into gpiolib-of core under irq valid line logic                                                                           
 * Fixed up qcom driver patch to free stuff properly and remove custom code                                                         
 * Dropped export patch as it got picked up                                                                                         
 * Renamed binding to 'reserved-gpio-ranges'   


Stephen Boyd (5):
  dt-bindings: gpio: Add a gpio-reserved-ranges property
  gpiolib: Extract mask allocation into subroutine
  gpiolib: Change bitmap allocation to kmalloc_array
  gpiolib: Support 'gpio-reserved-ranges' property
  pinctrl: qcom: Don't allow protected pins to be requested

 .../devicetree/bindings/gpio/gpio.txt         |  7 +-
 drivers/gpio/gpiolib-of.c                     | 24 +++++++
 drivers/gpio/gpiolib.c                        | 66 +++++++++++++++++--
 drivers/pinctrl/qcom/pinctrl-msm.c            | 65 +++++++++++++++++-
 include/linux/gpio/driver.h                   | 16 +++++
 5 files changed, 167 insertions(+), 11 deletions(-)

-- 
Sent by a computer through tubes
