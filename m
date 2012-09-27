From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 09:53:15 +0100
Subject: [PATCH] ARM:CPUIDLE: Fix wrongly used idle control counter
In-Reply-To: <1348727761-16485-1-git-send-email-fwu@marvell.com>
References: <1348727761-16485-1-git-send-email-fwu@marvell.com>
Message-ID: <20120927085315.GA14358@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 02:36:01PM +0800, Fan Wu wrote:
> From: fwu <fwu@marvell.com>
> 
> 1. On ARM platform, "nohlt" can be used to prevent core from idle
>    process, returning immediately.
> 2. There are two interface, exported for other modules, named
>    disable_hlt and enable_hlt and used to enable/disable the
>    cpuidle mechanism by increasing/decreasing "hlt_counter".
>    So, the more "hlt_counter" is, the more user want to disable
>    cpuidle. Disable_hlt and enable_hlt are paired operation,
>    when you first call disable_hlt and then enable_hlt, the
>    semantics are right, but if you call enable_hlt and
>    then disable_hlt, it is wrong.
> 3. Change "hlt_counter > 0" can fix the problem.
>    The judgement whethere the cpuidle is disabled need to check
>    whether the "hlt_counter > 0" rather than "hlt_counter != 0".

NAK.  The bug is that you're calling enable_hlt() without first calling
disable_hlt().  That is something you _must_ _not_ do.

If the count starts off zero, and a driver calls disable_hlt(), another
driver _must_ _not_ override that by then calling enable_hlt().
