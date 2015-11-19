From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Nov 2015 12:44:11 -0600
Subject: device_node lifetime (was: Re: [PATCH 1/7] phy: brcmstb-sata: add
 missing of_node_put)
In-Reply-To: <20151118190500.GE140057@google.com>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
 <20151117013830.GV8456@google.com>
 <alpine.DEB.2.02.1511170711340.2045@localhost6.localdomain6>
 <20151117174430.GA8456@google.com>
 <alpine.DEB.2.10.1511171846120.2455@hadrien>
 <20151117183036.GF8456@google.com>
 <alpine.DEB.2.02.1511172327030.2121@localhost6.localdomain6>
 <20151118190500.GE140057@google.com>
Message-ID: <CAL_JsqLQWh8-gshYLrYwrrRjBRXiOACh9LzVn2HUU38mfgYGoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 1:05 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> (changing subject, add devicetree at vger.kernel.org)
>
> On Tue, Nov 17, 2015 at 11:33:25PM +0100, Julia Lawall wrote:
>> On Tue, 17 Nov 2015, Brian Norris wrote:
>> > On Tue, Nov 17, 2015 at 06:48:39PM +0100, Julia Lawall wrote:
>> > > Is this something that should be checked for elsewhere?
>> >
>> > I expect the same sort of problem shows up plenty of other places. I
>> > don't think many people use CONFIG_OF_DYNAMIC, so the effects of these
>> > failures probably aren't felt by many.

The "problem" is non-existent because either CONFIG_OF_DYNAMIC is off
or where it is used is limited (memory and cpus on PSeries) and now
overlays. Overlays have the potential to be problematic, but we should
manage ref counting for overlays in a completely different way. What
that looks like, I don't know. I'll leave that to the person that
cares about removing overlays.

>> basically, this says that a structure field is initilized to a device node
>> value, the structure is returned by the containing function, and the
>> containing function contains no of_node_get at all.  Certainly this is
>> quite constrained, but it does produce a number of examples.

I've got no idea if this is right or not.

>> drivers/of/pdt.c, function of_pdt_create_node
>
> Not real sure about this one.

SPARC. Stay away.

>
>> Any idea whether these need of_node_get?  In all cases the device node
>> value comes in as a parameter.
>
> I'm really not an expert on this stuff. I just saw a potential problem
> that I happen to be looking at in other subsystems, and I wanted to know
> what others thought. I think this discussion should include the DT folks
> and the subsystems in question. For one, I'm as interested as anyone in
> getting this todo clarified:
>
> Documentation/devicetree/todo.txt
> - Document node lifecycle for CONFIG_OF_DYNAMIC

Step 2 after figuring out it can't be documented is "define a new way
to handle dynamic DT refcounting aka how to get rid of
of_node_get/put."

Rob
