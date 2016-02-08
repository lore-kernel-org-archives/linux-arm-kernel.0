From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 08 Feb 2016 23:25:37 +0100
Subject: [PATCH v4 01/17] Xen: ACPI: Hide UART used by Xen
In-Reply-To: <alpine.DEB.2.02.1602081054350.27008@kaball.uk.xensource.com>
References: <1454641552-12576-1-git-send-email-zhaoshenglong@huawei.com>
 <CAJZ5v0id-035AtyQ_SccPuCxD7+pa6GCgj3WBAojM+rFqssGQQ@mail.gmail.com>
 <alpine.DEB.2.02.1602081054350.27008@kaball.uk.xensource.com>
Message-ID: <2213954.ztOe55fprN@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 08, 2016 10:57:01 AM Stefano Stabellini wrote:
> On Sat, 6 Feb 2016, Rafael J. Wysocki wrote:
> > On Fri, Feb 5, 2016 at 4:05 AM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> > > From: Shannon Zhao <shannon.zhao@linaro.org>
> > >
> > > ACPI 6.0 introduces a new table STAO to list the devices which are used
> > > by Xen and can't be used by Dom0. On Xen virtual platforms, the physical
> > > UART is used by Xen. So here it hides UART from Dom0.
> > >
> > > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > > Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > 
> > Well, this doesn't look right to me.
> > 
> > We need to find a nicer way to achieve what you want.
> 
> I take that you are talking about how to honor the STAO table in Linux.
> Do you have any concrete suggestions?

I do.

The last hunk of the patch is likely what it needs to be, although I'm
not sure if the place it is added to is the right one.  That's a minor thing,
though.

The other part is problematic.  Not that as it doesn't work, but because of
how it works.  With these changes the device will be visible to the OS (in
fact to user space even), but will never be "present".  I'm not sure if
that's what you want?

It might be better to add a check to acpi_bus_type_and_status() that will
evaluate the "should ignore?" thing and return -ENODEV if this is true.  This
way the device won't be visible at all.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
