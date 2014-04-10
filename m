From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 10 Apr 2014 11:01:12 +0530
Subject: [PATCH 1/2] usb: ehci-exynos: Return immediately from suspend if
 ehci_suspend fails
In-Reply-To: <Pine.LNX.4.44L0.1404092134420.7397-100000@netrider.rowland.org>
References: <001a01cf5453$243d9c70$6cb8d550$%han@samsung.com>
 <Pine.LNX.4.44L0.1404092134420.7397-100000@netrider.rowland.org>
Message-ID: <CAFp+6iGTbvK+7BTg6mDohiOqyaOHLuDzDTyXWeCkgS2YUApBJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,


On Thu, Apr 10, 2014 at 7:06 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 10 Apr 2014, Jingoo Han wrote:
>
>> > > --- a/drivers/usb/host/ehci-exynos.c
>> > > +++ b/drivers/usb/host/ehci-exynos.c
>> > > @@ -212,6 +212,8 @@ static int exynos_ehci_suspend(struct device *dev)
>> > >   int rc;
>> > >
>> > >   rc = ehci_suspend(hcd, do_wakeup);
>> > > + if (rc)
>> > > +         return rc;
>> > >
>> > >   if (exynos_ehci->otg)
>> > >           exynos_ehci->otg->set_host(exynos_ehci->otg, &hcd->self);
>> > > @@ -221,7 +223,7 @@ static int exynos_ehci_suspend(struct device *dev)
>> > >
>> > >   clk_disable_unprepare(exynos_ehci->clk);
>> > >
>> > > - return rc;
>> > > + return 0;
>> > >  }
>> > >
>> > >  static int exynos_ehci_resume(struct device *dev)
>> >
>> > The first hunk of this patch is correct, but the second hunk isn't
>> > needed.  A similar remark is true for the ehci-platform patch.
>>
>> Hi Alan,
>>
>> Do you mean the following?
>>
>> 1st hunk
>>  +    if (rc)
>>  +            return rc;
>>
>> 2nd hunk
>>  -    return rc;
>>  +    return 0;
>
> Yes, that's what I mean.
>
>> Currently, the 'rc' will be always 'zero'; however, I don't
>> Have any objection, because the code might be  modified later.
>
> Exactly.  We should add the new "if" statement but leave the "return
> rc" the way it is.

Sure, i will update both the patches.

>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
