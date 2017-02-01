From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 1 Feb 2017 21:11:37 +0000
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <1485981241.2560.20.camel@perches.com>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
 <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
 <20161019162222.GT9193@arm.com>
 <c578d5ac-ab8a-974a-bdd9-597b8c545583@redhat.com>
 <CAKv+Gu9G+r7eH0mhniH1+ucrHNiGBMFQdKfMOi=OmekapoBtUg@mail.gmail.com>
 <CAKv+Gu_kifdUOwKgGv1xqboPMjyYRhHwFXDye1HpBo9hQY+_Uw@mail.gmail.com>
 <1485975894.2560.13.camel@perches.com>
 <CAKv+Gu-Vc-+BDGAWOLJ79KqjL7ZW5vxUk=VW8MqEJyjO2fM6NQ@mail.gmail.com>
 <1485978587.2560.15.camel@perches.com>
 <CAKv+Gu9b_VqhgDQrznZ50zpttmpcV4D4S2mjaxfqxFqud3pMeg@mail.gmail.com>
 <1485981241.2560.20.camel@perches.com>
Message-ID: <CAKv+Gu-+cSE8p1uhhgf7Sh+Ms8NmO=fe9Md9X1YSVgYWD3RO9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2017 at 20:34, Joe Perches <joe@perches.com> wrote:
> On Wed, 2017-02-01 at 19:53 +0000, Ard Biesheuvel wrote:
>> On 1 February 2017 at 19:49, Joe Perches <joe@perches.com> wrote:
> []
>> > Or maybe add a BUILD_BUG_ON something like:
>> >
>> > #define order_base_2(n)                                                 \
>> > ({                                                                      \
>> >         typeof(n) _n = n;                                               \
>> >         BUILD_BUG_ON(__builtin_constant_p(_n) && _n < 0);               \
>> >         __builtin_constant_p(_n) ? (_n < 2 ? _n : ilog2((_n) - 1) + 1)) \
>> >                                  : __order_base_2(_n);                  \
>> > })
>> >
>>
>> This would interfere with the ability to use order_base_2() in
>> initializers for global variables.
>
> There aren't any as far as I can tell and would using
> order_base_2() for a global initializer make sense?
>

Why wouldn't it make sense?

In any case, we could also solve this by doing this instead

#define order_base_2(n)                        \
(                                              \
       __builtin_constant_p(n) ? (             \
               ((n) == 0 || (n) == 1) ? 0 :    \
               ilog2((n) - 1) + 1) :           \
       __order_base_2(n)                       \
)

which will emit the usual unresolveable __ilog2_NaN reference when
constants < 0 are passed to order_base_2()
