From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 9 Feb 2010 09:07:31 +0800
Subject: Using PXA arm board with MAX7319 GPIO expander input
In-Reply-To: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
Message-ID: <f17812d71002081707u7d65d42byc7a3914bf9e4cc36@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2010 at 1:44 PM, Jebediah Huang <jebediah.huang@gmail.com> wrote:
> Hello ,
>
> I have PXA166 board with MAX7319 GPIO expander connected with 8
> buttons. When any button is pressed, I want to get input event. Can
> this be done?
>
> I have read the littleton and aspenite code to try. The SDA is 105,
> SCL is 106. I use MAX732x driver. It is set as I2C slave at 0x6C. So I
> set up:
>
> static struct i2c_pxa_platform_data pwri2c_info __initdata = {
> ? ? ? ?.use_pio ? ? ? ? ? ? ? ?= 1,
> };
>
> static unsigned long peony_pin_config[] __initdata = {
> ? ? ? ?/* i2c bus */
> ? ? ? ?GPIO105_CI2C_SDA,
> ? ? ? ?GPIO106_CI2C_SCL,
> }
>
> static struct max732x_platform_data max7319_data[] = {
> ? ? ? ?[0] = {
> ? ? ? ? ? ? ? ?.gpio_base ? ? ?= GPIO_EXT0(0),
> ? ? ? ?},
> };
>
> static struct i2c_board_info i2c_board_info[] =
> {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = "max7319",
> ? ? ? ? ? ? ? ?.addr ? ? ? ? ? = 0x6C,
> ? ? ? ? ? ? ? ?.irq ? ? ? ? ? ?= IRQ_GPIO(105),
> ? ? ? ? ? ? ? ?.platform_data ?= &max7319_data[0],
> ? ? ? ?},
> };
>
> when bootup I see;
> <6>[ ? ?0.290770] I2C: i2c-0: PXA I2C adapter
> <6>[ ? ?0.307118] I2C: i2c-1: PXA I2C adapter
> <6>[ ? ?0.821709] hello pony_init
> <3>[ ? ?0.838559] platform_driver_register
> <6>[ ? ?0.868069] max732x_read: read g 1
> <6>[ ? ?0.881893] max732x_read: read g 0
> <4>[ ? ?0.898895] i2c: error: exhausted retries
> <4>[ ? ?0.911947] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
> <4>[ ? ?0.927509] i2c: ICR: 000007e0 ISR: 00000002
> <4>[ ? ?0.927526] i2c: log: [00000006:00000000] [00000006:00000000]
> [00000006:00000000] [00000006:00000000] [00000006:00000000]
> [00000006:00000000] [0000000
> <3>[ ? ?1.167890] dummy 0-005d: failed reading

Just noted the exhausted retries are for 0-005d, you sure this is
max7319 instead of something else, as I was seeing the max7319
address to be 0x6c in the setup above?
