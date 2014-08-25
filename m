From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sun, 24 Aug 2014 22:35:37 -0700
Subject: [RFC PATCH] arm: fix get_user BE behavior for target variable
 with size of 8 bytes
In-Reply-To: <20140821082740.GI30401@n2100.arm.linux.org.uk>
References: <1408598949-23050-1-git-send-email-victor.kamensky@linaro.org>
 <20140821082740.GI30401@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr0SuiLNyzB1jhJ-EM+DCjtxNLxsD=+Ujv4GVmQYk13eGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 21 August 2014 01:27, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 20, 2014 at 10:29:09PM -0700, Victor Kamensky wrote:
>> e38361d 'ARM: 8091/2: add get_user() support for 8 byte types' commit
>> broke V7 BE get_user call when target var size is 64 bit, but '*ptr' size
>> is 32 bit or smaller. e38361d changed type of __r2 from 'register
>> unsigned long' to 'register typeof(x) __r2 asm("r2")' i.e before the change
>> even when target variable size was 64 bit, __r2 was still 32 bit.
>> But after e38361d commit, for target var of 64 bit size, __r2 became 64
>> bit and now it should occupy 2 registers r2, and r3. The issue in BE case
>> that r3 register is least significant word of __r2 and r2 register is most
>> significant word of __r2. But __get_user_4 still copies result into r2 (most
>> significant word of __r2). Subsequent code copies from __r2 into x, but
>> for situation described it will pick up only garbage from r3 register.
>>
>> It was discovered during 3.17-rc1 V7 BE KVM testing. Simple test case below.
>> Note it works in LE case because r2 in LE case is still least significant
>> word.
>>
>> Proposed fix uninspiringly restores previous code but now in individual
>> branches of switch statement for '*(__p)' byte sizes 1, 2, 4 and have
>> newer code only for sizeof(*(__p)) == 8. Looking for may be better ideas
>> how to fix the issue.
>
> The only down side of this is that it quadruples the number of warnings
> when get_user() is used incorrectly:
>
> t-getuser.c: In function ?test_wrong?:
> t-getuser.c:346:388: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
> t-getuser.c:346:581: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
> t-getuser.c:346:774: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
> t-getuser.c:346:1100: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
>
> as we now have four assignments instead of one.  It would be nice to have
> proper behaviour here, with just one warning.

It brings interesting aspect to the issue. I have not thought about
it from this angle.

I've sent another variant, idea of which was suggested by Daniel
Thompson. Daniel sent private note to me. As I understood,
he is traveling now and does not have much capacity to look at
it till the next week.

The new patch introduces essentially copy of __get_user_(124)
functions but specially tailored to BE 64bit __r2 cases where result
should be stored in $r3 register (vs $r2).

Thanks,
Victor

> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
