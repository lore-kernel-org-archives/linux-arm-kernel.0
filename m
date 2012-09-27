From: fwu@marvell.com (Fan Wu)
Date: Thu, 27 Sep 2012 02:19:49 -0700
Subject: [PATCH] ARM:CPUIDLE: Fix wrongly used idle control counter
In-Reply-To: <20120927085315.GA14358@n2100.arm.linux.org.uk>
References: <1348727761-16485-1-git-send-email-fwu@marvell.com>
 <20120927085315.GA14358@n2100.arm.linux.org.uk>
Message-ID: <BD54883EA7DE8B41A61B7E723561C711139F5FA938@sc-vexch3.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot for reviewing. 

So, you mean it is driver's responsibility to make sure the "disable and enable" function are paired before using it, which I think is NOT OK for current code. 

1. If we want different users have chance to sync about the counter, 
	I think we may try the following ways
		1). add one interface (like exported function) for other modules or driver to get the current counter value .
		2). add constraint in "enable and disable" function to avoid the possible situation that the counter is less/more than "0".
2. If we want the "nohlt" is OK for every driver and module without sync or similar operation,
	We may just remove "enable and disable" interface directly, which will cause the "nohlt" change will only be the init interface and cannot be changed any more after kernel bootup.

I have patches to try above possible ways. 
However, I still think my current way(My filed patch) is easier and better way? 

What's your suggestion ? 

Thanks a lot !


Best Regards.
Fan Wu(??)
Ext: 9853


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: 2012?9?27? 16:53
To: Fan Wu
Cc: Nicolas Pitre; Will Deacon; H Hartley Sweeten; Tony Lindgren; linux-arm-kernel at lists.infradead.org; Lu Mao; Ning Jiang
Subject: Re: [PATCH] ARM:CPUIDLE: Fix wrongly used idle control counter

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
