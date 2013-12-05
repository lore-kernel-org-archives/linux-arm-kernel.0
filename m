From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Thu, 5 Dec 2013 18:16:35 +0100
Subject: [GIT PULL] Cacheflush updates for 3.12
In-Reply-To: <1386256471.3525.13.camel@linaro1.home>
References: <20130812173155.GI25995@mudshark.cambridge.arm.com>
 <CAH9NwWd1AfN_YnO-fj94+wTbE8768H518=EndVcX=dFCV9WESg@mail.gmail.com>
 <20131204161329.GA14145@mudshark.cambridge.arm.com>
 <1386253407.3525.8.camel@linaro1.home>
 <1386256471.3525.13.camel@linaro1.home>
Message-ID: <CAH9NwWdh-kT8Pgp-CU9x5HiA_C0aKaSDKEO_8OVaYfvpxH2u=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/5 Jon Medhurst (Tixy) <tixy@linaro.org>:
> On Thu, 2013-12-05 at 14:23 +0000, Jon Medhurst (Tixy) wrote:
>> On Wed, 2013-12-04 at 16:13 +0000, Will Deacon wrote:
>> > took another look at that patch and can't see anything obviously wrong
>> > with it.
>>
>> If the memory region isn't guaranteed to be page aligned then doesn't it
>> flush up to PAGE_SIZE-1 more bytes than requested and so exceed the
>> bounds check in do_cache_op? Fixing this as below _appears_ to stop the
>> Browser crashes I'm seeing (still doing some more testing)...
>
> Actually, a smaller patch and one which avoids the possibility of
> arithmetic owerflow is...
>
> From: Jon Medhurst <tixy@linaro.org>
> Date: Thu, 5 Dec 2013 14:29:24 +0000
> Subject: [PATCH] ARM: cacheflush: correctly limit range of memory region
>  being flushed
>
> The __do_cache_op function operates with a 'chunk' size of one page
> but fails to limit the size of the final chunk so as to not exceed
> the specified memory region. Fix this.
>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>  arch/arm/kernel/traps.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index dbf0923..7940241 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -509,9 +509,10 @@ static inline int
>  __do_cache_op(unsigned long start, unsigned long end)
>  {
>         int ret;
> -       unsigned long chunk = PAGE_SIZE;
>
>         do {
> +               unsigned long chunk = min(PAGE_SIZE, end - start);
> +
>                 if (signal_pending(current)) {
>                         struct thread_info *ti = current_thread_info();
>
> --
> 1.7.10.4
>
>

I am running my test overnight with this patch... stay tuned.

greets
--
Christian Gmeiner, MSc
