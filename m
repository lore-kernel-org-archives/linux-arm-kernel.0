From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 12:46:17 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <53D616AD.2090501@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <5014834.k6eecMddPC@wuerfel> <53D616AD.2090501@linaro.org>
Message-ID: <5959830.lpqeqL7HbK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 10:23:57 Graeme Gregory wrote:
> The PL011 UART is the use-case I keep hitting, that IP block has a 
> variable input clock on pretty much everything I have seen in the wild. 

Ok, I see. What does ACPI-5.1 say about pl011?

Interestingly, the subset of pl011 that is specified by SBSA does not
contain the IBRD/FBRD registers, effectively making it a fixed-rated
UART (I guess that would be a ART, without the U then), and you
consequently don't even need to know the clock rate.

However, my guess is that most hardware in the real world contains
an actual pl011 and it does make a lot of sense to allow setting
the baud rate on it, which then requires knowing the input clock.

If there is any hardware that implements just the SBSA-mandated subset
rather than the full pl011, we should probably implement both
in the kernel: a dumb driver that can only send and receive, and the
more complex one that can set the bit rates and flow-control but that
requires a standardized ACPI table with the input clock rate.

Whether the two would belong into one file or two separate driver
modules is something I can't tell, it would be up to the serial
maintainers to decide.

> I really hope that this use does not spread beyond a few essential 
> devices like the UART. IMO all real hardware should be the other side of 
> a PCIe bridge.

I would definitely agree with that.

	Arnd
