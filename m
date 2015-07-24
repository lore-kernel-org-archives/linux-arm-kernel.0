From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 24 Jul 2015 11:27:20 +0200
Subject: [PATCH v3 1/4] i2c: tegra: implement slave mode
In-Reply-To: <1437424546-30405-2-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-2-git-send-email-danindrey@mail.ru>
Message-ID: <20150724092720.GA1597@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Mon, Jul 20, 2015 at 11:35:43PM +0300, Andrey Danin wrote:
> Initialization code is based on NVEC driver.
> 
> There is a HW bug in AP20 that was also mentioned in kernel sources
> for Toshiba AC100.
> 
> Signed-off-by: Andrey Danin <danindrey@mail.ru>

Still doesn't work for me and I think I understand why. Do you run your
I2C controller in slave mode only? That might work, but using it in
master/slave mode simultanously won't work yet as I see it:

* After every transfer (as master), clocks get disabled. I assume the IP
  core won't be able to detect its own address then.

* There is this code in tegra_i2c_init():

	if (!i2c_dev->is_dvc) {
		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
		sl_cfg |= I2C_SL_CNFG_NACK | I2C_SL_CNFG_NEWSL;
		i2c_writel(i2c_dev, sl_cfg, I2C_SL_CNFG);
		i2c_writel(i2c_dev, 0xfc, I2C_SL_ADDR1);
		i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);

	}

  It probably messes up the slave initialization in tegra_reg_slave().
  At least I see that the slave address gets overwritten when I peek
  the register after boot.

Does that make sense to you?

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/e61802b7/attachment-0001.sig>
