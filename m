From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 25 Sep 2013 18:29:52 +0900
Subject: [PATCH] arm64: avoid multiple evaluation of ptr in
 get_user/put_user()
In-Reply-To: <20130924142553.GG25907@arm.com>
References: <524154C2.1080303@linaro.org> <20130924142553.GG25907@arm.com>
Message-ID: <5242AD10.3070001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

Thank you for your comments, and let me send a revised patch again
because my original message didn't reach MLs due to my screw-up.

BTW, I will submit a patch of ftrace support on arm64 once gcc supports
gprof (-pg) options.

-Takahiro AKASHI

On 09/24/2013 11:25 PM, Catalin Marinas wrote:
> On Tue, Sep 24, 2013 at 10:00:50AM +0100, AKASHI Takahiro wrote:
>> get_user() is defined as a function macro in arm64, and trace_get_user()
>> calls it as followed:
>>       get_user(ch, ptr++);
>> Since the second parameter occurs twice in the definition, 'ptr++' is
>> unexpectedly evaluated twice and trace_get_user() will generate a bogus
>> string from user-provided one. As a result, some ftrace sysfs operations,
>> like "echo FUNCNAME > set_ftrace_filter," hit this case and eventually fail.
>> This patch fixes the issue both in get_user() and put_user().
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>    arch/arm64/include/asm/uaccess.h |   12 ++++++++----
>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index edb3d5c..bbeab83 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -166,9 +166,11 @@ do {									\
>>     #define get_user(x, ptr)						\
>>    ({									\
>> +	__typeof__(*(ptr)) *optr = (ptr);				\
>> +									\
>>    	might_fault();							\
>> -	access_ok(VERIFY_READ, (ptr), sizeof(*(ptr))) ?			\
>> -		__get_user((x), (ptr)) :				\
>> +	access_ok(VERIFY_READ, optr, sizeof(*optr)) ?			\
>> +		__get_user((x), optr) :					\
>>    		((x) = 0, -EFAULT);					\
>>    })
>>    @@ -227,9 +229,11 @@ do {									\
>>     #define put_user(x, ptr)						\
>>    ({									\
>> +	__typeof__(*(ptr)) *optr = (ptr);				\
>> +									\
>>    	might_fault();							\
>> -	access_ok(VERIFY_WRITE, (ptr), sizeof(*(ptr))) ?		\
>> -		__put_user((x), (ptr)) :				\
>> +	access_ok(VERIFY_WRITE, optr, sizeof(*optr)) ?			\
>> +		__put_user((x), optr) :					\
>>    		-EFAULT;						\
>>    })
>>    -- 1.7.9.5
>
> BTW, please use git send-email or other email client, the diff above is
> heavily corrupted (too many spaces at the beginning of the line, removed
> empty lines; I managed to fix it up this time but only because it was a
> small patch).
>
