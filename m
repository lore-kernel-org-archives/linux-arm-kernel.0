From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 14 Nov 2016 09:31:18 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
References: <20161110175537.GF27724@atomide.com> <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd>
 <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <4c31faef-144d-289c-0e32-83e76aff6178@gmail.com>
 <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
Message-ID: <20161114083118.GC18123@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Also, how would we read the
> >brightness set by the firmware? We'd have to read brightness
> >file, so still two files would have to be opened which is
> >a second drawback of this approach.
> 
> No, look carefully at the definition of the read behavior
> I plan to put in the ABI doc:
> 
> "Reading this file will return the actual led brightness
> when not blinking and no triggers are active; reading this
> file will return the brightness used when the led is on
> when blinking or triggers are active."

That's not sane semantics. Userspace would have to read three files
(racy) to find out about triggers etc.

It also prevents modelling
"hardware-changes-brightness-behind-kernel's-back" as a trigger.

> So for e.g. the backlit keyboard case reading this single
> file will return the actual brightness of the backlight,
> since this does not involve blinking or triggers.

Stop obsessing about "ingle file". FDs are pretty cheap. This is sysfs.

> >Having no difference in this area between the two approaches
> >I'm still in favour of the read-only file for notifying
> >brightness changes procured by hardware.
> 
> That brings back the needing 2 fds problem; and does

Actually you have turned "2 fds" into "3 fds", as userspace now needs
to check for trigger _and_ blinking _and_ actuall brightness.

fds are cheap, but that is still not nice design.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/0ba939dd/attachment.sig>
