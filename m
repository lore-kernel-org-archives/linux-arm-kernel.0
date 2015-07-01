From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jul 2015 23:27:14 +0100
Subject: [PATCH] ARM: fix vdsomunge not to depend on glibc specific error.h
In-Reply-To: <559273FD.2030508@arm.com>
References: <559273FD.2030508@arm.com>
Message-ID: <20150701222713.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 11:48:29AM +0100, Szabolcs Nagy wrote:
> @@ -82,11 +80,25 @@
>  #define EF_ARM_ABI_FLOAT_HARD 0x400
>  #endif
> 
> +static int failed;
> +static const char *argv0;
>  static const char *outfile;
> 
> +static void fail(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	failed = 1;
> +	fprintf(stderr, "%s: ", argv0);
> +	va_start(ap, fmt);
> +	vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +	exit(EXIT_FAILURE);

What purpose does "failed" serve?  Reading through this patch, it
seems to be a write-only variable.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
