From: masami.hiramatsu@linaro.org (Masami Hiramatsu)
Date: Tue, 27 Feb 2018 14:07:00 +0900
Subject: [PATCH 2/2] lkdtm: fix irq handler entry for arm64
In-Reply-To: <CAGXu5j+FZ4085UkjPQXnmTDhFMSdmZ7Rk5YXZ+p4OkyEfCOB1w@mail.gmail.com>
References: <20180201093459.20477-1-takahiro.akashi@linaro.org>
 <20180201093459.20477-3-takahiro.akashi@linaro.org>
 <CAGXu5j+FZ4085UkjPQXnmTDhFMSdmZ7Rk5YXZ+p4OkyEfCOB1w@mail.gmail.com>
Message-ID: <CAA93ih0CUzJVhpOpbtcH_REZOO_pSjBV1sJhjnY6vhySP3fB3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2018-02-27 12:57 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Thu, Feb 1, 2018 at 1:34 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> Arm64 doesn't have "do_IRQ" function, instead *handle_arch_irq, which is
>> initialized by irq chip (gic), is called from exception entry.
>> This patch fixes this problem.
>
> As in, this symbol is not known a lkdtm setup time? Hm, seems like
> we'd want a more generalized approach here.
>
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  drivers/misc/lkdtm_core.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
>> index ba92291508dc..e20343543053 100644
>> --- a/drivers/misc/lkdtm_core.c
>> +++ b/drivers/misc/lkdtm_core.c
>> @@ -249,13 +249,29 @@ static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
>>         if (lkdtm_kprobe != NULL)
>>                 unregister_kprobe(lkdtm_kprobe);
>>
>> +       if (IS_ENABLED(CONFIG_ARM64) &&
>> +                       !strcmp(crashpoint->name, "INT_HARDWARE_ENTRY")) {
>> +               extern void (*handle_arch_irq)(struct pt_regs *regs);
>
> I don't like this extern -- can handle_arch_irq be properly exported somewhere?
>
>> +               crashpoint->kprobe.addr = (kprobe_opcode_t *)*handle_arch_irq;
>
> I don't think the * is needed here: it's already a function pointer.

Since the addr is no void *, gcc warns this assignment from
incompatible pointer type.
Hmm, maybe better casting it to void *.

>
>> +               /*
>> +                * Instantiating kprobe.symbol_name here, say
>> +                * with lookup_symbol_name(*handle_arch_irq),
>> +                * would cause register_kprobe() to fail.
>> +                */
>> +               crashpoint->kprobe.symbol_name = NULL;
>
> Is kprobe.addr sufficient for register_kprobe?

Yes, if symbol_name is NULL, register_kprobe uses only kprobe.addr to
find the probe point.

Thank you,

-- 
Masami Hiramatsu
