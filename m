From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Nov 2018 00:18:33 +0100
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <20181107181047.fx4zbpdunfpwivjc@lakrids.cambridge.arm.com>
References: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
 <20181107181047.fx4zbpdunfpwivjc@lakrids.cambridge.arm.com>
Message-ID: <CAKv+Gu-_gcpRaMK3CLh14-wyjYbYNbHZ6bBMPGHWx-fGyFmujw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Arnd)

On 7 November 2018 at 19:10, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 07, 2018 at 06:10:38PM +0100, Ard Biesheuvel wrote:
>> On arm64, there is no need to add 2 bytes of padding to the start of
>> each network buffer just to make the IP header appear 32-bit aligned.
>>
>> Since this might actually adversely affect DMA performance some
>> platforms, let's override NET_IP_ALIGN to 0 to get rid of this
>> padding.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/processor.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 3e2091708b8e..6b0d4dff5012 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -24,6 +24,14 @@
>>  #define KERNEL_DS    UL(-1)
>>  #define USER_DS              (TASK_SIZE_64 - 1)
>>
>> +/*
>> + * On arm64 systems, unaligned accesses by the CPU are cheap, and so there is
>> + * no point in shifting all network buffers by 2 bytes just to make some IP
>> + * header fields appear aligned in memory, potentially sacrificing some DMA
>> + * performance on some platforms.
>> + */
>> +#define NET_IP_ALIGN 0
>
> Might it be better for core code to do this based on
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS?
>

In general, yes. But that will cause performance issues on ARMv6+,
since we will end up using ldrd instructions that require alignment
fixups.

In my opinion, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS should signify
that unaligned accessors are cheap, not that they are not required at
all.

At the moment it was introduced, it could mean either, but in the mean
time, Documentation has been added that suggests that
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS means that you can freely cast
pointers around and dereference them

For the crypto parts of the kernel, I suggested some fixes for this,
but I never got around to following up on the feedback.
https://marc.info/?l=linux-crypto-vger&m=153903336818193&w=2
