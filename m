From: lho@apm.com (Loc Ho)
Date: Tue, 19 May 2015 12:57:32 -0700
Subject: [PATCH v10 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <20150519170308.GL4641@pd.tnic>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-2-git-send-email-lho@apm.com>
 <20150519170308.GL4641@pd.tnic>
Message-ID: <CAPw-ZT=mTpt_vz+e=rM5ywK8feNKkJQrpEWg=noRCziJ0840TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 19, 2015 at 10:03 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, May 18, 2015 at 05:24:37PM -0600, Loc Ho wrote:
>> Add an stub atomic_scrub function and enable EDAC for arm64.
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> ---
>>  arch/arm64/Kconfig            |    1 +
>>  arch/arm64/include/asm/edac.h |   28 ++++++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/edac.h
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4269dba..577078f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -22,6 +22,7 @@ config ARM64
>>       select BUILDTIME_EXTABLE_SORT
>>       select CLONE_BACKWARDS
>>       select COMMON_CLK
>> +     select EDAC_SUPPORT
>>       select CPU_PM if (SUSPEND || CPU_IDLE)
>>       select DCACHE_WORD_ACCESS
>>       select GENERIC_ALLOCATOR
>> diff --git a/arch/arm64/include/asm/edac.h b/arch/arm64/include/asm/edac.h
>> new file mode 100644
>> index 0000000..683495b
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/edac.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * ARM64 EDAC Header File
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#ifndef __ASM_EDAC_H
>> +#define __ASM_EDAC_H
>> +
>> +/*
>> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
>> + */
>> +static inline void atomic_scrub(void *va, u32 size)
>> +{
>> +     /* Stub function for now until an ARM64 HW has a way to test it. */
>> +     WARN_ONCE(1, "not implemented");
>> +}
>
> So you're adding this empty function, it issues a warning for which the
> user can't really do anything about and on top of that, it is not even
> used in this patchset.
>
> So please kill it from this submission.

This was discussed here
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/326986.html.
Without this, it will have compiler error as this function is called
by.function edac_mc_scrub_block in file drivers/edac/edac_mc.c.

>
> You can add a full-fledged version later after you test it successfully
> on real hw.

Our platform don't use it as it has HW scrub support.

-Loc
