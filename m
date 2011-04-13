From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 13 Apr 2011 22:52:04 +0200
Subject: [PATCH] ARM: add DT support to the S3C SDI driver
In-Reply-To: <20110413173558.GF2254@ponder.secretlab.ca>
References: <20110413172547.GA27819@dandreoli.com>
	<20110413173558.GF2254@ponder.secretlab.ca>
Message-ID: <20110413205204.GA3390@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 11:35:58AM -0600, Grant Likely wrote:
> On Wed, Apr 13, 2011 at 07:25:47PM +0200, Domenico Andreoli wrote:
> >
> > set_power() instead deserves some more considerations. Current
> > implementations boil down to gpio on/off settings, its DT implementation
> > is again straightforward. Problem would arise if any board requires
> > some naive implementation, would it require a different of_device_id
> > with proper .data set?
>
> It would be better to think out the binding a bit more, but I'd need
> to know more details about what is possible.

I looked at the arm tree only, MMC/MCI/SDI area. There are some
.set_power ops also on the LCD side and who know what else with a
different ops name.

The most common case is no .set_power op.

Then we have quite a lot of GPIO cases like this:

static void h1940_set_mmc_power(unsigned char power_mode, unsigned short vdd)
{
    switch (power_mode) {
    case MMC_POWER_OFF:
        gpio_set_value(H1940_LATCH_SD_POWER, 0);
        break;
    case MMC_POWER_UP:
    case MMC_POWER_ON:
        gpio_set_value(H1940_LATCH_SD_POWER, 1);
        break;
    default:
        break;
    };
}

and its derivative:

static int mmc_set_power(struct device *dev, int slot, int power_on, int vdd)
{
    gpio_set_value(H2_TPS_GPIO_MMC_PWR_EN, power_on);
    return 0;
}

then we have a bitwise case on some register (the fpga name is
misleading, they are just __raw_readb/__raw_writeb):

static int mmc_set_power(struct device *dev, int slot, int power_on, int vdd)
{
    if (power_on)
        fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3), OMAP1510_FPGA_POWER);
    else
        fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3), OMAP1510_FPGA_POWER);

    return 0;
}

a i2c bitwise case:

static int mmc_set_power(struct device *dev, int slot, int power_on, int vdd)
{
    int err;
    u8 dat = 0;

    err = sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
    if (err < 0)
        return err;

    if (power_on)
        dat |= SOFIA_MMC_POWER;
    else
        dat &= ~SOFIA_MMC_POWER;

    return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
}

and some other very special cases such as:

static int n8x0_mmc_set_power(struct device *dev, int slot, int power_on, int vdd)
{
    if (machine_is_nokia_n800() || slot == 0)
        return n8x0_mmc_set_power_menelaus(dev, slot, power_on, vdd);

    n810_set_power_emmc(dev, power_on);

    return 0;
}

static int n8x0_mmc_set_power_menelaus(struct device *dev, int slot, int power_on, int vdd)
{
    int mV; 

#ifdef CONFIG_MMC_DEBUG
    dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
        power_on ? "on" : "off", vdd);
#endif
    if (slot == 0) {
        if (!power_on)
            return menelaus_set_vmmc(0);
        switch (1 << vdd) {
        case MMC_VDD_33_34:
        case MMC_VDD_32_33:
        case MMC_VDD_31_32:
            mV = 3100;
            break;
        case MMC_VDD_30_31:
            mV = 3000;
            break;
        case MMC_VDD_28_29:
            mV = 2800;
            break;
        case MMC_VDD_165_195:
            mV = 1850;
            break;
        default:
            BUG();
        }   
        return menelaus_set_vmmc(mV);
    } else {
        if (!power_on)
            return menelaus_set_vdcdc(3, 0); 
        switch (1 << vdd) {
        case MMC_VDD_33_34:
        case MMC_VDD_32_33:
            mV = 3300;
            break;
        case MMC_VDD_30_31:
        case MMC_VDD_29_30:
            mV = 3000;
            break;
        case MMC_VDD_28_29:
        case MMC_VDD_27_28:
            mV = 2800;
            break;
        case MMC_VDD_24_25:
        case MMC_VDD_23_24:
            mV = 2400;
            break;
        case MMC_VDD_22_23:
        case MMC_VDD_21_22:
            mV = 2200;
            break;
        case MMC_VDD_20_21:
            mV = 2000;
            break;
        case MMC_VDD_165_195:
            mV = 1800;
            break;
        default:
            BUG();
        }   
        return menelaus_set_vdcdc(3, mV);
    }   
    return 0;
}

static void n810_set_power_emmc(struct device *dev, int power_on)
{
    dev_dbg(dev, "Set EMMC power %s\n", power_on ? "on" : "off");

    if (power_on) {
        gpio_set_value(N810_EMMC_VSD_GPIO, 1);
        msleep(1);
        gpio_set_value(N810_EMMC_VIO_GPIO, 1);
        msleep(1);
    } else {
        gpio_set_value(N810_EMMC_VIO_GPIO, 0);
        msleep(50);
        gpio_set_value(N810_EMMC_VSD_GPIO, 0);
        msleep(50);
    }
}

the first three are straightforward, the i2c could be tricky but very
nicely expressed in the DT world, the others are so specific that I
doubt they could be re-used on any other board, so I don't see the gain
to port them to DT.

When I say port, I mean "import the interface" concept, of course :)

my two cents....

cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
