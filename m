From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Jul 2014 14:49:24 +0300
Subject: ABBA deadlock in Common Clock Framework
In-Reply-To: <53B3E5F8.80501@samsung.com>
References: <53B3E5F8.80501@samsung.com>
Message-ID: <20140702114924.GC3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 12:59:04PM +0200, Tomasz Figa wrote:
> Hi All,
> 
> While testing linux-next (next-20140625) on Exynos4412-based TRATS2
> board, from time to time I hit a deadlock between clk_disable_unused()
> of Common Clock Framework and parallel clk_prepare() from s3c24xx-i2c
> driver.
> 
> I believe the following is happening (in processes 1 and 2):
>  1: clk_disable_unused()
>  1: clk_prepare_lock()
>  1: mutex_lock(clk prepare mutex) // lock A
>  1: max77686_clk_is_prepared()
>  1: regmap_read()
>  2: regulator_set_voltage()
>  2: regmap_read()
>  2: mutex_lock(max77686 regmap mutex) // lock B
>  2: i2c_transfer()
>  2: s3c24xx_i2c_xfer()
>  2: clk_unprepare()
>  2: clk_prepare_lock()
>  2: mutex_lock(clk prepare mutex) // lock A
>  1: mutex_lock(max77686 regmap mutex) // lock B
>  1,2: BOOM!
> 
> I suppose this is a general problem affecting any MFD device that is
> also a clock provider, but I clearly don't have a good idea what to do
> about it.
> 

Or if you use notifiers which use i2c... See also
http://comments.gmane.org/gmane.linux.kernel/1553699. One workaround is to
always leave the clock of the i2c controller in a prepared state.

Cheers,

Peter.
