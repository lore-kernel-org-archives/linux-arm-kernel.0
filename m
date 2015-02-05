From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 05 Feb 2015 18:43:26 +0100
Subject: [REGRESSION] w1: mxc_w1 bus search failing after update 3.16->3.18
Message-ID: <54D3ABBE.1040607@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The commit f80b258  w1: mxc_w1: Optimize mxc_w1_ds2_touch_bit()
introduced in 3.18 is causing w1 bus scanning to fail on my board with:

w1_master_driver w1_bus_master1: w1_search: max_slave_count 64 reached, 
will continue next search.

The problem appears to be the use of jiffies to implement a 200us delay 
in this code:

static u8 mxc_w1_ds2_touch_bit(void *data, u8 bit)
{
     struct mxc_w1_device *dev = data;
     unsigned long timeout;

     writeb(MXC_W1_CONTROL_WR(bit), dev->regs + MXC_W1_CONTROL);

     /* Wait for read/write bit (60us, Max 120us), use 200us for sure */
     timeout = jiffies + usecs_to_jiffies(200);

     udelay(60);

     do {
         u8 ctrl = readb(dev->regs + MXC_W1_CONTROL);

         /* RDST bit is valid after the WR1/RD bit is self-cleared */
         if (!(ctrl & MXC_W1_CONTROL_WR(bit)))
             return !!(ctrl & MXC_W1_CONTROL_RDST);
     } while (time_is_after_jiffies(timeout));

     return 0;
}


My HZ value is 100
usecs_to_jiffies(200) returns 1 but I don't think time_is_after_jiffies 
is accurate for timeout = jiffies + 1?

Adding one jiffy to timeout "fixes" it but that's probably not the right 
way.

Should this be reverted or a hrtimer used?

Regards,

Martin
