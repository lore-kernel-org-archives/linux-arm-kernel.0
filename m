From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Jul 2017 18:20:02 +0100
Subject: [RFC PATCH untested] arm64: kernel: implement fast refcount
 checking
In-Reply-To: <CAGXu5jLNB5dmA0o=n_nn=4NRu3LjuNf5PGRopATuRiq0aJ1ECA@mail.gmail.com>
References: <20170725114901.31403-1-ard.biesheuvel@linaro.org>
 <CAGXu5jLNB5dmA0o=n_nn=4NRu3LjuNf5PGRopATuRiq0aJ1ECA@mail.gmail.com>
Message-ID: <CAKv+Gu8L1M6iO-pELrVvouxgh+t1qjzD4fOu3Fw+LeiWMZWzpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 July 2017 at 18:13, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 25, 2017 at 4:49 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Hi all,
>>
>> I had a stab at porting the fast refcount checks to arm64. It is slightly
>> less straight-forward than x86 given that we need to support both LSE and
>> LL/SC, and fallback to the latter if running a kernel built with support
>> for the former on hardware that does not support it.
>>
>> It is build tested with and without LSE support, and boots fine on non-LSE
>> hardware in both cases.
>
> Ah! Very cool. Hopefully you and Li can compare notes; I think they've
> been working on an implementation too.
>

I wasn't aware of that.

>> Suggestions welcome as to how to test and/or benchmark this,
>
> I'll post a patch for LKDTM that I've been using. It's more
> comprehensive than the existing ATOMIC checks (which predated the
> refcount-only protection).
>

OK. One thing I couldn't figure out: is refcount_t signed or not? The
saturate tests set the initial value to UINT_MAX - 1, but this is
interpreted as a negative value and so the refcount manipulations that
are expected to succeed also fail in my case.
