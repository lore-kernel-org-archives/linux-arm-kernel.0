From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 16 Oct 2012 11:18:15 +1100
Subject: [PATCH RFC 01/11 v4] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <1350343887-7344-2-git-send-email-stigge@antcom.de>
References: <1350343887-7344-1-git-send-email-stigge@antcom.de>
 <1350343887-7344-2-git-send-email-stigge@antcom.de>
Message-ID: <507CA7C7.6060405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/12 10:31, Roland Stigge wrote:
> The recurring task of providing simultaneous access to GPIO lines (especially
> for bit banging protocols) needs an appropriate API.
> 
> This patch adds a kernel internal "Block GPIO" API that enables simultaneous
> access to several GPIOs. This is done by abstracting GPIOs to an n-bit word:
> Once requested, it provides access to a group of GPIOs which can range over
> multiple GPIO chips.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> ---

<snip>

> +This creates a new block of GPIOs as a list of GPIO numbers with the specified
> +size which are accessible via the returned struct gpio_block and the accessor
> +functions described below. Please note that you need to request the GPIOs
> +separately via gpio_request(). An arbitrary list of globally valid GPIOs can be
> +specified, even ranging over several gpio_chips. Actual handling of I/O
> +operations will be done on a best effort base, i.e. simultaneous I/O only where
> +possible by hardware and implemented in the respective GPIO driver. The number
> +of GPIOs in one block is limited to 32 on a 32 bit system, and 64 on a 64 bit
> +system. However, several blocks can be defined at once.

This should probably say that the number of gpios in a block is limited
to sizeof(unsigned long) or BITS_PER_LONG. I think sizeof(unsigned long)
== 8 on some 32 bit architectures.

~Ryan
