From: jouko.haapaluoma@wapice.com (Jouko Haapaluoma)
Date: Fri, 31 Jan 2014 10:56:25 +0000
Subject: [RFC PATCH 0/2] dmaengine: at_hdmac: fix locking according to
 slave DMA requirements
In-Reply-To: <cover.1390832343.git.nicolas.ferre@atmel.com>
References: <C9F8415089354E4FB76F4548B3515AF484286F61@edb1.wapice.localdomain>
 <cover.1390832343.git.nicolas.ferre@atmel.com>
Message-ID: <C9F8415089354E4FB76F4548B3515AF484289B2A@edb1.wapice.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Thanks for the patches. We got the DMA working for now but the tasklet_disable() and tasklet_enable() had to be removed from atc_control().

If the device driver calls dmaengine_terminate_all() from the callback (like in our previous deadlock example), the tasklet_disable() will cause
another deadlock because the tasklet will then wait for itself to close.

The tasklet_disable() seems to be used to ensure that no tasklet is running when terminating the DMA transfers. This prevents the terminate_all from
happening in between the critical sections in the tasklet which are locked with atchan->lock. Maybe the tasklet needs to be implemented so that it can
detect and recover if the terminate_all was called in between the critical sections in the tasklet?

BR,
Jouko Haapaluoma
