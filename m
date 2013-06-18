From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 18 Jun 2013 15:32:03 +0530
Subject: [PATCH V2 05/10] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <CAJFYCKFHhD2LuPP5LKSXzg4zuCMmNTSWRRUQkwFcQVmXSaLo9Q@mail.gmail.com>
References: <9340690.Y20fM6tyU7@flatron>
 <Pine.LNX.4.44L0.1306131542080.1561-100000@iolanthe.rowland.org>
 <CAJFYCKFHhD2LuPP5LKSXzg4zuCMmNTSWRRUQkwFcQVmXSaLo9Q@mail.gmail.com>
Message-ID: <CAK9yfHzR3y=jTL9K6w3Z9agrZ7SkzCdr6-HxKt-dj1Si6aBS3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 June 2013 15:24, Manjunath Goudar <manjunath.goudar@linaro.org> wrote:
>
>
> On 14 June 2013 01:22, Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> On Thu, 13 Jun 2013, Tomasz Figa wrote:
>>
>> > > +   rc = ohci_suspend(hcd, do_wakeup);
>> > > +   if (rc == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
>> > > +           ohci_resume(hcd, false);
>> > > +           rc = -EBUSY;
>> > > +   }
>> >
>> > I'm not into USB host subsystem, so I might just ask a stupid question.
>> >
>> > Can't we make ohci_suspend check this for us, so the drivers would just
>> > check for error code? It seems like in all your patches this part of
>> > code
>> > is duplicated, looking as a good candidate to be generic.
>>
>> Argh!  You're right, of course.
>>
>> I didn't see it, because the only existing place where this check is
>> made is in the PCI glue layer.  Pushing it into the HCDs themselves is
>> obviously the right thing to do.
>>
>> Manjanuth, let's do this.  You can write a preliminary patch that puts
>> this check at the end of the ohci_suspend() routine, and then resubmit
>> your series.
>>
>
> Alan and Tomaszas you are correct.
>
> Initially I also thought same, but later I analyzed this code is not
> necessary for all bus glue; so I did not write in ohci_suspend() routine.
>
> After Alan explanation I am writing below code end of ohci_suspend()
> routine.is it correct Alan.
>
>        if (do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
>                 ohci_resume(hcd, false);
>                 rc = -EBUSY;

You probably need to return this error code.

-- 
With warm regards,
Sachin
