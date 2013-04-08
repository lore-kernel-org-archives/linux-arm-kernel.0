From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Apr 2013 16:20:42 +0100
Subject: [PATCH] ARM: makefile: add tuning options for Armada 370/XP
In-Reply-To: <20130406192957.GQ11459@1wt.eu>
References: <20130406192957.GQ11459@1wt.eu>
Message-ID: <20130408152042.GM17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 06, 2013 at 09:29:57PM +0200, Willy Tarreau wrote:
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 15747d9..7dd5418 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -93,6 +93,7 @@ tune-$(CONFIG_CPU_XSC3)		:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -
>  tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
>  tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
>  tune-$(CONFIG_CPU_V6K)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
> +tune-$(CONFIG_MACH_ARMADA_370_XP)	:=$(call cc-option,-mcpu=marvell-pj4,-mtune=xscale)

Do not do this.  This is not how these options work.  Look at all the
above - they all use -mtune=.

The reason for this is that we want to control which instructions are
used (-march=) independently of how the instructions are scheduled
(-mtune=).

Using -mcpu= influences both of those in an adverse way - it can enable
instructions which are not present on other CPUs in the same kernel.

So, the use of -mcpu= is not permitted in the kernel.  Instead, use
-march= and -mtune= in an appropriate manner to achieve your goal.
