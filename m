From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 2 Mar 2016 03:09:41 +0000
Subject: [PATCH] Change the spin_lock/unlock_irq interface in
 proc_alloc_inum() function
In-Reply-To: <1456886879-28128-1-git-send-email-majun258@huawei.com>
References: <1456886879-28128-1-git-send-email-majun258@huawei.com>
Message-ID: <20160302030941.GH17997@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 10:47:59AM +0800, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> The spin_lock/unlock_irq interface is not safe when this function is called
> at some case which need irq disabled.

> For example:
> 	spin_lock_irqsave()
> 	|
> 	request_irq() --> proc_alloc_inum()
> 	|
> 	spin_unlock_irqrestore()

Do you even read your own patch?

>  	if (!ida_pre_get(&proc_inum_ida, GFP_KERNEL))
					 ^^^^^^^^^^
					 This.

It can block.  You *can't* call that under spin_lock_irqsave().  At all.
You also can't do request_irq() under a spinlock, no matter whether you
disable irqs or not - it also blocks.  So does proc_mkdir(), for that
matter, and not only in proc_alloc_inum().

NAKed.  Don't do it.  request_irq() is not to be called under spinlocks,
with or without irqs disabled.
