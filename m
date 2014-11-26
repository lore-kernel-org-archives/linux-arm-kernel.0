From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 26 Nov 2014 23:12:13 +0100
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <87d28d3uh5.fsf@free.fr> (Robert Jarzmik's message of "Mon, 24
 Nov 2014 08:53:26 +0100")
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
 <CALT56yO8tktrXo0rfRd91AtXBE4F5vYfYjm9AL+7dcoam6Oq9Q@mail.gmail.com>
 <87egsz6ija.fsf@free.fr> <87sihb49vm.fsf@free.fr>
 <CALT56yMVjRC4YhWsc9d_i0mVrHyv8XV=Sw2op=xsdR5izv1tHg@mail.gmail.com>
 <87lhn340i1.fsf@free.fr>
 <CALT56yP1OGWQd5i+H+4uFkZD4AqdtF7J1+Lme76UgLgVfycQ4w@mail.gmail.com>
 <87h9xr3z35.fsf@free.fr>
 <CALT56yMUQDZV5=dn_Hm7jNS5NQXj7ewXcB2LsGvTbCOuoio7JQ@mail.gmail.com>
 <87d28d3uh5.fsf@free.fr>
Message-ID: <874mtl3936.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK Dmitry, I pulled through, the interrupts are working back.

Actually one of the blockers I have is in pxa25x_udc, and it is also in your
phy-lubbock.c. The bottom of the error is that disable_irq() is called from
within a irq handler, and it deadlocks. A disable_irq_nosync() should be used
...

... but a better approach would be to use a threaded irq for vbus handling. I
think that way disable_irq() can be used, no workqueue is needed anymore in
phy-lubbock.

Would you make that change, I'll test it and review it.

Cheers.

--
Robert
