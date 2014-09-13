From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sat, 13 Sep 2014 12:52:21 -0700
Subject: [PATCH V3] arm: fix get_user BE behavior for target variable with
 size of 8 bytes
In-Reply-To: <CAA3XUr3Lvh8fosS1usdojYYr5rkcq3=i8L80iwe=efyztbus1A@mail.gmail.com>
References: <1409291466-4064-1-git-send-email-victor.kamensky@linaro.org>
 <1409291466-4064-2-git-send-email-victor.kamensky@linaro.org>
 <20140913081642.GS12361@n2100.arm.linux.org.uk>
 <CAA3XUr3Lvh8fosS1usdojYYr5rkcq3=i8L80iwe=efyztbus1A@mail.gmail.com>
Message-ID: <CAA3XUr19zyh684-PTZt0tyKi8TQD8N60aseZiJfkS3HWPDMz5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please see inline.

On 13 September 2014 09:55, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> Hi Russell,
>
> I am looking into it.
>
> Thanks,
> Victor
>
>
> On 13 September 2014 01:16, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Aug 28, 2014 at 10:51:06PM -0700, Victor Kamensky wrote:
>>> e38361d 'ARM: 8091/2: add get_user() support for 8 byte types' commit
>>> broke V7 BE get_user call when target var size is 64 bit, but '*ptr' size
>>> is 32 bit or smaller. e38361d changed type of __r2 from 'register
>>> unsigned long' to 'register typeof(x) __r2 asm("r2")' i.e before the change
>>> even when target variable size was 64 bit, __r2 was still 32 bit.
>>> But after e38361d commit, for target var of 64 bit size, __r2 became 64
>>> bit and now it should occupy 2 registers r2, and r3. The issue in BE case
>>> that r3 register is least significant word of __r2 and r2 register is most
>>> significant word of __r2. But __get_user_4 still copies result into r2 (most
>>> significant word of __r2). Subsequent code copies from __r2 into x, but
>>> for situation described it will pick up only garbage from r3 register.
>>>
>>> Special __get_user_64t_(124) functions are introduced. They are similar to
>>> corresponding __get_user_(124) function but result stored in r3 register
>>> (lsw in case of 64 bit __r2 in BE image). Those function are used by
>>> get_user macro in case of BE and target var size is 64bit.
>>>
>>> Also changed __get_user_lo8 name into __get_user_32t_8 to get consistent
>>> naming accross all cases.
>>>
>>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> This patch isn't quite right, since it causes compile regressions:
>>
>> ERROR: "__get_user_64t_4" [fs/ext4/ext4.ko] undefined!
>> ERROR: "__get_user_64t_4" [fs/cifs/cifs.ko] undefined!
>>
>> This was noticed by Olof's builder, with his allmodconfig.  I don't
>> have the configuration to reproduce these failures.
>>
>> Could you look into these please?

I've posted proposed fix as [1]. The issue was that few
new asm functions used by new version of get_user macro were
not exported. It got exposed with allmodconfig for big endian
image. I am sorry about the breakage. It is very good that
Olof's builder tests big endian images build. Appreciate that
very much.

What are next steps, should I put [1] into your patch system
(if you or someone else can Ack the fix)? Or do I need repost
revised original diff that would include [1] fix? Please advise.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287238.html
     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287239.html

>>
>> --
>> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
>> according to speedtest.net.
