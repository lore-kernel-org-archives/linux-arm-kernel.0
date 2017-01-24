From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Jan 2017 18:13:32 +0000
Subject: [PATCH] arm64: kernel: do not mark reserved memory regions as
 IORESOURCE_BUSY
In-Reply-To: <20170124180109.GK1728@arm.com>
References: <1485277900-22730-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170124180109.GK1728@arm.com>
Message-ID: <CAKv+Gu9FV7pz8A+Hevq-FVYvrvkigqRBJDTRWA1c=UenTxLz8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2017 at 18:01, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 24, 2017 at 05:11:40PM +0000, Ard Biesheuvel wrote:
>> Memory regions marked as NOMAP should not be used for general allocation
>> by the kernel, and should not even be covered by the linear mapping
>> (hence the name). However, drivers or other subsystems (such as ACPI)
>> that access the firmware directly may legally access them, which means
>> it is also reasonable for such drivers to claim them by invoking
>> request_resource(). Currently, this is prevented by the fact that arm64's
>> request_standard_resources() marks reserved regions as IORESOURCE_BUSY.
>>
>> So drop the IORESOURCE_BUSY flag from these requests.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/setup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Did you find this my inspection, or has somebody reported a problem?
>

Hanjun (whom I forgot to cc) reported an issue with the ACPI EINJ
(error injection) code, which may call request_resource() on UEFI
reserved regions.
