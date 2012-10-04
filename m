From: linux@prisktech.co.nz (linux at prisktech.co.nz)
Date: Fri, 5 Oct 2012 08:01:29 +1300 (NZDT)
Subject: usb: uhci-platform driver fails after patch changes during     
 merge
In-Reply-To: <20121004175235.GA14949@kroah.com>
References: <1349332691.7583.3.camel@gitbox> <1349333716.7905.1.camel@gitbox>
 <20121004142617.GA26625@kroah.com>
 <1349372523.8451.10.camel@gitbox>
 <20121004175235.GA14949@kroah.com>
Message-ID: <39415.210.54.1.170.1349377289.squirrel@server.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Oct 05, 2012 at 06:42:03AM +1300, Tony Prisk wrote:
>> On Thu, 2012-10-04 at 07:26 -0700, Greg KH wrote:
>> > On Thu, Oct 04, 2012 at 07:55:16PM +1300, Tony Prisk wrote:
>> > > On Thu, 2012-10-04 at 19:38 +1300, Tony Prisk wrote:
>> > > > Mike,
>> > > >
>> > > > I see someone made changes to the uhci-platform.c driver I submitted
during v3.7 which results in it not working on mach-vt8500.
>> > > >
>> > > > Could you clarify why the changes were made, and what the suggested
resolution would be to solve the problem that it introduced?
>> > > >
>> > > > Lines indicated by ---> below were removed from the patch, which means
that on arch-vt8500 there is no dma_mask set, and its fails to
communicate with attached devices.
>> > > >
>> > > > Regards
>> > > >
>> > > > Tony P
>> > > >
>> > > >
>> > > > static int __devinit uhci_hcd_platform_probe(struct platform_device *pdev)
>> > > > ...
>> > > > 	if (usb_disabled())
>> > > > 		return -ENODEV;
>> > > > --->
>> > > > 	/* Right now device-tree probed devices don't get dma_mask set.
>> > > > 	 * Since shared usb code relies on it, set it here for now. * Once we
have dma capability bindings this can go away. */
>> > > > 	if (!pdev->dev.dma_mask)
>> > > > 		pdev->dev.dma_mask = &platform_uhci_dma_mask;
>> > > > --->
>> > > > 	hcd = usb_create_hcd(&uhci_platform_hc_driver, &pdev->dev,
>> > > > 				pdev->name);
>> > > > ...
>> > > >
>> > > >
>> > > > _______________________________________________
>> > > > linux-arm-kernel mailing list
>> > > > linux-arm-kernel at lists.infradead.org
>> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> > >
>> > > Greg,
>> > >
>> > > This message was intended for you rather than Mike. Could you clarify
what happened and the expected resolution?
>> >
>> > I don't know, this should be directed at the person who made the change
that is causing the problem, and the linux-usb at vger.kernel.org mailing
list.
>> >
>> > Who changed the patch?  What patch exactly are you referring to?  Who
signed off on it?  Where was it discussed?
>> >
>> > thanks,
>> >
>> > greg k-h
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> Greg,
>> Thats the problem I have - I can't track where the changes came from. The
commit details show:
>> author
>> Tony Prisk
>> <linux@prisktech.co.nz>
>> Sat, 21 Jul 2012
>> 10:58:53 +0000 (22:58
>> +1200)
>> committer
>> Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>
>> Thu, 16 Aug 2012
>> 21:00:37 +0000 (14:00
>> -0700)
>> commit
>> 100d45970327f78584ff4846deeca14bba511e28
>> But this file -
>> drivers/usb/host/uhci-platform.c
>> isn't the version I supplied in the patchset. There are no other commits
against it so I assume it was changed before it was committed.
>
> No, this commit matches up exactly with the email I got from you with
>  Message-Id: <1342868333-10647-2-git-send-email-linux@prisktech.co.nz>
> which looks to be the patch I applied here.  The diffstat matches up exactly
with that email.
>
> Do you see that as well?
>
> You should have gotten an automated email response from me when the patch was
applied, with the patch in it.  My email system doesn't keep those around, but
you should have it somewhere, so you could compare it to the commit in Linus's
tree now, right?  Does it match up?
>
> If I accidentally applied the incorrect patch (note, this looks like it was
version 4 of the patch, was there a later version that I
> missed?), please feel free to send an add-on patch that fixes up any errors.
>
> thanks,
>
> greg k-h
>

*facepalm*

I see what has happened now. When you said v4 I got even more confused as the
missing code was in every version from v1->v5 of the current patchset
(August/September). The patch is question is from July 21st and was standalone.
I assumed that patch had been lost as I never recieved any feedback outside of
Arnd and the internal vt8500 mailing list. A new patchset was done later which
included the UHCI driver with fixes. This also explains the merge-conflict
between arm-soc and usb trees just recently.

Apologies for the messup. I will send out a fix for 3.7-rc


Regards

Tony P
