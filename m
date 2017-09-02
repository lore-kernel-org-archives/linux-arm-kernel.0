From: jun.gao@mediatek.com (Jun Gao)
Date: Sat, 2 Sep 2017 20:08:08 +0800
Subject: [I2C] About warning 'DMA-API: device driver maps memory from stack'
Message-ID: <1504354088.31793.48.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram,

When we use i2c-tools command 'i2cset -y -f 0 0x50 0x00 0x11'(0:i2c bus
number; 0x50:eeprom device addr; 0x00:device register addr; 0x11:write
data)to write data, a warning appears as below if enable kernel config
CONFIG_DMA_API_DEBUG=y.

[   11.872860] i2c-mt65xx 11007000.i2c: DMA-API: device driver maps
memory from stack [addr=ffff80007a21fb88]
[   11.874104] ------------[ cut here ]------------
[   11.874703] WARNING: CPU: 1 PID: 1232
at /proj/user/kernel_only_dev_4.13_rc1/kernel/mediatek/lib/dma-debug.c:1188 check_for_stack+0xb0/0x100
[   11.876337] Modules linked in:
[   11.876735] CPU: 1 PID: 1232 Comm: sh Not tainted
4.13.0-rc1-221494-g28b31c4-dirty #1
[   11.877729] Hardware name: MediaTek MT8173 evaluation board (DT)
[   11.878490] task: ffff80007b3cb600 task.stack: ffff80007a21c000
[   11.879242] PC is at check_for_stack+0xb0/0x100
[   11.879821] LR is at check_for_stack+0xb0/0x100
...
[   11.902642] [<ffff0000083c72b8>] check_for_stack+0xb0/0x100
[   11.903352] [<ffff0000083c8050>] debug_dma_map_page+0xf8/0x130
[   11.904097] [<ffff000008792bcc>] mtk_i2c_transfer+0x834/0xa90
[   11.904826] [<ffff0000087870cc>] __i2c_transfer+0x11c/0x278
[   11.905535] [<ffff00000878728c>] i2c_transfer+0x64/0xb8
[   11.906200] [<ffff00000878852c>] i2c_smbus_xfer_emulated+0x114/0x518
[   11.907006] [<ffff000008788a48>] i2c_smbus_xfer+0x118/0x180
...


Reason:
i2c-tools command will call ioctl(file,I2C_SMBUS,&args) ->
i2cdev_ioctl_smbus(...) -> i2c_smbus_xfer(...) ->
i2c_smbus_xfer_emulated(...).
Local variables were used as data buf of struct i2c_msg in function
i2c_smbus_xfer_emulated(...) as below, but we default use DMA mode in
mtk i2c driver(drivers/i2c/busses/i2c-mt65xx.c) with
dma_map_single(...).
Then 'DMA-API: device driver maps memory from stack' warning appeared.

static s32 i2c_smbus_xfer_emulated(...)
{
...

        unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
        unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
        int num = read_write == I2C_SMBUS_READ ? 2 : 1;
        int i;
        u8 partial_pec = 0;
        int status;
        struct i2c_msg msg[2] = {
                {
                        .addr = addr,
                        .flags = flags,
                        .len = 1,
                        .buf = msgbuf0,
                }, {
                        .addr = addr,
                        .flags = flags | I2C_M_RD,
                        .len = 0,
                        .buf = msgbuf1,
                },
        };

...

        status = i2c_transfer(adapter, msg, num);
        if (status < 0)
                return status;
...
}


Solution:
modify i2c-mt65xx.c
1. kmalloc and memcpy buffer for struct i2c_msg buf every time in
i2c-mt65xx.c
2. use FIFO mode when length<=fifo_depth(mtk i2c fifo_depth=8), use
solution 1 for DMA mode when length>fifo_depth in i2c-mt65xx.c . Because
i2c-tools command write/read length<8 in most cases, this solution may
be better than solution 1 in performance.

modify function i2c_smbus_xfer_emulated(...)
3. kmalloc data buffer instead of local variables buf in function
i2c_smbus_xfer_emulated(...)


Which solution is better? Could you give some suggestions?
Thanks!

Best Regards
Jun
