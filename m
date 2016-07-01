From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 1 Jul 2016 17:34:46 +0200
Subject: [PATCH 2/2] arm64: document that pending SErrors are not allowed
 at kernel entry
In-Reply-To: <20160701152515.GB17071@leverpostej>
References: <1467385291-9880-1-git-send-email-ard.biesheuvel@linaro.org>
 <1467385291-9880-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160701152515.GB17071@leverpostej>
Message-ID: <CAKv+Gu_mJzY9YQtibOcvyqMLRNjfxQH5M4eJ=gDU1Uv7hqeGeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2016 at 17:25, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jul 01, 2016 at 05:01:31PM +0200, Ard Biesheuvel wrote:
>> Our current strategy to deal with pending SErrors at boot is to panic.
>> So let's mention in our boot protocol documentation that no SErrors
>> should be pending when handing over to the kernel.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/arm64/booting.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
>> index 8d0df62c3fe0..75dcfead1a0c 100644
>> --- a/Documentation/arm64/booting.txt
>> +++ b/Documentation/arm64/booting.txt
>> @@ -154,8 +154,9 @@ Before jumping into the kernel, the following conditions must be met:
>>    x3 = 0 (reserved for future use)
>>
>>  - CPU mode
>> -  All forms of interrupts must be masked in PSTATE.DAIF (Debug, SError,
>> -  IRQ and FIQ).
>> +  All forms of exceptions must be masked in PSTATE.DAIF (Debug, SError,
>> +  IRQ and FIQ), and any pending SError exceptions must be taken by the
>> +  boot loader or firmware before handing over to the kernel.
>
> That can be read to mean that a loader should silently swallow SError,
> which isn't quite what we want (that no SError ever occurs). I don't
> have a better wording to suggest, unfortunately. :/
>

I don't think it is up to us to mandate how the firmware should be
dealing with early SErrors, as long as none are pending when we enter
the kernel.
