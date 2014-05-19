From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 19 May 2014 14:35:49 +0200
Subject: [RFC PATCH 1/9] dt: deps: dtc: Automatically add new property
 'dependencies' which contains a list of referenced phandles
In-Reply-To: <53775334.3030704@gmail.com>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <1399913280-6915-2-git-send-email-holler@ahsoftware.de>
 <53775334.3030704@gmail.com>
Message-ID: <5379FAA5.10404@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.05.2014 14:16, schrieb Tomasz Figa:

>> References to phandles of parent or child nodes will not be added to this
>> property, because this information is already contained in the blob (in the
>> form of the tree itself).
>
> I wonder if we shouldn't be including them too for consistency related
> reasons, so we have all the necessary information in one place.
> References to child nodes are great recipes for cycles, though...
>
> No strong opinion, though, just an idea.

As said, they are already in the tree itself. And they are already 
included in the graph (these are the black edges), so they just don't 
appear in the property dependencies.

>
>>
>> No dependencies to disabled nodes will be added.
>>
>
> Same here. IMHO it might be wise to let the parsing entity (e.g. kernel)
> decide whether to ignore a dependency to disabled node or not.
>
> Otherwise, I like the simplicity of compile-time dependency list
> creation. Quite a nice work.

Thanks.

What's still questionable about the patches for dtc is if dependencies 
to devices and not just drivers should be included in the new property 
dependencies too. My current assumption is that all devices belonging to 
one and the same driver don't have dependencies between each other. In 
other words the order in which devices will be attached to one and the 
same driver isn't important. If that assumption is correct it would be 
possible to just attach all devices belonging to a driver after the 
driver was loaded (also I haven't that done in my patches).

And thinking about that again, I think I was wrong and doing so have 
been some kind of evil premature optimization I did in order to spare a 
few dependencies/edges. But changing this can done by removing a few 
lines in the code for dtc (patch 1).

Regards,

Alexander Holler
