From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jul 2015 14:10:59 +0100
Subject: crypto: marvell/CESA: Issues with non cache-line aligned buffers
In-Reply-To: <20150703114305.15611807@bbrezillon>
References: <20150703114305.15611807@bbrezillon>
Message-ID: <20150703131059.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BTW, off-topic for this thread... but I notice from Mark Brown's builder
that mv_cesa is causing build errors in mainline now:

        arm-allmodconfig
../drivers/crypto/mv_cesa.c:1037:2: error: implicit declaration of function 'of_get_named_gen_pool' [-Werror=implicit-function-declaration]

        arm-multi_v5_defconfig
../drivers/crypto/mv_cesa.c:1037:2: error: implicit declaration of function 'of_get_named_gen_pool' [-Werror=implicit-function-declaration]

It seems it was fine on July 2nd, but the above was introduced today.

A few other things I notice when looking at this code:

        /* Not all platforms can gate the clock, so it is not
           an error if the clock does not exists. */
        cp->clk = clk_get(&pdev->dev, NULL);
        if (!IS_ERR(cp->clk))
                clk_prepare_enable(cp->clk);

So, if clk_get() returns PTR_ERR(-EPROBE_DEFER) we treat that clock as
missing?  Is that really the behaviour you want there?

        ret = request_irq(irq, crypto_int, 0, dev_name(&pdev->dev),
                        cp);

What happens if crypto_int() is called when request_irq() unlocks its
spinlock, before the clock has been found?  Eg, because we're booting
from a kexec'd kernel.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
