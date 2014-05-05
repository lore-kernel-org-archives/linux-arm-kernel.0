From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 May 2014 16:41:02 +0200
Subject: ACPI vs DT at runtime
In-Reply-To: <53673866.9000105@ahsoftware.de>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <97692EF2-013E-4E4B-BC16-E0915D67EFEC@antoniou-consulting.com>
 <53673866.9000105@ahsoftware.de>
Message-ID: <69387177.zGLDjZS0ln@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 09:06:14 Alexander Holler wrote:
> 
> A bit late (I don't follow the ML (or what happens in the ARM world) 
> closely, but as I've recently read that ARM64 will go UEFI and ACPI, I 
> wonder what was the reasoning behind that decision.
> 
> Does anyone really assume we will become high quality UEFI and ACPI 
> blobs from vendors? And such with reasonable support/update periods?
> 
> For me that sounds like someone asked dreamers and was unable to adjust 
> those answers in regard to reality.

Where did you read that? It's simply not true and we should make sure
people stop spreading dangerous misinformation.

Regarding UEFI, I don't expect that to change much for Linux, since
it has very little visibility at runtime. UEFI makes sense for some
systems, and we can support that easily. The license is a bit problematic,
since it allows shipping a system without bootloader sources, but other
boot loaders allow that as well, and a lot of companies ship pirated
u-boot without sources, too.

ACPI is a lot harder to support, as it conflicts with the normal DT
probing method, and will be visible to a lot of drivers. I expect
that we will see systems shipping with ACPI at some point, but
so far, nobody has made a serious submission for supporting that,
so it's likely a few years out, and it will only be a small subset
of the shipping systems: basically anything that tries to look like
an x86 PC server rather than an embedded system.

There is ongoing work from Linaro to provide a base enablement of
ACPI on ARM64. Those patches are looking harmless enough, but the
current plan is to not merge them until there is an actual user
who is submitting their platform specific code based on that, and
not before we have clear rules about what systems should or should
not be using ACPI. 

For all embedded systems, DT remains the way to pass data about
nondiscoverable devices on arm64, and I expect that to include
"server" machines based on embedded SoCs.

	Arnd
