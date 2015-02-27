From: sebastien.szymanski@armadeus.com (=?UTF-8?B?U8OpYmFzdGllbiBTWllNQU5TS0k=?=)
Date: Fri, 27 Feb 2015 12:09:51 +0100
Subject: Bug in i2c-core?
Message-ID: <54F0507F.6030804@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am writing an I2C touchscreen driver for an i.MX6 based board. I
compiled it as a module and when I unload it, I get the following warning:

# modprobe sx8654
[   46.261494] input: SX8654 I2C Touchscreen as
/devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/input1
# rmmod sx8654
[   76.435223] ------------[ cut here ]------------
[   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
remove_proc_entry+0x148/0x164()
[   76.448582] remove_proc_entry: removing non-empty directory
'irq/208', leaking at least 'sx8654'
[   76.457445] Modules linked in: sx8654(-)
[   76.461452] CPU: 0 PID: 134 Comm: rmmod Not tainted
4.0.0-rc1-00002-g30f95ab-dirty #6
[   76.469380] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   76.475977] Backtrace:
[   76.478504] [<80012638>] (dump_backtrace) from [<80012854>]
(show_stack+0x18/0x1c)
[   76.486164]  r7:80151e04 r6:809dd4b0 r5:00000000 r4:00000000
[   76.491990] [<8001283c>] (show_stack) from [<806ea6cc>]
(dump_stack+0x8c/0xa4)
[   76.499340] [<806ea640>] (dump_stack) from [<8002add4>]
(warn_slowpath_common+0x7c/0xb8)
[   76.507509]  r7:80151e04 r6:00000228 r5:00000009 r4:bdacbdb8
[   76.513311] [<8002ad58>] (warn_slowpath_common) from [<8002ae48>]
(warn_slowpath_fmt+0x38/0x40)
[   76.522110]  r8:8000ee04 r7:809d1360 r6:be038e80 r5:be038ef5 r4:80898a18
[   76.529027] [<8002ae14>] (warn_slowpath_fmt) from [<80151e04>]
(remove_proc_entry+0x148/0x164)
[   76.537728]  r3:806fa800 r2:80898a18
[   76.541385]  r4:bda01e80
[   76.543983] [<80151cbc>] (remove_proc_entry) from [<80076390>]
(unregister_irq_proc+0x94/0xb8)
[   76.552715]  r6:000000d0 r5:8120edb8 r4:be0c1100
[   76.557485] [<800762fc>] (unregister_irq_proc) from [<8006ee50>]
(free_desc+0x34/0x6c)
[   76.565450]  r6:000000d0 r5:809d1354 r4:be0c1100
[   76.570127] [<8006ee1c>] (free_desc) from [<8006eed0>]
(irq_free_descs+0x48/0x84)
[   76.577636]  r7:00000001 r6:000000d0 r5:000000d1 r4:000000d1
[   76.583383] [<8006ee88>] (irq_free_descs) from [<80075308>]
(irq_dispose_mapping+0x40/0x5c)
[   76.591761]  r7:00000081 r6:be1cb454 r5:be1cb420 r4:000000d0
[   76.597519] [<800752c8>] (irq_dispose_mapping) from [<804b18b4>]
(i2c_device_remove+0x68/0x88)
[   76.606178]  r5:be1cb420 r4:00000000
[   76.609806] [<804b184c>] (i2c_device_remove) from [<8039ecf0>]
(__device_release_driver+0x78/0xcc)
[   76.618810]  r5:7f000784 r4:be1cb420
[   76.622432] [<8039ec78>] (__device_release_driver) from [<8039f468>]
(driver_detach+0xbc/0xc0)
[   76.631068]  r5:7f000784 r4:be1cb420
[   76.634720] [<8039f3ac>] (driver_detach) from [<8039ea18>]
(bus_remove_driver+0x54/0xa8)
[   76.642814]  r7:00000081 r6:00003435 r5:7ee68a78 r4:7f000784
[   76.648570] [<8039e9c4>] (bus_remove_driver) from [<8039fac8>]
(driver_unregister+0x30/0x50)
[   76.657056]  r5:7ee68a78 r4:7f000784
[   76.660679] [<8039fa98>] (driver_unregister) from [<804b2aa0>]
(i2c_del_driver+0x20/0x28)
[   76.668893]  r5:7ee68a78 r4:7f000768
[   76.672522] [<804b2a80>] (i2c_del_driver) from [<7f000448>]
(sx8654_driver_exit+0x14/0x1c [sx8654])
[   76.681593]  r5:7ee68a78 r4:7f0007d4
[   76.685257] [<7f000434>] (sx8654_driver_exit [sx8654]) from
[<800967e8>] (SyS_delete_module+0x120/0x1c4)
[   76.694773] [<800966c8>] (SyS_delete_module) from [<8000ec40>]
(ret_fast_syscall+0x0/0x4c)
[   76.703058]  r5:36387873 r4:00025014
[   76.706691] ---[ end trace c92a3e03b1c63abc ]---


