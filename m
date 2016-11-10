From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Nov 2016 21:48:53 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <de3b4ae7-6a08-2a03-d80e-059c71c58aed@redhat.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
 <de3b4ae7-6a08-2a03-d80e-059c71c58aed@redhat.com>
Message-ID: <20161110204852.GA31728@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>It seems that we should get back to your initial approach. i.e. only
> >>brightness changes caused by hardware should be reported.
> >
> >I don't think enabling poll() here is good idea. Some hardware won't
> >be able to tell you that it changed the state. Returning maximum
> >brightness trigger is going to use seems easier/better.
> 
> The idea here is to allow userspace to poll() on the brightness
> sysfs atrribute to detect changes autonomously done by the hardware,
> such as e.g. happens on both Dell and Thinkpad laptops when pressing
> the keyboard backlight cycle hotkey. Note that these keys do not
> generate key-press events, the cycling through the brightness levels
> (including off) is done entirely in firmware.

Ok, so you can do that for keyboard backlight on thinkpad... I guess
you handle that as a special trigger on the keyboard leds? Can other
triggers, such as heartbeat, be assigned to that "led"? 

> But we do get other ACPI events for this which we can use to let
> userspace know this happens, which is something which user-
> interfaces which allow control over the kbd backlight want to know.

Yes, you can do that for keyboard backlight... but on thinkpads there
are more leds, such as battery led. That can blink on battery low, and
I don't think you can read the current status from hardware.

Getting current state of led blinking with cpu trigger is also not
quite a good idea. 
So IMO this should not be done in generic code. Instead,
kbd-backlight trigger should have special attribute, and that one
should be pollable.

> I understand that we will not always be able to do this, here is the
> Documentation/ABI/testing/sysfs-class-led text I have in mind:
> 
> 		The file supports poll() to detect changes, changes are only
> 		signalled when this file is written or when the hardware /
> 		firmware changes the brightness itself and the driver can detect
> 		this. Changes done by kernel triggers / software blinking are
> 		not signalled.
> 
> Note the "and the driver can detect this" language, that has been there
> since v1 of the poll() notification patch since I already expected not
> all hardware to be able to signal this.

Lets move it to separate attribute, for triggers that can do that,
please.

We do want a way to read maximum brightness for the heartbeat trigger,
for example..

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/5e875363/attachment.sig>
