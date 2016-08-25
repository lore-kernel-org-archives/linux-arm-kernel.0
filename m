From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Aug 2016 23:46:32 +0100
Subject: [PATCH] arm: sys_oabi-compat: Use kmalloc_array() in two functions
In-Reply-To: <5deba521-2dd4-cd2e-23d7-226a1a7728c3@users.sourceforge.net>
References: <5deba521-2dd4-cd2e-23d7-226a1a7728c3@users.sourceforge.net>
Message-ID: <20160825224632.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 05:50:36PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 25 Aug 2016 17:45:23 +0200
> 
> Multiplications for the size determination of memory allocations
> indicated that array data structures should be processed.

I'm afraid the above comment doesn't mean much to me, can you rephrase?
Maybe:

"Multiplications for kmalloc size arguments are liable to overflow,
potentially causing a potential security issue.  Using kmalloc_array()
allows the overflow to be caught and the allocation failed.  Switch
these callsites to kmalloc_array()."

> Thus use the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/arm/kernel/sys_oabi-compat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
> index 5f221ac..e624db9 100644
> --- a/arch/arm/kernel/sys_oabi-compat.c
> +++ b/arch/arm/kernel/sys_oabi-compat.c
> @@ -285,7 +285,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
>  		return -EINVAL;
>  	if (!access_ok(VERIFY_WRITE, events, sizeof(*events) * maxevents))
>  		return -EFAULT;
> -	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL);
> +	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);

kmalloc_array() here actually buys us no additional safety at either
of the callsites in your patch - we need to have carefully checked
the values to ensure they don't overflow prior to the kmalloc for
other reasons.  That's probably something that should be noted in
the commit message too, so reviewers have the confidence that you're
not blindly changing everything...

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
