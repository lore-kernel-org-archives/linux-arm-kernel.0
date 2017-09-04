From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Sep 2017 20:17:40 +0100
Subject: [PATCH v2 21/29] ARM: kernel: use PC relative symbol references
 in suspend/resume code
In-Reply-To: <nycvar.YSQ.7.76.1709041417250.8603@knanqh.ubzr>
References: <20170903120757.14968-1-ard.biesheuvel@linaro.org>
 <20170903120757.14968-22-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1709041417250.8603@knanqh.ubzr>
Message-ID: <CAKv+Gu9w6DH9o6-hBRzEKcsovd5TK_NzpygnugnrSMNFrkww+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2017 at 19:24, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 3 Sep 2017, Ard Biesheuvel wrote:
>
>> Replace some unnecessary absolute references with relative ones. Also,
>> to prepare for runtime relocation, which occurs with the caches on,
>> defer taking the absolute address of cpu_resume_after_mmu() until after
>> the MMU is enabled.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> What's the point of that last hunk? I understand you load the address
> after the mMU is on. But you should be coming back from a sleep and
> caches ought to be clean at that point. Not that it is a bad thing to do
> but I don't understand your reason for it.
>

I simply attempted to eliminate all uses of relocated quantities with
the caches off, but you are correct that this is only necessary for
boot and not for suspend/resume. This is actually somewhat of a
relief, since there is so much SOC specific suspend/resume code under
arch/arm, and the boot code is mostly shared.
