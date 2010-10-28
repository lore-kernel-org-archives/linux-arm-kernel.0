From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 28 Oct 2010 17:18:20 -0500
Subject: [PATCH 5/7] omap:mailbox-resolve multiple receiver problem
In-Reply-To: <1287108808-32119-6-git-send-email-h-kanigeri2@ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-6-git-send-email-h-kanigeri2@ti.com>
Message-ID: <4CC9F6AC.9030308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2010 9:13 PM, Kanigeri, Hari wrote:
> OMAP4 shares one interrupt line for all the mailbox instances.
> The ISR is handling only the mailbox instance that was registered last.

This shouldn't be needed, request_irq is being called with IRQF_SHARED 
flag and different device ids, so if a message arrives it fires an 
interrupt handler for each of the callers to request_irq and since the 
device id is actually a pointer to a mbox struct, the different users 
can be detected and signaled without looping through the "mboxes" list.

Also using "mboxes" list, will try to check for all registered mailboxes 
during probe, which might not be the same as the actual users (the ones 
that have called omap_mbox_get) and then unnecesary check their irq 
statuses if an interrupt arrives.

I think this patch can be dropped.

Regards,

Omar
