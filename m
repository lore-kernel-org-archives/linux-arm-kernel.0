From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 31 Jul 2017 22:21:22 +0100
Subject: [PATCH v4] arm64: kernel: implement fast refcount checking
In-Reply-To: <CAGXu5jLZw1aK_wqSiAi3ddxPavOC1i47q4ahnwVnja=gsrLs2w@mail.gmail.com>
References: <20170731192251.12491-1-ard.biesheuvel@linaro.org>
 <CAGXu5jLZw1aK_wqSiAi3ddxPavOC1i47q4ahnwVnja=gsrLs2w@mail.gmail.com>
Message-ID: <CAKv+Gu-TH6qeotkYF+w+KcVJ6pavOYYEkmLKEQTUiDVAcQ1REQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2017 at 22:16, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 31, 2017 at 12:22 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> v4: Implement add-from-zero checking using a conditional compare rather than
>>     a conditional branch, which I omitted from v3 due to the 10% performance
>>     hit: this will result in the new refcount to be written back to memory
>>     before invoking the handler, which is more in line with the other checks,
>>     and is apparently much easier on the branch predictor, given that there
>>     is no performance hit whatsoever.
>
> So refcount_inc() and refcount_add(n, ...) will write 1 and n
> respectively, then hit the handler to saturate?

Yes, but this is essentially what occurs on overflow and sub-to-zero
as well: the result is always stored before hitting the handler. Isn't
this the case for x86 as well?

> That seems entirely
> fine to me: checking inc-from-zero is just a protection against a
> possible double-free condition. It's still technically a race, but a
> narrow race on a rare condition is better than being able to always
> win it.
>

Indeed.

> Nice!
>

Thanks!
