From: mostawesomedude@gmail.com (Corbin Simpson)
Date: Fri, 7 May 2010 05:01:37 -0700
Subject: [PATCH] arch/arm: Use constants instead of magic numbers in
	do_gettimeofday.
In-Reply-To: <20100506012208.GY6684@trinity.fluff.org>
References: <1273108792-8097-1-git-send-email-MostAwesomeDude@gmail.com>
	<20100506012208.GY6684@trinity.fluff.org>
Message-ID: <s2ie7bd23c31005070501u550464a4v6b1795d2c03a6e7d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 5, 2010 at 6:22 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, May 05, 2010 at 06:19:52PM -0700, Corbin Simpson wrote:
>> Part of the Didj patch.
>
> how about a better description here please.
>
>> Signed-off-by: Corbin Simpson <MostAwesomeDude@gmail.com>
>> ---
>> ?arch/arm/kernel/time.c | ? ?6 +++---
>> ?1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>> index 2875380..5cb4ff9 100644
>> --- a/arch/arm/kernel/time.c
>> +++ b/arch/arm/kernel/time.c
>> @@ -104,12 +104,12 @@ void do_gettimeofday(struct timeval *tv)
>> ? ? ? ? ? ? ? seq = read_seqbegin_irqsave(&xtime_lock, flags);
>> ? ? ? ? ? ? ? usec = system_timer->offset();
>> ? ? ? ? ? ? ? sec = xtime.tv_sec;
>> - ? ? ? ? ? ? usec += xtime.tv_nsec / 1000;
>> + ? ? ? ? ? ? usec += xtime.tv_nsec / NSEC_PER_USEC;
>> ? ? ? } while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
>>
>> ? ? ? /* usec may have gone up a lot: be safe */
>> - ? ? while (usec >= 1000000) {
>> - ? ? ? ? ? ? usec -= 1000000;
>> + ? ? while (usec >= ?USEC_PER_SEC) {
>> + ? ? ? ? ? ? usec -= USEC_PER_SEC;
>> ? ? ? ? ? ? ? sec++;
>> ? ? ? }
>>
>> --
>> 1.6.6.1

Sorry, been out with a bad cold. :C

What would be better? It's a fairly trivial patch that is, at least in
my mind, fully explained by the title of the commit. Constants should
be preferred to magic numbers, right? The patch comment is a reminder
that this comes from the Leapfrog Didj code dump, and the original
author is unknown, but probably works at Cozybits.

Would this work?

Prefer constants to magic numbers where applicable and appropriate.
With this change, the code is almost self-explanatory and much more
readable.
Part of the Leapfrog Didj code dump. Authorship is unknown.

~ C.

-- 
When the facts change, I change my mind. What do you do, sir? ~ Keynes

Corbin Simpson
<MostAwesomeDude@gmail.com>
