From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Tue, 04 Mar 2014 15:29:16 +0100
Subject: [BUG] atmel: spi: scheduling while atomic
Message-ID: <5315E33C.5000205@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I discovered some problem when I access anything on SPI. But it seems to work correctly, only log is full of this 
messages. I've tried kernels 3.13.0 and 3.14.0, both are the same.

[    0.875000] atmel_spi f0000000.spi: version: 0x212
[    0.878906] atmel_spi f0000000.spi: Using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
[    0.882812] atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 28)
...
[    0.890625] BUG: scheduling while atomic: spi0/383/0x00000002
[    0.894531] Modules linked in:
[    0.894531] CPU: 0 PID: 383 Comm: spi0 Not tainted 3.14.0-rc4_cpm9g25+ #1
[    0.894531] [<c000d9f4>] (unwind_backtrace) from [<c000bdc0>] (show_stack+0x10/0x14)
[    0.894531] [<c000bdc0>] (show_stack) from [<c003a224>] (__schedule_bug+0x48/0x60)
[    0.894531] [<c003a224>] (__schedule_bug) from [<c0390294>] (__schedule+0x60/0x484)
[    0.894531] [<c0390294>] (__schedule) from [<c038feac>] (schedule_timeout+0x17c/0x1ac)
[    0.894531] [<c038feac>] (schedule_timeout) from [<c039111c>] (wait_for_common+0x10c/0x1f0)
[    0.894531] [<c039111c>] (wait_for_common) from [<c0249228>] (atmel_spi_transfer_one_message+0x71c/0xa48)
[    0.894531] [<c0249228>] (atmel_spi_transfer_one_message) from [<c0246624>] (spi_pump_messages+0x210/0x238)
[    0.894531] [<c0246624>] (spi_pump_messages) from [<c00343d0>] (kthread_worker_fn+0x15c/0x1b4)
[    0.894531] [<c00343d0>] (kthread_worker_fn) from [<c0034534>] (kthread+0xb8/0xcc)
[    0.894531] [<c0034534>] (kthread) from [<c0009510>] (ret_from_fork+0x14/0x24)
[    0.898437] at25 spi0.0: 128 KByte at25 eeprom, pagesize 512
...
[ 3204.558593] BUG: scheduling while atomic: spi0/383/0x00000002
[ 3204.562500] Modules linked in:
[ 3204.562500] CPU: 0 PID: 383 Comm: spi0 Tainted: G        W    3.14.0-rc4_cpm9g25+ #1
[ 3204.562500] [<c000d9f4>] (unwind_backtrace) from [<c000bdc0>] (show_stack+0x10/0x14)
[ 3204.566406] [<c000bdc0>] (show_stack) from [<c003a224>] (__schedule_bug+0x48/0x60)
[ 3204.566406] [<c003a224>] (__schedule_bug) from [<c0390294>] (__schedule+0x60/0x484)
[ 3204.566406] [<c0390294>] (__schedule) from [<c038feac>] (schedule_timeout+0x17c/0x1ac)
[ 3204.566406] [<c038feac>] (schedule_timeout) from [<c039111c>] (wait_for_common+0x10c/0x1f0)
[ 3204.566406] [<c039111c>] (wait_for_common) from [<c0249228>] (atmel_spi_transfer_one_message+0x71c/0xa48)
[ 3204.566406] [<c0249228>] (atmel_spi_transfer_one_message) from [<c0246624>] (spi_pump_messages+0x210/0x238)
[ 3204.566406] [<c0246624>] (spi_pump_messages) from [<c00343d0>] (kthread_worker_fn+0x15c/0x1b4)
[ 3204.566406] [<c00343d0>] (kthread_worker_fn) from [<c0034534>] (kthread+0xb8/0xcc)
[ 3204.566406] [<c0034534>] (kthread) from [<c0009510>] (ret_from_fork+0x14/0x24)
[ 3204.570312] BUG: scheduling while atomic: spi0/383/0x00000002
[ 3204.574218] Modules linked in:
[ 3204.574218] CPU: 0 PID: 383 Comm: spi0 Tainted: G        W    3.14.0-rc4_cpm9g25+ #1
[ 3204.574218] [<c000d9f4>] (unwind_backtrace) from [<c000bdc0>] (show_stack+0x10/0x14)
[ 3204.574218] [<c000bdc0>] (show_stack) from [<c003a224>] (__schedule_bug+0x48/0x60)
[ 3204.574218] [<c003a224>] (__schedule_bug) from [<c0390294>] (__schedule+0x60/0x484)
[ 3204.574218] [<c0390294>] (__schedule) from [<c038feac>] (schedule_timeout+0x17c/0x1ac)
[ 3204.574218] [<c038feac>] (schedule_timeout) from [<c039111c>] (wait_for_common+0x10c/0x1f0)
[ 3204.574218] [<c039111c>] (wait_for_common) from [<c0249228>] (atmel_spi_transfer_one_message+0x71c/0xa48)
[ 3204.574218] [<c0249228>] (atmel_spi_transfer_one_message) from [<c0246624>] (spi_pump_messages+0x210/0x238)
[ 3204.574218] [<c0246624>] (spi_pump_messages) from [<c00343d0>] (kthread_worker_fn+0x15c/0x1b4)
[ 3204.574218] [<c00343d0>] (kthread_worker_fn) from [<c0034534>] (kthread+0xb8/0xcc)
[ 3204.574218] [<c0034534>] (kthread) from [<c0009510>] (ret_from_fork+0x14/0x24)
