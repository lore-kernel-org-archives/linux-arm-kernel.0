From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 26 Apr 2016 16:55:17 +0900
Subject: [PATCH] ARM: cache-uniphier: activate ways for secondary CPUs
In-Reply-To: <10871675.TbbhfWgNkx@wuerfel>
References: <1460703947-12539-1-git-send-email-yamada.masahiro@socionext.com>
 <51817650.ZWFPAKxQiK@wuerfel>
 <CAK7LNAS4gYS3VswmnUj6OS0mBpYeSKLPnV26mO0yRiEtwEDoww@mail.gmail.com>
 <10871675.TbbhfWgNkx@wuerfel>
Message-ID: <CAK7LNATAEj4q+EiS=zDQ-7D4wBzn4-CyuevKpjiVt8JhZLdqng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-04-26 16:52 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 26 April 2016 09:55:35 Masahiro Yamada wrote:
>> Hi Arnd,
>>
>> 2016-04-26 7:13 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Friday 15 April 2016 16:05:46 Masahiro Yamada wrote:
>> >> This outer cache allows to control active ways independently for
>> >> each CPU, but currently nothing is done for secondary CPUs.  In
>> >> other words, all the ways are locked for secondary CPUs by default.
>> >> This commit fixes it to fully bring out the performance of this
>> >> outer cache.
>> >>
>> >> There would be two possible ways to achieve this:
>> >>
>> >> [1] Each CPU initializes active ways for itself.  This can be done
>> >>     via the SSCLPDAWCR register.  This is a banked register, so each
>> >>     CPU sees a different instance of the register.
>> >>
>> >> [2] The master CPU initializes active ways for all the CPUs.  This
>> >>     is available via SSCDAWCARMR(N) registers.  They are mapped at
>> >>     the address SSCDAWCARMR + 4 * N, where N is the CPU number.
>> >>
>> >> Currently, the outer cache frame work does not support a per-CPU
>> >> init callback.  So this commit adopts [2]; the master CPU iterates
>> >> over possible CPUs setting up SSCDAWCARMR(N) registers.
>> >>
>> >> Unfortunately, the register offsets of SSCDAWCARMR(N) are different
>> >> by SoC.  We can live with it by checking the version register.
>> >>
>> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >>
>> >
>> > Applied to next/soc, thanks!
>> >
>> > I'm a little lost with the patches you send, could you check that
>> > I have applied all the ones you sent for 4.7 so far?
>> >
>> >         Arnd
>>
>>
>> Was this one really applied, or not yet?
>>
>> My intention was to send this one just for review,
>> because outer-cache things are generally in Russell's field.
>>
>> If you have already applied it, I should drop it
>> from Russell's patch tracker.
>> (Sorry, I should have mentioned it.)
>>
>> Please let me know the status.
>
> Sorry, my mistake, I accidentally sent out my mail early and
> then did not put it into arm-soc in the end.
>
> It's not in arm-soc and it should go through Russell's patch tracker.

OK.

The others look good to me.

Thanks!


-- 
Best Regards
Masahiro Yamada
