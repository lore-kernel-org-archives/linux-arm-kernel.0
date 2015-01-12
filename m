From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 12 Jan 2015 11:16:06 -0800
Subject: IMX.6q FIQ help...
Message-ID: <CAMB+bfLT1DNrvvZH8LYGL4OXggT8866VB26OEar7BZGO5r6cDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am revising a driver that uses a FIQ on Freescale imx6q.
The old driver relied on a 3.0.35 Freescale vendor kernel, and enbled
the FIQ by poking the FIQ enable bit into memory address zero on cpu 3

I'm trying to migrate to vanilla kernel, using code from fiq.c.
The code below works BUT it looks like its just a normal interrupt.
my_irq_handler_spurious handler is ALWAYS invoked,
I'm not keeping up with my 50KHz irq source,
and the counter in /proc/interrupts in incremented, which did not
happen with the FIQ in the old kernel.

Is there something more or something else entirely needed on imx.6
in order to activate the FIQ?

Here is my (abreviated) init code (now called from probe):

int my_init_fiq(struct my_device *dev)
{
        int ret;
        irq = gpiod_to_irq(gpiod);
        if (irq < 0) {
                dev_err(dev->dev, "Error setting gpio as irq: %d\n", irq);
                gpiod_put(gpiod);
                return irq;
        }

        ret = request_irq(irq, my_irq_handler_spurious, 0,
                         "Data Ready Spurious IRQ", &my_device);
        if (ret) {
                dev_err(dev->dev, "Error requesting irq\n");
                free_irq(irq, &my_device);
                gpiod_put(gpiod);
                return ret;
        }
        disable_fiq(irq); /* avoid unbalanced irq complaint */
        ret = claim_fiq(&fiq_handle);

        if (ret) {
                dev_err(dev->dev, "Unable to claim FIQ\n");
                return ret;
        }

        set_fiq_handler(&my_fiq_handler, SZ_256);
        enable_fiq(irq);

        if (ret) {
                dev_err(dev->dev "Unable to enable FIQ\n");
                release_fiq(&fiq_handle);
                return ret;
        }
        return 0;
}


...and the old code, which works with freescale 3.0.35 kernel

#define FPGA_INTERRUPT_DIFF_GPIO_BANK 1
#define FPGA_INTERRUPT_DIFF_GPIO_NUM 4
#define FPGA_INTERRUPT_DIFF_PAD \
        IMX_GPIO_NR(FPGA_INTERRUPT_DIFF_GPIO_BANK, \
        FPGA_INTERRUPT_DIFF_GPIO_NUM)
#define GPIO_CR_INT_ENABLE 0x00000014
#define GIC_CPU_CTRL_BITS_FIQEN 0x08

void fiq_enable(void * data)
{
        unsigned long val;

        val = readl(GIC_CPU_CTRL);
        val |= GIC_CPU_CTRL_BITS_FIQEN;
        writel(val, GIC_CPU_CTRL);
}

int my_init_fiq(void)
{
        int ret;
        unsigned long reg;
        ret = request_irq(gpio_to_irq(FPGA_INTERRUPT_DIFF_PAD),
                        my_handler_spurious, 0,
                        "Data Ready Spurious IRQ", &my_device);
        ret = claim_fiq(&fiq_handle);
        if (ret)
        {
                printk(KERN_ALERT "Unable to claim FIQ\n");
                return ret;
        }

        set_fiq_handler(&my_fiq_handler, SZ_256);

        // enable the fiq on CPU 3
        ret = smp_call_function_single(FIQ_CPU_TARGET, fiq_enable, NULL, 1);

        if (ret)
        {
                printk(KERN_ALERT "Unable to enable FIQ on CPU %d\n",
                          FIQ_CPU_TARGET);
                release_fiq(&fiq_handle);
                return ret;
        }

        // Set rising edge GPIO Peripheral trigger for GPIO 1 - 4
        reg = readl(IO_ADDRESS(GPIO1_BASE_ADDR + GPIO_CR_INT_CONF1));
        reg &= ~(1 << FPGA_INTERRUPT_DIFF_GPIO_NUM);
        reg |= (2 << FPGA_INTERRUPT_DIFF_GPIO_NUM);
        writel(reg, IO_ADDRESS(GPIO1_BASE_ADDR + GPIO_CR_INT_CONF1));

        // Enable GPIO Peripheral interrupt for GPIO 1 - 4
        reg = readl(IO_ADDRESS(GPIO1_BASE_ADDR + GPIO_CR_INT_ENABLE));
        reg |= (1 << FPGA_INTERRUPT_DIFF_GPIO_NUM);
        writel(reg, IO_ADDRESS(GPIO1_BASE_ADDR + GPIO_CR_INT_ENABLE));

        writel((1 << FPGA_INTERRUPT_DIFF_GPIO_NUM) ,
                 GIC_FPGA_INT_ENABLE_REG);

        return 0;
}
