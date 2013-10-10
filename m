From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Thu, 10 Oct 2013 23:36:08 +0300
Subject: [RFC PATCH] ARM: kexec: Assemble relocate code in ARM mode
In-Reply-To: <20131010141238.GA4081@localhost.localdomain>
References: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
 <20131010141238.GA4081@localhost.localdomain>
Message-ID: <CAArO44tUpwsFRrF2TsaFKyD2PVkdZTWpM1GpZVq3-wjLN=0+dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2013 17:12, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, Oct 09, 2013 at 11:57:03PM +0300, Taras Kondratiuk wrote:
>> In Thumb2 kernel (CONFIG_THUMB2_KERNEL) kexec's relocate code is assembled
>> in Thumb2 mode, but cpu_v7_reset() jumps to this code in ARM state,
>> because its address is page aligned and has 0 in LSB.
>>
>> Assemble this code in ARM mode to fix the issue.
>
> I think the actual issue here is that relocate_new_kernel is not properly
> annotated as a function symbol.
>
> Can you remove the explicit label declaration and try the following:
>
>         #include <linux/linkage.h>
>
>         ENTRY(relocate_new_kernel)
>
>         /* body of relocate_new_kernel */
>
>         ENDPROC(relocate_new_kernel)
>
>
> Without this, the linker will treat it as a random pointer to data and
> never set the Thumb bit.
>
> This fails in precisely the same was as an ordinary function call
> would fail if the destination function doesn't have the needed
> annotation.
>
>
> There should be no need to switch to ARM if the kernel is just jumping
> to itself...

I think it won't help, because here is no direct jump to this label.
This code gets copied to a new page and jump is done to the beginning
of that page.
