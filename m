From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Mon, 15 Feb 2016 19:14:36 +0100
Subject: [PATCH] netfilter: tee: select NF_DUP_IPV6 unconditionally
In-Reply-To: <1454664040-1344109-1-git-send-email-arnd@arndb.de>
References: <1454664040-1344109-1-git-send-email-arnd@arndb.de>
Message-ID: <20160215181436.GA3462@salvia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 10:20:21AM +0100, Arnd Bergmann wrote:
> The NETFILTER_XT_TARGET_TEE option selects NF_DUP_IPV6 whenever
> IP6_NF_IPTABLES is enabled, and it ensures that it cannot be
> builtin itself if NF_CONNTRACK is a loadable module, as that
> is a dependency for NF_DUP_IPV6.
> 
> However, NF_DUP_IPV6 can be enabled even if IP6_NF_IPTABLES is
> turned off, and it only really depends on IPV6. With the current
> check in tee_tg6, we call nf_dup_ipv6() whenever NF_DUP_IPV6
> is enabled. This can however be a loadable module which is
> unreachable from a built-in xt_TEE:
> 
> net/built-in.o: In function `tee_tg6':
> :(.text+0x67728): undefined reference to `nf_dup_ipv6'
> 
> The bug was originally introduced in the split of the xt_TEE module
> into separate modules for ipv4 and ipv6, and two patches tried
> to fix it unsuccessfully afterwards.
> 
> This is a revert of the the first incorrect attempt to fix it,
> going back to depending on IPV6 as the dependency, and we
> adapt the 'select' condition accordingly.

Applied, thanks Arnd.
