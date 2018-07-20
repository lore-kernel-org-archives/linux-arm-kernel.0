From: hari.vyas@broadcom.com (Hari Vyas)
Date: Fri, 20 Jul 2018 19:04:04 +0530
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <20180720121321.qgdsdtvvowhphava@pathway.suse.cz>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
 <20180720121321.qgdsdtvvowhphava@pathway.suse.cz>
Message-ID: <CAM5rFu-_sU1eSryFR-rDF=6BxZuf_E0xBQJ8RizNKYDB+DgWOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 5:43 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2018-07-19 19:42:50, Hari Vyas wrote:
>> On Thu, Jul 19, 2018 at 4:09 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Thu, Jul 19, 2018 at 03:47:46PM +0530, Hari Vyas wrote:
>> >> On Thu, Jul 19, 2018 at 3:31 PM, Sergey Senozhatsky
>> >> <sergey.senozhatsky.work@gmail.com> wrote:
>> >> >> @@ -694,7 +698,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
>> >> >>               __show_regs(regs);
>> >> >>
>> >> >>       nmi_panic(regs, "Asynchronous SError Interrupt");
>> >> >> -
>> >> >> +     restore_console_loglevel();
>> >> >
>> >> > panic()
>> >> >
>> >> > What's the point of restore_console_loglevel() after panic()?
>> >> >
>> >> >         -ss
>> >> Except die(), other places restore call can be avoided but just added
>> >> for code completeness.
>> >
>> > As Sergey said, panic() is *fatal*. It does not return, so it makes no
>> > sense to place code after it.
>> >
>> I too pointed in cover letter. I just too added for code completeness.
>
> The code-completeness is not a good reason. It might cause false
> expectation that panic() is not fatal. It would cause more harm
> than good.
>
> The same is true also for die(). It should be fatal. I agree with
> Sergey and Mark that it does not make sense to restore
> the original level there.
>
> Best Regards,
> Petr
I can remove restore from not required (3) places.

Other than that, based on discussion, bad_mode() should panic so
better die() call itself be removed from bad_mode().
As this(i.e. cleanup of bad_mode) is not related to raised patch so
better one another bug/patch be raised for cleaning
bad_mode() and probably die() too.

Currently this die() is called from some other places also but not
completely sure whether restore_console_loglevel is required
there also or not as creating situation will be very difficult in
normal scenario.
