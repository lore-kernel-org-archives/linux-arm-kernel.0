From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 23:56:16 -0600
Subject: [PATCH] ARM: PL011: add support for extended FIFO-size of
 PL011-r1p5
In-Reply-To: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
Message-ID: <5191D200.3040604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 03:18 AM, Jongsung Kim wrote:
> The latest r1p5-revision of the ARM PL011 UART has 32-byte FIFOs, while all
> earlier ones have 16-byte FIFOs. This patch suggests a way to set the
> FIFO-size correctly & flexibly by using a
> function(vendor_data::get_fifosize) rather than using the
> vendor_data::fifosize variable. The function takes the UARTPeriphID, and
> returns the correct size.

This change (now part of 3.10-rc1) breaks the serial port on the BCM2835
ARM SoC (part of the Raspberry Pi). Sorry for not noticing this earlier;
a combination of my vacation and laziness I guess.

For reference, the AMBA periphid of the UART device there is 0x00341011.
The nibble "3" is the revision being tested in:

> +static unsigned int get_fifosize_arm(unsigned int periphid)
> +{
> +	unsigned int rev = (periphid >> 20) & 0xf;
> +	return rev < 3 ? 16 : 32;
> +}

Should that be <= not <, or is there just something more wrong in the
patch or bcm2835 HW? I wonder how r1p5 maps to 3 in the test above.
