From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 15 May 2015 11:31:12 +0800
Subject: [PATCH v4 00/11] drivers: PL011: add ARM SBSA Generic UART support
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Message-ID: <55556880.2010207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?12? 22:14, Andre Przywara wrote:
> This is the fourth revision of the SBSA UART support series, now
> based on the current tty-next branch.
> Compared to v3 I addressed some comments Jakub had on v3 (thanks for
> the review!). Also since some basic ACPI support for ARM64 is now
> upstream, I include the necessary ACPI binding as a new patch 11
> on top.
> ----
>
> The ARM Server Base System Architecture[1] document describes a
> generic UART which is a subset of the ARM PL011 UART.
> It lacks DMA support, baud rate control and modem status line
> control, among other things.
> The idea is to move the UART initialization and setup into the
> firmware (which does this job today already) and let the kernel just
> use the UART for sending and receiving characters.
>
> This patchset integrates support for this UART subset into the
> existing PL011 driver - basically by refactoring some
> functions and providing a new uart_ops structure for it. It also has
> a separate probe function to be not dependent on AMBA/PrimeCell.
> It provides a device tree and an ACPI binding.
> Beside the obvious effect of code sharing reusing most of the PL011
> code has the advantage of not introducing another serial device
> prefix, so it can go with ttyAMA, which seems to be pretty common.
> As changing the baudrate and other communication parameters is not
> specified for the SBSA UART, any userland attempt will be denied by
> the kernel. The device-tree provided fixed baud rate will be
> reported, so stty for instance prints the right value.
>
> This series is based on Greg's tty-next branch, a git repo can
> be found at [2] (branch sbsa-uart/v4).
>
> Patch 1/11 contains a bug fix which applies to the PL011 part also,
> it should be considered regardless of the rest of the series.
> According to Russell this is still racy, but still better than the
> current solution.
> Patch 2-7 refactor some PL011 functions by splitting them up into
> smaller pieces, so that most of the code can be reused later by the
> SBSA part.
> Patch 8 and 9 introduce two new properties for the vendor structure,
> this is for SBSA functionality which cannot be controlled by
> separate uart_ops members only.
> Patch 10 then finally drops in the SBSA specific code, by providing
> a new uart_ops, vendor struct and probe function for it. Also the new
> device tree binding is documented.
> Patch 11 adds the necessary ACPI boilerplate.
>
> For testing you should be able to take any hardware which has a PL011
> and change the DT to use a "arm,sbsa-uart" compatible string and the
> baud rate with the "current-speed" property.
> Of course testing with a real SBSA Generic UART is welcomed - as well
> as regression testing with any PL011 implementation.
> I tested this on a FastModel, a Juno and a Midway machine, both in
> PL011 and in (DT-emulated) SBSA mode.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

in ACPI case with device HID of ARMH0011 in DSDT.

Hanjun