My driver is similar to other touchscreen drivers, i.e. ar1021_i2c.c.


/*
 * drivers/input/touchscreen/sx8654.c
 *
 * Copyright (c) 2015 Armadeus Systems
 *      S?bastien Szymanski <sebastien.szymanski@armadeus.com>
 *
 * Using code from:
 *  - sx865x.c
 *      Copyright (c) 2013 U-MoBo Srl
 *      Pierluigi Passaro <p.passaro@u-mobo.com>
 *  - sx8650.c
 *      Copyright (c) 2009 Wayne Roberts
 *  - tsc2007.c
 *      Copyright (c) 2008 Kwangwoo Lee
 *  - ads7846.c
 *      Copyright (c) 2005 David Brownell
 *      Copyright (c) 2006 Nokia Corporation
 *  - corgi_ts.c
 *      Copyright (C) 2004-2005 Richard Purdie
 *  - omap_ts.[hc], ads7846.h, ts_osk.c
 *      Copyright (C) 2002 MontaVista Software
 *      Copyright (C) 2004 Texas Instruments
 *      Copyright (C) 2005 Dirk Behme
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <linux/input.h>
#include <linux/of.h>
#include <linux/i2c.h>
#include <linux/irq.h>
#include <linux/interrupt.h>

/* register addresses */
#define I2C_REG_TOUCH0                  0x00
#define I2C_REG_TOUCH1                  0x01
#define I2C_REG_CHANMASK                0x04
#define I2C_REG_IRQMASK                 0x22
#define I2C_REG_IRQSRC                  0x23
#define I2C_REG_SOFTRESET               0x3f

/* commands */
#define CMD_READ_REGISTER               0x40
#define CMD_MANUAL                      0xc0
#define CMD_PENTRG                      0xe0

/* value for I2C_REG_SOFTRESET */
#define SOFTRESET_VALUE                 0xde

/* bits for I2C_REG_IRQSRC */
#define IRQ_PENTOUCH_TOUCHCONVDONE      0x08
#define IRQ_PENRELEASE                  0x04

/* bits for RegTouch1 */
#define CONDIRQ                         0x20
#define FILT_7SA                        0x03

/* bits for I2C_REG_CHANMASK */
#define CONV_X                          0x80
#define CONV_Y                          0x40

/* coordinates rate: higher nibble of CTRL0 register */
#define RATE_MANUAL                     0x00
#define RATE_5000CPS                    0xf0

/* power delay: lower nibble of CTRL0 register */
#define POWDLY_IMMEDIATE                0x00
#define POWDLY_1_1MS                    0x0b

#define MAX_12BIT                       ((1 << 12) - 1)

struct sx8654 {
        struct input_dev *input;
        struct i2c_client *client;
};

static irqreturn_t sx8654_irq(int irq, void *handle)
{
        struct sx8654 *sx8654 = handle;
        u8 irqsrc;
        u8 data[4];
        unsigned int x, y;
        int retval;

        irqsrc = i2c_smbus_read_byte_data(sx8654->client,
                                          (CMD_READ_REGISTER |
I2C_REG_IRQSRC));
        dev_dbg(&sx8654->client->dev, "irqsrc = 0x%x", irqsrc);

        if (irqsrc < 0)
                goto out;

        if (irqsrc & IRQ_PENRELEASE) {
                dev_dbg(&sx8654->client->dev, "pen release interrupt");

                input_report_key(sx8654->input, BTN_TOUCH, 0);
                input_sync(sx8654->input);
        }

        if (irqsrc & IRQ_PENTOUCH_TOUCHCONVDONE) {
                dev_dbg(&sx8654->client->dev, "pen touch interrupt");

                retval = i2c_master_recv(sx8654->client, data,
sizeof(data));
                if (retval != sizeof(data))
                        goto out;

                /* invalid data */
                if (unlikely(data[0] & 0x80 || data[2] & 0x80))
                        goto out;

                x = ((data[0] & 0xf) << 8) | (data[1]);
                y = ((data[2] & 0xf) << 8) | (data[3]);

                input_report_abs(sx8654->input, ABS_X, x);
                input_report_abs(sx8654->input, ABS_Y, y);
                input_report_key(sx8654->input, BTN_TOUCH, 1);
                input_sync(sx8654->input);

                dev_dbg(&sx8654->client->dev, "point(%4d,%4d)\n", x, y);
        }

out:
        return IRQ_HANDLED;
}

