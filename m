From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jun 2014 11:10:21 +0100
Subject: [PATCH] ARM: debug: fix broken DEBUG_LL_INCLUDE for multi platform
In-Reply-To: <1402394236-14778-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1402394236-14778-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20140610101021.GX23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 10:57:16AM +0100, Srinivas Kandagatla wrote:
> On multi_v7_defconfig using def_bool in Kconfig can override the selection
> made as part of DEBUG_LL. This is because def_bool will set the config to true
> if the expression evaluates to true, which is what was happening in
> multi_v7_defconfig. ARCH_SPEAR13XX selects DEBUG_UART_PL01X overiding any
> previous DEBUG_LL selections.
> 
> Making the def_bool to bool and depends made sense in this case, and
> fixes the issue too.

NAK.

1. you haven't tested this - if you select DEBUG_BCM2835 in the choice,
   it will select DEBUG_UART_PL01X, which, with your patch, will not
   have its new dependencies satisfied.

2. there is nothing to select this debug option on the platforms which
   you make it depend upon.

The real solution here is to convert these (and the other) remaining
platforms to the choice mechanism.  Same for the 8250 one.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
