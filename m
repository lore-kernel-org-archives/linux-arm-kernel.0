From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Jun 2017 21:54:48 +0200
Subject: [PATCH 0/2] arm64: avoid KASAN stack overflows
In-Reply-To: <20170607161816.GA8330@leverpostej>
References: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
 <07c30069-84f5-be51-85ab-c3c84eea9463@virtuozzo.com>
 <20170607161816.GA8330@leverpostej>
Message-ID: <CAK8P3a0LuQ4axCE3zy2uU_WZMDMhFsok4PebcgPmQwffwfi+xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 7, 2017 at 6:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jun 07, 2017 at 07:12:30PM +0300, Andrey Ryabinin wrote:
>> On 06/07/2017 06:35 PM, Mark Rutland wrote:
>> > I recently tried building the kernel with a GCC 7.1.0 toolchain, and
>> > encountered a number of new and surprising failures on kernels buitl with
>> > KASAN.
>> >
>> > It looks like this is due to stack instrumentation, which my prior toolchain
>> > didn't support. KASAN's stack instrumentation significantly bloats the stack
>> > significantly, leading to stack overflows and subsequent failures as a result
>> > of the data corruption they cause.
>>
>> This is caused by -fsanitize-address-use-after-scope which is added in gcc 7.
>> Arnd reported that sometimes it causes enormously huge stack growth.
>
> Ah. Sorry for the bogus attribution, then.
>
>> Given that we haven't found any single use-after-scope bug so far, I wouldn't object
>> removing it completely.
>
> FWIW, I saw a single use-after-scope splat when testing with syzkaller
> (prior to these patches), but that may have been a result of things
> going wrong after a stack overflow. Unfortuantely I threw away all of
> the results of that run.
>
> I'll see if anything triggers overnight with this patch.
>
> Otherwise, I'm also happy for use-after-scope checks to be disabled.

I've been trying to get my patch series updated for a while, sorry for
taking so long with it.

My latest state still has use-after-scope enabled with a separate
CONFIG_KASAN_EXTRA option that is muturally exclusive with
CONFIG_KMEMCHECK (the combination of the two is particularly
bad), and it increases the default stack warning size limit to 3072
bytes. With the other patches I have for reducing the stack frame
sizes, the default 64-bit warning limit can get lowered to 1280
(this took only a few simple patches to catch all the warnings,
surprisingly), and with the regular CONFIG_KASAN the limit
gets increased a little to 1536.

       Arnd
