From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Jan 2013 12:40:54 -0800
Subject: [PATCH v2 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
In-Reply-To: <CALF0-+XdsKvJJpmxZEYXyhTZksgKRoAJ4TcyPV+G9WUbb7Dt_g@mail.gmail.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358634477-25868-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130121123020.GI15707@e106331-lin.cambridge.arm.com>
 <CALF0-+VOxtsfQLZCGujvjMrsGacbfVTMytRUX=CfKa3+FgnU1w@mail.gmail.com>
 <20130121183348.GI22517@atomide.com>
 <af696cd0-8a7f-4839-9600-87d5b9172585@email.android.com>
 <CALF0-+WvfyygnV5A=E8UGc=zp9pab79FzJRe1KywjPw-B4UGZA@mail.gmail.com>
 <20130122182749.GM15361@atomide.com>
 <CALF0-+XdsKvJJpmxZEYXyhTZksgKRoAJ4TcyPV+G9WUbb7Dt_g@mail.gmail.com>
Message-ID: <20130122204053.GT22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ezequiel Garcia <elezegarcia@gmail.com> [130122 11:46]:
> On Tue, Jan 22, 2013 at 3:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Ezequiel Garcia <elezegarcia@gmail.com> [130122 10:17]:
> >> On Mon, Jan 21, 2013 at 10:32 PM, Daniel Mack <zonque@gmail.com> wrote:
> >> >
> >> > I'm currently far away from my computer and can't prepare a patch for this, sorry. But I think you are right, so please just submit a patch for that, anyone :-)
> >> >
> >>
> >> Ok, I'll try to submit a patch as soon as possible. If anyone wants to
> >> do it instead, fine by me.
> >
> > No please go ahead as it seems that you can easily test it too.
> >
> 
> No problem.
> 
> I now wonder if it's okey to exit upon probe failure.
> In particular, the for_each should be like this:
> 
>         for_each_node_by_name(child, "nand") {
>                 ret = gpmc_probe_nand_child(pdev, child);
>                 if (ret < 0) {
>                         of_node_put(child);
>                         return ret;
>                 }
>         }
> 
> or like this:
> 
>         for_each_node_by_name(child, "nand") {
>                 ret = gpmc_probe_nand_child(pdev, child);
>                 WARN_ON(ret < 0);
>         }
> 
> Ideas?

Well I would return and make sure the resources are freed.

However, if this relates to using bootloader configured values
for the few cases where we don't have the timing information
for calculations available, then just doing a warning is
the way to go.

Regards,

Tony
