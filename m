From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 27 Nov 2014 02:39:43 +0400
Subject: Lubbock interrupts fix (was lubbock udc phy)
In-Reply-To: <87zjbd1tb0.fsf_-_@free.fr>
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
 <87d28d3uh5.fsf@free.fr> <874mtl3936.fsf@free.fr>
 <CALT56yMCCy6qPRQVpt=4JQ0Kd1Fr43j894TgOAPi8a2eKKve0A@mail.gmail.com>
 <87zjbd1tb0.fsf_-_@free.fr>
Message-ID: <CALT56yOBQx=RJYhTznTCApw2Jud3MvzDZ0YBo+jxFd_1nRto_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-27 1:38 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
>> 2014-11-27 1:12 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>>> OK Dmitry, I pulled through, the interrupts are working back.
>>
>> What was the problem? Hardware issues? Firmware in CPLD being of old
>> revision?
> There were basically 2 problems :
>  - hardware: switch S13 was in a position that disabled interrupts all the time
>    One other problem which fooled me was the incorrect gate schematics I had,
>    and which make my understanding of linear function foo such as
>    GPIO0 = foo(LUB_IRQ_EN, LUB_SET_CLR) false.
>
>  - software: lubbock.c error
>    Since gpio-pxa was ported to device/gpio, it is probed *after*
>    lubbock_init_irq() is called. As lubbock_init_irq() installs
>    lubbock_irq_handler() and sets the irq to falling edge detect before gpio-pxa
>    is probed, gpio-pxa probe overwrites this by :
>      - clearing any edge detection (probe state reset)
>      - installing generic handle_edge_irq() instead of the lubbock irq handler
>
> So the conclusion is that I have to rework lubbock_init_irq(), remove from it
> the PXA_GPIO_TO_IRQ(0) stuff, and move it to a code in lubbock.c which will
> provide the guarantee of being executed _after_ gpio-pxa is probed. When I'm
> happy with my patch I'll submit it.

Thank you for your explanation.

-- 
With best wishes
Dmitry
