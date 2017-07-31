From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 31 Jul 2017 14:59:32 +0100
Subject: [PATCH v3] arm64: kernel: implement fast refcount checking
In-Reply-To: <a0b6690d-039e-04ed-9847-b4521935375f@huawei.com>
References: <20170731120144.14214-1-ard.biesheuvel@linaro.org>
 <a0b6690d-039e-04ed-9847-b4521935375f@huawei.com>
Message-ID: <CAKv+Gu9nQf=+HcN0c3Uy3YjDqnh0Xci3N-LqyAVw-gjRPRWmXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2017 at 14:17, Li Kun <hw.likun@huawei.com> wrote:
>
>
> ? 2017/7/31 20:01, Ard Biesheuvel ??:
>>
>> +static __always_inline __must_check bool refcount_add_not_zero(unsigned
>> int i,
>> +                                                              refcount_t
>> *r)
>> +{
>> +       unsigned long tmp;
>> +       int result;
>> +
>> +       asm volatile("// refcount_add_not_zero \n"
>> +"      prfm            pstl1strm, %2\n"
>> +"1:    ldxr            %w[val], %2\n"
>> +"      cbz             %w[val], 2f\n"
>> +"      adds            %w[val], %w[val], %w[i]\n"
>> +"      stxr            %w1, %w[val], %2\n"
>> +"      cbnz            %w1, 1b\n"
>> +       REFCOUNT_POST_CHECK_NEG
>> +"2:"
>> +       : [val] "=&r" (result), "=&r" (tmp), "+Q" (r->refs.counter)
>> +       : REFCOUNT_INPUTS(&r->refs) [i] "Ir" (i)
>> +       : REFCOUNT_CLOBBERS);
>> +
>> +       return result != 0;
>> +}
>> +
>
> Could we use "cas" here instead of ll/sc ?
>

I don't see how, to be honest.

Compare and swap only performs the store if the expected value is in
the memory location. In this case, we don't know the old value, we
only know we need to do something special if it is 0.
