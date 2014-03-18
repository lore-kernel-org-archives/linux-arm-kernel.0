From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 18 Mar 2014 14:26:53 +0100
Subject: Deadlock with I2C based clock providers
Message-ID: <5328499D.4040806@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

I have a clock provide that implements the clock operations over i2c.

Although this is now possible since commit 533ddeb1e8 clk: allow 
reentrant calls into the clk framework

that patch only deals with single threaded reentrancy.


The issue I am having involves two threads:

Thread A calls the i2c clock driver
Thread B is in an unrelated driver for another I2C device on the same 
I2C bus (audio codec).


Thread A:
     clk_set_rate(my_clk)
         clk_prepare_lock()  <== Takes clock lock
         clk_change_rate()
             ops->set_rate()
                 i2c_transfer()
                     i2c_lock_adapter()  <== Blocks on I2C bus lock



Thread B:
     i2c_transfer()
         i2c_lock_adapter()    <== Takes I2C bus lock
         i2c_imx_xfer()
             i2c_imx_start()
                 clk_prepare_enable(i2c_clk)
                     clk_prepare_lock()  <== Blocks on clock lock


The problem is that the locks are taken in the reverse order leading to 
a classic deadlock.

I saw your [RFC] clk: reentrancy via per-clock locking but that seemed 
to have other problems.


My current (horrible) workaround involves exposing clk_prepare_lock() 
and calling it from i2c_core but that obviously isn't the right solution.

Regards,

Martin
