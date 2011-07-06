From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 14:48:06 +0100
Subject: [PATCH V2 3/6] mpcore_wdt: Fix WDIOC_SETOPTIONS handling
In-Reply-To: <1309892440-3260-4-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-4-git-send-email-vkuzmichev@mvista.com>
Message-ID: <20110706134806.GA8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:00:37PM +0400, Vitaly Kuzmichev wrote:
> According to the include/linux/watchdog.h WDIOC_SETOPTIONS is
> classified as 'read from device' ioctl call:
>   #define WDIOC_SETOPTIONS        _IOR(WATCHDOG_IOCTL_BASE, 4, int)
> 
> However, the driver 'mpcore_wdt' performs 'copy_from_user' only if
> _IOC_WRITE is set, thus the local variable 'uarg' which is used in
> WDIOC_SETOPTIONS handling remains uninitialized.
> 
> The proper way to fix this is to bind WDIOC_SETOPTIONS to _IOW,
> but this will break compatibility.
> So adding additional condition for performing 'copy_from_user'.

That looks like something which needs fixing in watchdog land.  And it's
not too difficult:

1. Change the existing WDIOC_SETOPTIONS to WDIOC_SETOPTIONS_OLD
2. Add a new, correctly defined WDIOC_SETOPTIONS.
3. Update all drivers to use WDIOC_SETOPTIONS.
4. Provide a helper which deals with WDIOC_SETOPTIONS_OLD and translates
   it to the proper WDIOC_SETOPTIONS call (this could be just:

	if (cmd == WDIOC_SETOPTIONS_OLD) {
		static int first = 1;
		if (first)
			pr_warn("%s:%d used old WDIOC_SETOPTIONS call.  Please rebuild\n",
				current->comm, current->pid);
		first = 0;
		cmd = WDIOC_SETOPTIONS;
	}

   before any argument copies.

This means you preserve existing compatibility with userspace, yet gain
a path to a non-broken ioctl interface.

As stuff gets rebuilt and replaced, you'll eventually be able to remove
the above.  That period used to be two years for such simple changes.
