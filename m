From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Aug 2014 15:52:19 +0100
Subject: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <53F30B99.4000704@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>
 <20140818142733.GT20043@localhost> <53F30B99.4000704@linaro.org>
Message-ID: <20140820145219.GO24600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 09:32:25AM +0100, Hanjun Guo wrote:
> On 2014-8-18 22:27, Catalin Marinas wrote:
> > On Mon, Aug 04, 2014 at 04:28:15PM +0100, Hanjun Guo wrote:
> >> +#ifdef CONFIG_ACPI
> >> +/*
> >> + * Get a cpu's boot method in the ACPI way.
> >> + */
> >> +static char * __init acpi_get_cpu_boot_method(void)
> >> +{
> >> +	/*
> >> +	 * For ACPI 5.1, only two kind of methods are provided,
> >> +	 * Parking protocol and PSCI, but Parking protocol is
> >> +	 * specified for ARMv7 only, so make PSCI as the only method
> >> +	 * for SMP initialization before the ACPI spec or Parking
> >> +	 * protocol spec is updated.
> >> +	 */
> >> +	switch (smp_boot_protocol()) {
> >> +	case ACPI_SMP_BOOT_PSCI:
> >> +		return "psci";
> >> +	case ACPI_SMP_BOOT_PARKING_PROTOCOL:
> >> +	default:
> >> +		return NULL;
> >> +	}
> >> +}
> > 
> > Actually, do we even need to define smp_boot_protocol()? Is it used
> > anywhere else apart from this patch (I still haven't gone through all
> > patches)?
> 
> It is just used in this patch. I think we can make the ACPI boot protocol
> scalable in this way, if we support another boot protocol in ACPI in the
> future, we can easily update the function to support it, does it make sense?

Not really. You just add additional code, enums, functions when all you
do is check for acpi_psci_present() (or whatever new protocol you would
get). If the enum is never going to be used outside this file, don't
bother with additional functions.

BTW, it would be nicer if the acpi related functions are contained in as
fewer files as possible. So here you could keep
acpi_get_cpu_boot_method() in the acpi.c file. It only returns a string.

-- 
Catalin
