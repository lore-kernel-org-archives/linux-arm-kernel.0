From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 28 Oct 2015 11:06:41 +0900
Subject: [for 4.4 PATCH] memremap: fix highmem support
In-Reply-To: <20151028013557.31764.66161.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151028013557.31764.66161.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <CAPcyv4ggrX0QGELcBt-Vu_xh6mtFvxMTiMsKYfKf4z72O73JVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 10:39 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> Currently memremap checks if the range is "System RAM" and returns the
> kernel linear address.  This is broken for highmem platforms where a
> range may be "System RAM", but is not part of the kernel linear mapping.
> Similar to acpi_map(), use kmap() for PAGE_SIZE memremap() requests for
> highmem, and fall back to ioremap_cache() otherwise.
>
> The impact of this bug is low for now since the pmem driver is the only
> user of memremap(), but this is important to fix before more conversions
> to memremap arrive in 4.4.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Russell,
>
> I question whether the kmap fallback is needed.  This is borrowed from
> the current implementation of acpi_map(), and I added it since arm
> ioremap warns if passed pfn_valid() addresses.

I flubbed the subject line... this is for 4.3-final.
