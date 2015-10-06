From: nikolay@cumulusnetworks.com (Nikolay Aleksandrov)
Date: Tue, 6 Oct 2015 21:28:29 +0200
Subject: [PATCH] bridge/netfilter: avoid unused label warning
In-Reply-To: <7985748.1v9Gzszd4T@wuerfel>
References: <7985748.1v9Gzszd4T@wuerfel>
Message-ID: <561420DD.70009@cumulusnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2015 09:22 PM, Arnd Bergmann wrote:
> With the ARM mini2440_defconfig, the bridge netfilter code gets
> built with both CONFIG_NF_DEFRAG_IPV4 and CONFIG_NF_DEFRAG_IPV6
> disabled, which leads to a harmless gcc warning:
> 
> net/bridge/br_netfilter_hooks.c: In function 'br_nf_dev_queue_xmit':
> net/bridge/br_netfilter_hooks.c:792:2: warning: label 'drop' defined but not used [-Wunused-label]
> 
> This gets rid of the warning by cleaning up the code to avoid
> the respective #ifdefs causing this problem, and replacing them
> with if(IS_ENABLED()) checks. I have verified that the resulting
> object code is unchanged, and an additional advantage is that
> we now get compile coverage of the unused functions in more
> configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: dd302b59bde0 ("netfilter: bridge: don't leak skb in error paths")
> 

I posted a fix for this a couple of days ago, but I like your approach better.
Since mine is not yet applied (I sent it to netfilter-devel only, wasn't sure which
jurisdiction this falls into exactly) we can drop it.
Just for reference my patch is here:
http://patchwork.ozlabs.org/patch/526417/
Pablo, could you please drop it ?

By the way this takes care of another warning about unused variable (nf_bridge), too.
So,

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
