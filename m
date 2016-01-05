From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 05 Jan 2016 19:27:58 +0000
Subject: [PATCH v2] spi: atmel: Refactor spi-atmel to use SPI framework
 queue
In-Reply-To: <1389244755-16188-1-git-send-email-wenyou.yang@atmel.com> (Wenyou
 Yang's message of "Thu, 9 Jan 2014 13:19:15 +0800")
References: <1389244755-16188-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <yw1xziwj25dt.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wenyou Yang <wenyou.yang@atmel.com> writes:

> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Tested-by: Richard Genoud <richard.genoud@gmail.com>
> ---
> Hi Mark,
>
> Thanks for your feedback.
>
> According to your advice, I prepared this version 2.
>
> The patch is based on the for-next branch of
> 	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> I tested it on sama5d3xek and at91sam9m10g45ek board.
> Richard helped tested it on at91sam9g35-ek board.
>
> Best Regards,
> Wenyou Yang
>
> v2 changelog:
>  1./ Rebase the latest for-next branch included the patch from Richard.
>  2./ remove the lock on complete(&as->xfer_completion).
>  3./ rework the xfer->cs_change is true.
>  4./ remove the member stopping of struct atmel_spi.
>
>  drivers/spi/spi-atmel.c |  678 +++++++++++++++--------------------------------
>  1 file changed, 220 insertions(+), 458 deletions(-)

This patch broke the display control on the AT32STK1000 board.  I don't
know which part of the patch is causing the problem.  This shows up in
the kernel log (with debug messages enabled):

atmel_spi atmel_spi.0: version: 0x171
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xffe00000 (irq 3)
spi spi0.0: setup: bpw 8 mode 0x1 -> csr0 00000008
spi spi0.1: setup: bpw 8 mode 0x3 -> csr1 00000009
ltv350qv spi0.1: new message 93c29cb4 submitted for spi0.1
ltv350qv spi0.1: activate 1, mr 000e0011
ltv350qv spi0.1:   start xfer 93c29c78: len 3 tx 93c69ccc/13c69ccc rx   (null)/ffffffff
------------[ cut here ]------------
WARNING: at drivers/spi/spi-atmel.c:1351
CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.0-rc8+ #14
task: 93c1e000 ti: 93c28000 task.ti: 93c28000
PC is at atmel_spi_transfer_one_message+0x33a/0x72c
LR is at schedule_timeout+0x72/0xc0
pc : [<90139a26>]    lr : [<901d44b6>]    Not tainted
sp : 93c29b2c  r12: 00000000  r11: 93d1adb8
r10: 93c1e364  r9 : 00000200  r8 : 00400022
r7 : 93d12dfc  r6 : 93d12dfc  r5 : 93c29c78  r4 : 93c29bb8
r3 : 93c29cb4  r2 : 93d12c00  r1 : 00000000  r0 : 00000000
Flags: qvnZc
Mode bits: hjmde....G
CPU Mode: Supervisor
Call trace:
 [<900ebfea>] ida_get_new_above+0x5a/0x148
 [<900ec07e>] ida_get_new_above+0xee/0x148
 [<900efa96>] put_dec+0xa2/0xbc
 [<900efdea>] number+0x2e6/0x2f4
 [<90137e6a>] __spi_pump_messages+0x21e/0x304
 [<90137910>] spi_queued_transfer+0x0/0x8
 [<90138046>] __spi_sync+0xf6/0xf8
 [<90137910>] spi_queued_transfer+0x0/0x8
 [<90138056>] spi_sync+0x6/0x8
 [<9010a39e>] ltv350qv_write_reg+0x100/0x106
 [<90080000>] __generic_block_fiemap+0x78/0x250
 [<90138150>] spi_complete+0x0/0x8
 [<9010a3cc>] ltv350qv_power+0x28/0x1e4
 [<9010a5f6>] ltv350qv_probe+0x4e/0x68
 [<90136b68>] spi_drv_probe+0x20/0x22
 [<901336e6>] driver_probe_device+0xe6/0x188
 [<90133826>] __device_attach_driver+0x4a/0x54
 [<901327ae>] bus_for_each_drv+0x32/0x54
 [<901337dc>] __device_attach_driver+0x0/0x54
 [<901338a2>] __device_attach+0x5a/0x7c
 [<901338ca>] device_initial_probe+0x6/0x8
 [<90132e2c>] bus_probe_device+0x58/0x5c
 [<90131d94>] device_add+0x1fc/0x344
 [<9013823c>] spi_setup+0x88/0xf8
 [<90139e18>] atmel_spi_setup+0x0/0x160
 [<901386e8>] spi_add_device+0x70/0xf0
 [<9013881e>] spi_new_device+0x56/0x6c
 [<9013884e>] spi_match_master_to_boardinfo+0x1a/0x30
 [<90138938>] spi_register_master+0xd4/0x22c
 [<90138aac>] devm_spi_register_master+0x1c/0x44
 [<90138faa>] atmel_spi_probe+0x29a/0x38c
 [<900b06c0>] sysfs_do_create_link_sd+0x34/0x60
 [<90134430>] platform_drv_probe+0x14/0x40
 [<901336e6>] driver_probe_device+0xe6/0x188
 [<900ecbca>] kobject_add_internal+0x56/0x1c8
 [<901337d8>] __driver_attach+0x50/0x54
 [<90000418>] repair_env_string+0x0/0x58
 [<9013280e>] bus_for_each_dev+0x3e/0x58
 [<90133788>] __driver_attach+0x0/0x54
 [<90133508>] driver_attach+0x10/0x14
 [<90132cb2>] bus_add_driver+0xf6/0x15c
 [<90133aae>] driver_register+0x3e/0x98
 [<901343b6>] __platform_driver_register+0x22/0x28
 [<9000aba8>] atmel_spi_driver_init+0x0/0x10
 [<9000abb2>] atmel_spi_driver_init+0xa/0x10
 [<9000023e>] do_one_initcall+0xaa/0x130
 [<90027ae2>] parse_args+0x19e/0x27c
 [<90000418>] repair_env_string+0x0/0x58
 [<90000374>] kernel_init_freeable+0x88/0x12c
 [<90000382>] kernel_init_freeable+0x96/0x12c
 [<90000418>] repair_env_string+0x0/0x58
 [<901d2588>] kernel_init+0x8/0xa4
 [<90013130>] syscall_return+0x0/0x12
 [<901d2580>] kernel_init+0x0/0xa4
 [<90013130>] syscall_return+0x0/0x12

---[ end trace 6b6391f8ee24f957 ]---
ltv350qv spi0.1: spi transfer timeout
atmel_spi atmel_spi.0: overrun (2/3 remaining)
atmel_spi atmel_spi.0: timeout waiting for TXEMPTY

-- 
M?ns Rullg?rd
