From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 19 Oct 2009 16:52:14 -0700
Subject: [PATCH 16/46] davinci: Add MMC/SD support for DA830/OMAP-L137 EVM
In-Reply-To: <20091019140752.GC13614@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon\, 19 Oct 2009 15\:07\:52 +0100")
References: <1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<20091019140752.GC13614@n2100.arm.linux.org.uk>
Message-ID: <87my3nq6vl.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 16, 2009 at 12:09:20PM -0700, Kevin Hilman wrote:
>> From: David A. Griego <dgriego@mvista.com>
>> 
>> Add pinmux settings, etc. to enable the MMC/SC hardware.
>> 
>> Signed-off-by: David A. Griego <dgriego@mvista.com>
>> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-davinci/board-da830-evm.c |   43 +++++++++++++++++++++++++++++++
>>  1 files changed, 43 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
>> index 39711c1..69a791a 100644
>> --- a/arch/arm/mach-davinci/board-da830-evm.c
>> +++ b/arch/arm/mach-davinci/board-da830-evm.c
>> @@ -23,6 +23,7 @@
>>  #include <mach/irqs.h>
>>  #include <mach/cp_intc.h>
>>  #include <mach/mux.h>
>> +#include <mach/gpio.h>
>
> linux/gpio.h
>
>> +static int da830_evm_mmc_get_ro(int index)
>> +{
>> +	int val, status, gpio_num = 33;
>> +
>> +	status = gpio_request(gpio_num, "MMC WP\n");
>> +	if (status < 0) {
>> +		pr_warning("%s can not open GPIO %d\n", __func__, gpio_num);
>> +		return 0;
>> +	}
>> +	gpio_direction_input(gpio_num);
>> +	val = gpio_get_value(gpio_num);
>> +	gpio_free(gpio_num);
>
> Should this really be requesting the gpio every time it wants to be
> read?  This approach sounds wrong.  Why not just request the GPIO in
> the platform initialisation code, setting its direction, and merely
> reading it in this function?

Russell,

Thanks for the reviews.

Indeed, request and init should be done at init time as is done for
the da850 board.  Here's an updated version.

This version is now the one pushed to the davinci-next branch.

Kevin
