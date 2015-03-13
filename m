From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 16:40:06 +0000
Subject: [PATCH v2 3/8] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <1426248452-4773-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150313164005.GU8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 01:07:27PM +0100, Ard Biesheuvel wrote:
> +	.macro	bl_abs, target, c=
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> +	movt\c	lr, #:upper16:\target
> +	movw\c	lr, #:lower16:\target
> +	blx\c	lr

So I've looked this up, and it's valid, which is surprising because BLX
itself writes to LR - the read from LR must happen before BLX itself
writes to LR.  Thankfully, because of the pipelining, this is probably
guaranteed.

I wonder whether there will be any errata on this... maybe on non-ARM
CPUs?  It'll be interesting to find out what happens once we merge
this... :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
