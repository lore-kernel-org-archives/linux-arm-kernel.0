From: keescook@chromium.org (Kees Cook)
Date: Wed, 10 Aug 2016 11:47:08 -0700
Subject: [PATCH] ARM: VDSO: put read only/mostly objects into proper
 sections
In-Reply-To: <20160810175958.4dcfc5e3@xhacker>
References: <1470820187-1032-1-git-send-email-jszhang@marvell.com>
 <20160810175958.4dcfc5e3@xhacker>
Message-ID: <CAGXu5jJCjk-3nBcMamJhpK7m+qfcdu6mvD6heYR=gJkAO40Jxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 2:59 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> + Kees
>
> On Wed, 10 Aug 2016 17:09:47 +0800 wrote:
>
>> vdso_data_mapping is never modified, so mark it as const.
>>
>> vdso_data_page and vdso_text_mapping are initialized by vdso_init(),
>> thereafter are mostly read during vdso special mapping handling.
>>
>> The fact that they are mostly read and not written to makes them
>> candidates for __read_mostly declarations.
>
> Inspired by Kees's "arm: apply more __ro_after_init", is it better
> to mark these vars as __ro_after_init?

Yeah, if they're not written outside of __init, please do. It would be
a nice complement to commit 11bf9b865898 ("ARM/vdso: Mark the vDSO
code read-only after init").

-Kees

>
> Thanks,
> Jisheng
>
>>
>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>> ---
>>  arch/arm/kernel/vdso.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
>> index 994e971..c946092 100644
>> --- a/arch/arm/kernel/vdso.c
>> +++ b/arch/arm/kernel/vdso.c
>> @@ -47,13 +47,13 @@ unsigned int vdso_total_pages __read_mostly;
>>  static union vdso_data_store vdso_data_store __page_aligned_data;
>>  static struct vdso_data *vdso_data = &vdso_data_store.data;
>>
>> -static struct page *vdso_data_page;
>> -static struct vm_special_mapping vdso_data_mapping = {
>> +static struct page *vdso_data_page __read_mostly;
>> +static const struct vm_special_mapping vdso_data_mapping = {
>>       .name = "[vvar]",
>>       .pages = &vdso_data_page,
>>  };
>>
>> -static struct vm_special_mapping vdso_text_mapping = {
>> +static struct vm_special_mapping vdso_text_mapping __read_mostly = {
>>       .name = "[vdso]",
>>  };
>>
>



-- 
Kees Cook
Nexus Security
