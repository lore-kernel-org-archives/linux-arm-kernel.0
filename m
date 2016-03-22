From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 22 Mar 2016 19:51:22 +0300
Subject: [PATCH v5 3/6] ACPI: parse SPCR and enable matching console
In-Reply-To: <56F15D40.9020401@hurleysoftware.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
 <20160322122650.GA10616@yury-N73SV>
 <56F15D40.9020401@hurleysoftware.com>
Message-ID: <20160322165122.GB10616@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 07:57:04AM -0700, Peter Hurley wrote:

[...]

> >> +static bool init_earlycon;
> >> +
> >> +void __init init_spcr_earlycon(void)
> >> +{
> >> +	init_earlycon = true;
> >> +}
> >> +
> > 
> > 1. I see you keep in mind multiple access.
> 
> Concurrent access is not a concern here: only the boot cpu is running
> and intrs are off.
> 
> The "init_earlycon" flag is used because parsing the "earlycon" early param
> is earlier than parsing ACPI tables.
> 

OK got it. My concern is that it's generic code, and parse_spcr() is public
function. I think corresponding comment is needed at least. The other option is
to make it race-safe and forget. I prefer second one, moreover it's 2 simple
changes.

> 
>  Then you'd worry about race
> > conditions as well. In this case, I'd consider atomic access to
> > variable.
> > 2. It seems you need is_init() helper too.
> > 
> >> +int __init parse_spcr(void)
> >> +{
> >> +	static char opts[64];
> >> +	struct acpi_table_spcr *table;
> >> +	acpi_size table_size;
> >> +	acpi_status status;
> >> +	char *uart;
> >> +	char *iotype;
> >> +	int baud_rate;
> >> +	int err = 0;
> > 
> > You can do not initialize 'err'.
> 
> Why?
> 

Because there's no path here that doesn't init err with some value.
So this initialization is useless waste of cycles.

[...]
