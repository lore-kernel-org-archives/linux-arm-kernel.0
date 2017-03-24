From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 24 Mar 2017 11:49:55 +0100
Subject: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
In-Reply-To: <1490348427.22814.19.camel@mhfsdcap03>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
 <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
 <13a83728-0031-5683-c371-4b517df32299@intel.com>
 <1490344369.22814.10.camel@mhfsdcap03>
 <03d54000-9ced-1b31-df80-d254f02433db@intel.com>
 <1490348427.22814.19.camel@mhfsdcap03>
Message-ID: <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2017 at 10:40, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Fri, 2017-03-24 at 11:19 +0200, Adrian Hunter wrote:
>> On 24/03/17 10:32, Chaotian Jing wrote:
>> > On Fri, 2017-03-24 at 09:52 +0200, Adrian Hunter wrote:
>> >> On 24/03/17 08:19, Chaotian Jing wrote:
>> >>> this patch is refine for 'commit c6dbab9cb58f ("mmc: core: Hold re-tuning
>> >>> during switch commands")'
>> >>> Since it has 3 retries at max for CMD6, if the first CMD6 got CRC error,
>> >>> then should do re-tune before the next CMD6 was sent.
>> >>>
>> >>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>> >>> ---
>> >>>  drivers/mmc/core/mmc_ops.c |    3 +--
>> >>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> >>> index fe80f26..6931927 100644
>> >>> --- a/drivers/mmc/core/mmc_ops.c
>> >>> +++ b/drivers/mmc/core/mmc_ops.c
>> >>> @@ -534,8 +534,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>> >>>   bool use_r1b_resp = use_busy_signal;
>> >>>   unsigned char old_timing = host->ios.timing;
>> >>>
>> >>> - mmc_retune_hold(host);
>> >>> -
>> >>>   /*
>> >>>    * If the cmd timeout and the max_busy_timeout of the host are both
>> >>>    * specified, let's validate them. A failure means we need to prevent
>> >>> @@ -567,6 +565,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>> >>>           cmd.sanitize_busy = true;
>> >>>
>> >>>   err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>> >>> + mmc_retune_hold(host);
>> >>
>> >> That is not how mmc_retune_hold() works, you need mmc_retune_hold_now() as
>> >> it is here:
>> >>
>> >>    https://marc.info/?l=linux-mmc&m=148940903816582
>> >>
>> >> But using "retries" with commands that have busy-waiting on the data line
>> >> doesn't make much sense anyway.  Particularly with CRC errors, I would
>> >> expect the card is actually busily doing the switch and we need only to wait
>> >> for it.  The same can be true for timeout errors.  For some CMD6 we might
>> >> need to send CMD12 if the card is busy after an error.  I would prefer an
>> >> explicit attempt at recovery from CMD6 errors.
>> >>
>> >
>> > It's the host driver's responsibility to ensure card is not in busy
>> > state before issue the next R1B command, or the MMC core layer needs do
>> > extra check/waiting before issue a R1B command.
>>
>> Better to deal with cards stuck in busy from the places where busy-waiting
>> is expected.
>>
> Yes, if a R1B command got response CRC error, we can do busy-waiting in
> the error hander funtion(mmc_wait_for_req_done())

That would introduce too big changes and I am sure it will cause/hide
other problems.

If there is a problem in __mmc_switch(), let's try to fix it there first.

>> > I think the purpose of "re-tune" is trying to cover particular case(eg.
>> > voltage fluctuate or EMI or some glitch of host/device which caused CRC
>> > error)
>>
>> No, re-tuning is to compensate for drift caused primarily by temperature change.
>>
> Yes, by JEDEC spec, temperature change cause timing drift of EMMC
> device, but, as you mentioned, maybe I have a hardware problem of host,
> but needs Software to cover it. so that we are doing our best to do
> re-tune if got CRC error. if could recover it, then  it's better than
> system hung.

Exactly in what cases do you get CRC errors for CMD6. We need a full
cmd log to understand and to help.

>> > error) , but in such cases, too many cases are disable re-tune function
>> > by mmc_retune_hold(), for example, in this case, if a response CRC error
>> > got then we never have chance to recover it. then cause system cannot
>> > access emmc or suspend/resume fail.
>>
>> Maybe you have a hardware problem.

There is no way I am going to accept patches touching this part of the
mmc core, without providing real evidence for how it solves a problem.
To me, it seems like you are applying a workaround for another issue.

Again, try to provide us with some more data and logs, then perhaps we
can help narrow down the issues.

Kind regards
Uffe
