From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Nov 2017 10:42:06 +0000
Subject: [RESEND PATCH] ARM: Fix csum_partial_copy_from_user() stack
 mismatch
In-Reply-To: <20171128025552.24927-1-chunyan.zhang@spreadtrum.com>
References: <20171128025552.24927-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171129104205.GA12900@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the late response, _all_ your messages are going into my junk
mailboxes because your mail server DNS is incorrectly configured.

$ host 222.66.158.135
135.158.66.222.in-addr.arpa domain name pointer sci-ig2.spreadtrum.com.
$ host sci-ig2.spreadtrum.com
sci-ig2.spreadtrum.com is an alias for ig.f5.spreadtrum.com.
ig.f5.spreadtrum.com has address 114.30.40.213

This makes it look like 222.66.158.135 is not authoritively a
spreadtrum.com server - anyone can place a reverse DNS entry pointing
to any domain on the planet.  The thing that makes reverse DNS
believable is when the forward DNS resolves back to the IP address.
It's a tactic spammers have used to try and get their messages through.

It gets worse...

$ host 114.30.40.213
213.40.30.114.in-addr.arpa domain name pointer sci-ig4.spreadtrum.com.
$ host sci-ig4.spreadtrum.com.
sci-ig4.spreadtrum.com has address 61.155.194.126
$ host 61.155.194.126
Host 126.194.155.61.in-addr.arpa. not found: 3(NXDOMAIN)

And according to whois:
inetnum:        222.66.158.128 - 222.66.158.143
descr:          SPREADTRUM COMMUNICATIONS (SHANGHAI) CO., LTD.
country:        CN

inetnum:        114.30.32.0 - 114.30.47.255
country:        TW

inetnum:        61.155.0.0 - 61.155.255.255
descr:          CHINANET jiangsu province network

Your messages will continue going into my junk folders until the DNS
is resolved, which means it'll take considerable time for me to
discover your messages.


On Tue, Nov 28, 2017 at 10:55:52AM +0800, Chunyan Zhang wrote:
> From: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>
> 
> An additional 'ip' will be pushed to the stack, for restoring the
> DACR later, if CONFIG_CPU_SW_DOMAIN_PAN defined.
> 
> However, the fixup still get the err_ptr by add #8*4 to sp, which
> results in the fact that the code area pointed by the LR will be
> overwritten, or the kernel will crash if CONFIG_DEBUG_RODATA is enabled.
> 
> This patch fixes the stack mismatch.
> 
> Signed-off-by: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm/lib/csumpartialcopyuser.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
> index 1712f13..b83fdc0 100644
> --- a/arch/arm/lib/csumpartialcopyuser.S
> +++ b/arch/arm/lib/csumpartialcopyuser.S
> @@ -85,7 +85,11 @@
>  		.pushsection .text.fixup,"ax"
>  		.align	4
>  9001:		mov	r4, #-EFAULT
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +		ldr	r5, [sp, #9*4]		@ *err_ptr
> +#else
>  		ldr	r5, [sp, #8*4]		@ *err_ptr
> +#endif
>  		str	r4, [r5]
>  		ldmia	sp, {r1, r2}		@ retrieve dst, len
>  		add	r2, r2, r1

Yes, the patch looks correct.  Please queue it with the patch system
(see URL below).  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
