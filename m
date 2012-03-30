From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 30 Mar 2012 15:12:19 +0530
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A831841009@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
 <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
 <4F7570FC.8000907@ti.com>
 <79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
 <CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831841009@DBDE01.ent.ti.com>
Message-ID: <CAMQu2gyktrAhtTYViYfb9nQ7g8UB1btGFkmd7aLD+Kt4r8y9WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 2:58 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> On Fri, Mar 30, 2012 at 14:50:02, Shilimkar, Santosh wrote:
>> On Fri, Mar 30, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>> > On Fri, Mar 30, 2012 at 14:08:20, Shilimkar, Santosh wrote:
>> >> On Friday 30 March 2012 02:02 PM, Hiremath, Vaibhav wrote:
>> >> > On Fri, Mar 30, 2012 at 13:11:35, Shilimkar, Santosh wrote:
>>
>> [....]
>>
>> >> >
>> >> > With this patch, will you be able to choose gptimer as a clocksource
>> >> > using bootparameter (or sysfs) for given kernel uImage?
>> >> >
>> >> Why do you want that ? Look at changelog. The gptimer based clocksource
>> >> is useless for OMAP and for AM devices synctimer is not available.
>> >>
>> >>
>> >> > The answer is simply NO...as the registration of gptimer is based on
>> >> > failure from omap_init_clocksource_32k(). And this is nothing different
>> >> > than my original patch, my patch exactly does same thing.
>> >> >
>> >> I ight have missed your original patch. If that patch is similar then
>> >> no problems.
>> >>
>> >> > The requirement after 'ming Lie' response on my patch was, there will be
>> >> > usecases where we might need to use gptimer for clocksource and with
>> >> > the patch it is not possible, since you will only register
>> >> > 32k_counter here.
>> >> >
>> >> I think Ming Lie might have expected that gptimer clocksource might
>> >> be better which is not the case.
>> >>
>> >> > So in order to allow user to choose between 32K and gptimer, you must
>> >> > register both and make 32k as a default thing.
>> >> >
>> >> As described in the commit log, its not needed at all. Let's not add
>> >> a feature which is just useless because the gptimer based clock
>> >> source has no advantage against the syntimer.
>> >>
>> >
>> > I completely agree with you, and that is my understanding too.
>> >
>> Thanks !!
>>
>> > After Ming Lie's comment, the point that I came to my mind was,
>> > certainly there will be resolution difference between these two clocksources,
>> > if ?gptimer2 is sourced from sys_ck (26Mhz).
>> >
>> GPTIMER2 with sysclock is not an option. GPTIMER is not in wakeup domain
>> and when sysclock is cut, it stops.
>>
>> > I am quite not sure, whether will there be any practical usecase where you
>> > change the kernel clocksource for high resolution dynamically through sysfs
>> > or something. May be not....but still it is possible.
>> >
>> Even if there is a usecase, there no option with full PM.
>>
>
> What if before suspending the system, you switch back to 32k_counter
> everytime, and in resume you again switch to gp_timer?
>
This has been discussed at length. Dynamic switching between
clock-sources affects the NTP time corrections. Go through [1]
when you have time, since its a long thread.

If and when that feature works, we can update the clocksource
code.

Regards
Santosh

[1]  https://lkml.org/lkml/2011/6/2/167
