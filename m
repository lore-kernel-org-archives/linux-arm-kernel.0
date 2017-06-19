From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Mon, 19 Jun 2017 10:32:38 -0700
Subject: [PATCH v3 0/4] Generalize fncpy availability
In-Reply-To: <20170619122444.GJ10246@leverpostej>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170619122444.GJ10246@leverpostej>
Message-ID: <c8b7789c-38fb-6793-050f-7c60ccb8ca17@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2017 05:24 AM, Mark Rutland wrote:
> On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
>> Hi all,
> 
> Hi Florian,
> 
>> This patch series makes ARM's fncpy() implementation more generic (dropping the
>> Thumb-specifics) and available in an asm-generic header file.
>>
>> Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.
>>
>> Changes in v3 (thanks Doug!):
>> - correct include guard names in asm-generic/fncpy.h to __ASM_FNCPY_H
>> - utilize Kbuild to provide the fncpy.h header on ARM64
>>
>> Changes in v2:
>> - leave the ARM implementation where it is
>> - make the generic truly generic (no)
>>
>> This is helpful in making SoC-specific power management code become true drivers
>> that can be shared between different architectures.
> > Could you elaborate on what this is needed for?

Several uses cases come to mind:

- it could be used as a trampoline code prior to entering S2 for systems
that do not support PSCI 1.0

- any code that has a specific need to relocate a performance, security
sensitive code into SRAM and use it as another pool of memory.

> 
> My understanding was that on 32-bit, this was to handle idle / suspend
> cases, whereas for arm64 that should be handled by PSCI.

For systems that support PSCI 1.0, I agree, but it may not be possible
to update those systems easily, still use case 2 is completely valid.

> 
> what exactly do you intend to use this for?

At the moment we use it to enter S2 on ARM64 systems (ARCH_BRCMSTB)
which are PSCI 0.2 only. And yes, we do have a plan to evaluate
upgrading to PSCI 1.0, but in general, any SoC which as an addressable
SRAM could use it for whatever purpose it sees fit.
-- 
Florian
