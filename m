From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue, 15 Oct 2013 18:49:55 +0530
Subject: [PATCH V2 0/7] USB: OHCI:Properly handle ohci_suspend()routine in bus
 glue
In-Reply-To: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1381843202-28707-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Majunath Goudar <manju.goudar@lge.com>

Suspend scenario in case of ohci bus glue was not properly handled as
it was not suspending generic part of ohci controller. Alan Stern suggested,
properly handle ohci suspend scenario.

Calling explicitly the ohci_suspend()routine will ensure proper handling
of suspend scenario.

V1->V2:
       -This version is fixing the ohci-ep93xx build error reported by Olof Johansson:

        drivers/usb/host/ohci-ep93xx.c: In function 'ohci_hcd_ep93xx_drv_suspend':
        drivers/usb/host/ohci-ep93xx.c:126:2: error: implicit declaration of
        function 'ep93xx_stop_hc'
      
        Due to the build failure on  "[PATCH 5/11] USB: OHCI: Properly handle 
        ohci-ep93xx suspend" following patches were reverted.
        [PATCH 1/11]USB: OHCI: Properly handle OHCI controller suspend
        [PATCH 2/11] USB: OHCI: Properly handle ohci-at91 suspend
        [PATCH 3/11] USB: OHCI: Properly handle ohci-s3c2410 suspend
        [PATCH 4/11] USB: OHCI: Properly handle ohci-da8xx suspend
        [PATCH 5/11] USB: OHCI: Properly handle ohci-ep93xx suspend  
        [PATCH 6/11] USB: OHCI: Properly handle ohci-exynos suspend
        [PATCH 11/11] USB: OHCI: Properly handle ohci-spear suspend
   
        The following 4 patches are fine and present in usb-next
        Commit id "10abfa13"[PATCH 7/11] Properly handle ohci-omap suspend.
        Commit id "39dbd7df"[PATCH 8/11] Properly handle ohci-platform suspend.
        Commit id "4ceaa893"[PATCH 9/11] Properly handle ohci-pxa suspend.
        Commit id "f3c60599"[PATCH 10/11] Properly handle ohci-sm501 suspend.
    
        This patch set is working properly.  
 
Majunath Goudar (1):
  USB: OHCI: Properly handle ohci-ep93xx suspend

Manjunath Goudar (6):
  USB: OHCI: Properly handle OHCI controller suspend
  USB: OHCI: Properly handle ohci-at91 suspend
  USB: OHCI: Properly handle ohci-s3c2410 suspend
  USB: OHCI: Properly handle ohci-da8xx suspend
  USB: OHCI: Properly handle ohci-exynos suspend
  USB: OHCI: Properly handle ohci-spear suspend

 drivers/usb/host/ohci-at91.c    |   10 ++++++++--
 drivers/usb/host/ohci-da8xx.c   |   15 +++++++++++----
 drivers/usb/host/ohci-ep93xx.c  |    7 +++++--
 drivers/usb/host/ohci-exynos.c  |   20 +++++---------------
 drivers/usb/host/ohci-hcd.c     |    9 ++++++++-
 drivers/usb/host/ohci-s3c2410.c |   21 ++++-----------------
 drivers/usb/host/ohci-spear.c   |   12 +++++++++---
 7 files changed, 50 insertions(+), 44 deletions(-)

-- 
1.7.9.5
