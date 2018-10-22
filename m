From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Oct 2018 11:19:51 -0400 (EDT)
Subject: [PATCH v3] ARM: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS
In-Reply-To: <20181022073426.24856-1-vincent.whitchurch@axis.com>
References: <20181022073426.24856-1-vincent.whitchurch@axis.com>
Message-ID: <nycvar.YSQ.7.76.1810221111220.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2018, Vincent Whitchurch wrote:

> ARMv6+ processors do not use CONFIG_CPU_USE_DOMAINS and use privileged
> ldr/str instructions in copy_{from/to}_user.  They are currently
> unnecessarily using single ldr/str instructions and can use ldm/stm
> instructions instead like memcpy does (but with appropriate fixup
> tables).
> 
> This speeds up a "dd if=foo of=bar bs=32k" on a tmpfs filesystem by
> about 4% on my Cortex-A9.
> 
> before:134217728 bytes (128.0MB) copied, 0.543848 seconds, 235.4MB/s
> before:134217728 bytes (128.0MB) copied, 0.538610 seconds, 237.6MB/s
> before:134217728 bytes (128.0MB) copied, 0.544356 seconds, 235.1MB/s
> before:134217728 bytes (128.0MB) copied, 0.544364 seconds, 235.1MB/s
> before:134217728 bytes (128.0MB) copied, 0.537130 seconds, 238.3MB/s
> before:134217728 bytes (128.0MB) copied, 0.533443 seconds, 240.0MB/s
> before:134217728 bytes (128.0MB) copied, 0.545691 seconds, 234.6MB/s
> before:134217728 bytes (128.0MB) copied, 0.534695 seconds, 239.4MB/s
> before:134217728 bytes (128.0MB) copied, 0.540561 seconds, 236.8MB/s
> before:134217728 bytes (128.0MB) copied, 0.541025 seconds, 236.6MB/s
> 
>  after:134217728 bytes (128.0MB) copied, 0.520445 seconds, 245.9MB/s
>  after:134217728 bytes (128.0MB) copied, 0.527846 seconds, 242.5MB/s
>  after:134217728 bytes (128.0MB) copied, 0.519510 seconds, 246.4MB/s
>  after:134217728 bytes (128.0MB) copied, 0.527231 seconds, 242.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.525030 seconds, 243.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.524236 seconds, 244.2MB/s
>  after:134217728 bytes (128.0MB) copied, 0.523659 seconds, 244.4MB/s
>  after:134217728 bytes (128.0MB) copied, 0.525018 seconds, 243.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.519249 seconds, 246.5MB/s
>  after:134217728 bytes (128.0MB) copied, 0.518527 seconds, 246.9MB/s
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v3: Explicitly add IT instructions to fix fault handling on Thumb-2

Sorry if this is starting to look like bikeshedding, but...

> +	.macro ldr1b ptr reg cond=al abort
> +	.ifnc	\cond, al
> +	it	\cond
> +	.endif
> +	USERL(\abort, ldr\cond\()b \reg, [\ptr], #1)
> +	.endm

You could simply factor out the ldr1b macro definition out of the 
CONFIG_CPU_USE_DOMAINS conditional to reuse the existing one which makes 
use of ldrusr where this it issue is already covered for you. The ldr1b 
and str1b don't actually need to be different.


Nicolas
