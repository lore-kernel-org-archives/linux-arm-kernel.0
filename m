From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 7 Nov 2018 23:06:04 -0800
Subject: [PATCH 5/5] hwspinlock: Add test module
In-Reply-To: <20181031093032.20386-6-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
 <20181031093032.20386-6-benjamin.gaignard@st.com>
Message-ID: <20181108070604.GE12063@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 31 Oct 02:30 PDT 2018, Benjamin Gaignard wrote:

> Create a test module to perform simple unitary tests on hwspinlock.
> It doesn't cover all the possibles cases but at least allow to test
> that very basic features are working.
> 

I like the idea of making these things testable, but I would like to
hear from others how useful this module would be to them before merging
it.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/hwspinlock/Kconfig           |   9 +++
>  drivers/hwspinlock/Makefile          |   1 +
>  drivers/hwspinlock/hwspinlock_test.c | 132 +++++++++++++++++++++++++++++++++++
>  3 files changed, 142 insertions(+)
>  create mode 100644 drivers/hwspinlock/hwspinlock_test.c
> 
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index e1a20b460590..f340ebb4d1f7 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -68,3 +68,12 @@ config HWSPINLOCK_STM32
>  	  Say y here to support the STM32 Hardware Spinlock device.
>  
>  	  If unsure, say N.
> +
> +config HWSPINLOCK_TEST
> +	tristate "hwspinlock test module"
> +	depends on HWSPINLOCK && m
> +	default n
> +	help
> +	  Select M here if you want to build hwspinlock test module
> +
> +	  If unsure, say N.
> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> index c0a9505b4dcf..e6b3d0212fe0 100644
> --- a/drivers/hwspinlock/Makefile
> +++ b/drivers/hwspinlock/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
>  obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
>  obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
> +obj-$(CONFIG_HWSPINLOCK_TEST) 		+= hwspinlock_test.o
> diff --git a/drivers/hwspinlock/hwspinlock_test.c b/drivers/hwspinlock/hwspinlock_test.c
> new file mode 100644
> index 000000000000..75819337e45a
> --- /dev/null
> +++ b/drivers/hwspinlock/hwspinlock_test.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics SA 2018
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/hwspinlock.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#define TIMEOUT	50 /* ms */
> +
> +static void hwspin_lock_test_twice_request_specific(void)
> +{
> +	struct hwspinlock *lock0 = hwspin_lock_request_specific(0);
> +	struct hwspinlock *lock1 = hwspin_lock_request_specific(1);

In a platform with more than one hwspinlock this will test the
implementation that was first probed and it will assume that there's no
issues with messing with the first two locks from this provider.

> +
> +	int ret;
> +
> +	if (!lock0 || !lock1) {
> +		pr_warn("Can't request twice hwspin_lock\n");
> +		return;
> +	}
> +
> +	ret = hwspin_trylock(lock0);
> +	if (ret)
> +		pr_warn("Can't trylock requested hwspin_lock 0 (%d)\n", ret);
> +
> +	ret = hwspin_trylock(lock1);
> +	if (ret)
> +		pr_warn("Can't trylock requested hwspin_lock 1 (%d)\n", ret);
> +
> +	hwspin_unlock(lock0);
> +	hwspin_unlock(lock1);

As described in the kerneldoc for these it's a bug to attempt to unlock
a unlocked lock. I believe this should be interpreted as it being
invalid to unlock unless hwspin_trylock() returned successfully.

> +
> +	ret = hwspin_lock_free(lock0);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +
> +	ret = hwspin_lock_free(lock1);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +}
> +
> +static void hwspin_lock_test_trylock(void)
> +{
> +	struct hwspinlock *lock = hwspin_lock_request();
> +	int ret;
> +
> +	if (!lock) {
> +		pr_warn("Can't request hwspin_lock\n");
> +		return;
> +	}
> +
> +	ret = hwspin_trylock(lock);
> +	if (ret)
> +		pr_warn("Can't trylock requested hwspin_lock (%d)\n", ret);
> +
> +	/* Try to lock a second time, this should failed */
> +	ret = hwspin_trylock(lock);
> +	if (ret != -EBUSY)
> +		pr_warn("Getting twice the same lock ! (%d)\n", ret);

This shouldn't be a warning, as this is a test failure.

> +
> +	hwspin_unlock(lock);
> +	ret = hwspin_lock_free(lock);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +}
> +
> +static void hwspin_lock_test_request_specific(void)
> +{
> +	/*
> +	 * Let's assume that any hwspin_lock driver would at least have one
> +	 * lock at index 0
> +	 */
> +	struct hwspinlock *lock = hwspin_lock_request_specific(0);
> +	int ret;
> +
> +	if (!lock) {
> +		pr_warn("Can't request hwspin_lock 0\n");
> +		return;
> +	}
> +
> +	ret = hwspin_lock_timeout(lock, TIMEOUT);
> +	if (ret)
> +		pr_warn("Can't lock requested hwspin_lock 0 (%d)\n", ret);
> +
> +	hwspin_unlock(lock);
> +	ret = hwspin_lock_free(lock);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock 0\n");
> +}
> +
> +static void hwspin_lock_test_request(void)

I would suggest that your test cases test one thing each; so request and
request_specific should test just that.

> +{
> +	struct hwspinlock *lock = hwspin_lock_request();
> +	int ret;
> +
> +	if (!lock) {
> +		pr_warn("Can't request hwspin_lock\n");
> +		return;
> +	}
> +
> +	ret = hwspin_lock_timeout(lock, TIMEOUT);
> +	if (ret)
> +		pr_warn("Can't lock requested hwspin_lock (%d)\n", ret);

Testing lock-timeout seems useful, but you probably want to elaborate it
to ensure that it both can lock a lock but that it times out properly
when trying to grab a taken lock.

> +
> +	hwspin_unlock(lock);
> +	ret = hwspin_lock_free(lock);
> +	if (ret)
> +		pr_warn("Can't free requested hwspin_lock\n");
> +}
> +
> +/*
> + * Test hwspinlock user API when module is loaded
> + */
> +static int __init hwspin_lock_test_init(void)
> +{
> +	pr_warn("Loading hwspinlock test module\n");
> +	hwspin_lock_test_request();
> +	hwspin_lock_test_request_specific();
> +	hwspin_lock_test_trylock();
> +	hwspin_lock_test_twice_request_specific();
> +
> +	return 0;
> +}
> +

Regards,
Bjorn
