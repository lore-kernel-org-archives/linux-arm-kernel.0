From: jouko.haapaluoma@wapice.com (Jouko Haapaluoma)
Date: Mon, 27 Jan 2014 14:12:28 +0000
Subject: at_hdmac does not release lock before the callback - deadlock
In-Reply-To: <C9F8415089354E4FB76F4548B3515AF484286F61@edb1.wapice.localdomain>
References: <C9F8415089354E4FB76F4548B3515AF484286F61@edb1.wapice.localdomain>
Message-ID: <C9F8415089354E4FB76F4548B3515AF484286FB7@edb1.wapice.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After further investigation it seems that the deadlocks  would happen only when CONFIG_SMP is enabled or RT_PREEMPT patch is used. When CONFIG_SMP or RT_PREEMPT is not used, the spinlocks will only disable preemption which does not cause a deadlock. However, with the CONFIG_SMP or the RT_PREEMPT patch spinlocks are actual locks and deadlocks can occur.

This might explain why this problem hasn't been noticed before. At least the Atmel serial driver from linux4sam git causes deadlocks with the RT_PREEMPT because of this issue. 

BR,
Jouko Haapaluoma