static int sx8654_open(struct input_dev *dev)
{
        struct sx8654 *sx8654 = input_get_drvdata(dev);
        struct i2c_client *client = sx8654->client;
        int error;

        /* enable pen trigger mode */
        error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0,
                                          (RATE_5000CPS | POWDLY_1_1MS));
        if (error < 0) {
                dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
                return -EIO;
        }

        error = i2c_smbus_write_byte(client, CMD_PENTRG);
        if (error < 0) {
                dev_err(&client->dev, "writing command CMD_PENTRG failed");
                return -EIO;
        }

        enable_irq(client->irq);

        return 0;
}

static void sx8654_close(struct input_dev *dev)
{
        struct sx8654 *sx8654 = input_get_drvdata(dev);
        struct i2c_client *client = sx8654->client;
        int error;

        disable_irq(client->irq);

        /* enable manual mode mode */
        error = i2c_smbus_write_byte(client, CMD_MANUAL);
        if (error < 0) {
                dev_err(&client->dev, "writing command CMD_MANUAL failed");
                return;
        }

        error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, 0);
        if (error < 0) {
                dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
                return;
        }
}

static int sx8654_probe(struct i2c_client *client,
                        const struct i2c_device_id *id)
{
        struct sx8654 *sx8654;
        struct input_dev *input;
        int error;

        if (!i2c_check_functionality(client->adapter,
                                     I2C_FUNC_SMBUS_READ_WORD_DATA))
                return -ENXIO;

        sx8654 = devm_kzalloc(&client->dev, sizeof(*sx8654), GFP_KERNEL);
        if (!sx8654)
                return -ENOMEM;

        input = devm_input_allocate_device(&client->dev);
        if (!sx8654)
                return -ENOMEM;

        input->name = "SX8654 I2C Touchscreen";
        input->id.bustype = BUS_I2C;
        input->dev.parent = &client->dev;
        input->open = sx8654_open;
        input->close = sx8654_close;

        __set_bit(INPUT_PROP_DIRECT, input->propbit);
        input_set_capability(input, EV_KEY, BTN_TOUCH);
        input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
        input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);

        sx8654->client = client;
        sx8654->input = input;

        input_set_drvdata(sx8654->input, sx8654);

        error = i2c_smbus_write_byte_data(client, I2C_REG_SOFTRESET,
                                          SOFTRESET_VALUE);
        if (error < 0) {
                dev_err(&client->dev, "writing softreset value failed");
                return -EIO;
        }

        error = i2c_smbus_write_byte_data(client, I2C_REG_CHANMASK,
                                          (CONV_X | CONV_Y));
        if (error < 0) {
                dev_err(&client->dev, "writing to I2C_REG_CHANMASK failed");
                return -EIO;
        }

        error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
                                          (IRQ_PENTOUCH_TOUCHCONVDONE |
                                           IRQ_PENRELEASE));
        if (error < 0) {
                dev_err(&client->dev, "writing to I2C_REG_IRQMASK failed");
                return -EIO;
        }

        error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH1,
                                          (CONDIRQ | FILT_7SA));
        if (error < 0) {
                dev_err(&client->dev, "writing to I2C_REG_TOUCH1 failed");
                return -EIO;
        }

        error = devm_request_threaded_irq(&client->dev, client->irq,
                                          NULL, sx8654_irq,
                                          IRQF_TRIGGER_FALLING |
IRQF_ONESHOT,
                                          client->name, sx8654);
        if (error) {
                dev_err(&client->dev,
                        "Failed to enable IRQ %d, error: %d\n",
                        client->irq, error);
                return error;
        }

        /* Disable the IRQ, we'll enable it in sx8654_open() */
        disable_irq(client->irq);

        error = input_register_device(sx8654->input);
        if (error)
                return error;

        i2c_set_clientdata(client, sx8654);
        return 0;
}

static const struct of_device_id sx8654_of_match[] = {
        { .compatible = "semtech,sx8654", },
        { },
};
MODULE_DEVICE_TABLE(of, sx8654_of_match);

static const struct i2c_device_id sx8654_id_table[] = {
        { "semtech_sx8654", 0 },
        { },
};
MODULE_DEVICE_TABLE(i2c, sx8654_id_table);

static struct i2c_driver sx8654_driver = {
        .driver = {
                .name = "sx8654",
                .owner = THIS_MODULE,
                .of_match_table = sx8654_of_match,
        },

        .id_table = sx8654_id_table,
        .probe = sx8654_probe,
};
module_i2c_driver(sx8654_driver);

MODULE_AUTHOR("S?bastien Szymanski <sebastien.szymanski@armadeus.com>");
MODULE_DESCRIPTION("Semtech SX8654 I2C Touchscreen Driver");
MODULE_LICENSE("GPL");


When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
client removal time) I don't get the warning.

Is this a bug in the i2c-core or am I doing something wrong in my driver?

-- 
S?bastien SZYMANSKI
