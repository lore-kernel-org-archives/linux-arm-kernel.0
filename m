From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Apr 2018 12:52:26 +0100
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <CACi5LpNKbSejFecV+G8X53t4VDwsTvJywWLgLVw9qsD7u6REvg@mail.gmail.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <CACi5LpNKbSejFecV+G8X53t4VDwsTvJywWLgLVw9qsD7u6REvg@mail.gmail.com>
Message-ID: <20180418115225.7hvhsua25rhfqvjs@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2018 at 01:44:16AM +0530, Bhupesh Sharma wrote:
> 4. Accordingly, I wanted to get opinions on whether arm64 timer count is a good
> entropy source on platforms which indeed support EFI_RNG_PROTOCOL?

On its own, the timer is not a good entropy source.

If we have the EFI_RNG_PROTOCOL, we can use that directly.

> And whether we should  be looking to extend 'arch_get_random_*' or
> 'random_get_entropy' for arm64, to provide seed/entropy using APIs
> like 'efi_random_get_seed'?

The EFI RNG protocol is only available during boot services, so we can't
call this during the usual operation of the kernel. The seed the stub
generates into the RNG table is already thrown into the entropy pool by
efi_config_parse_tables(). Look for LINUX_EFI_RANDOM_SEED_TABLE_GUID.

So any attemps to acquire a random number via the usual APIs will in
part be affects by this entropy, and nothing needs to be done to
arch_get_random_* to use this entropy.

Thanks,
Mark.
