From: peda@axentia.se (Peter Rosin)
Date: Fri, 27 Apr 2018 09:27:58 +0200
Subject: [PATCH 00/24] device link, bridge supplier <-> drm device
In-Reply-To: <3483427.EaMxDYJt8U@avalon>
References: <20180426223139.16740-1-peda@axentia.se>
 <1881012.XPHlTWYXH6@avalon> <8a9fcd8c-962d-1acc-c2ba-74a3d8f59590@axentia.se>
 <3483427.EaMxDYJt8U@avalon>
Message-ID: <11768d9a-91cb-55e3-a026-3663241bffe5@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-27 01:18, Laurent Pinchart wrote:
> Hi Peter,
> 
> On Friday, 27 April 2018 02:09:14 EEST Peter Rosin wrote:
>> On 2018-04-27 00:40, Laurent Pinchart wrote:
>>> On Friday, 27 April 2018 01:31:15 EEST Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> It was noted by Russel King [1] that bridges (not using components)
>>>> might disappear unexpectedly if the owner of the bridge was unbound.
>>>> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
>>>> came up with using device links to resolve the panel issue, which
>>>> was also my (independent) reaction to the note from Russel.
>>>>
>>>> This series builds up to the addition of that link in the last
>>>> patch, but in my opinion the other 23 patches do have merit on their
>>>> own.
>>>>
>>>> The last patch needs testing, while the others look trivial. That
>>>> said, I might have missed some subtlety.
>>>
>>> I don't think this is the way to go. We have a real lifetime management
>>> problem with bridges, and device links are just trying to hide the problem
>>> under the carpet. They will further corner us by making a real fix much
>>> more difficult to implement. I'll try to comment further in the next few
>>> days on what I think a better solution would be, but in a nutshell I
>>> believe that drm_bridge objects need to be refcounted, with a .release()
>>> operation to free the bridge resources when the reference count drops to
>>> zero. This shouldn't be difficult to implement and I'm willing to help.
>>
>> Ok, sp 24/24 is dead, and maybe 23/24 too.
> 
> Not necessarily, maybe I'll get proven wrong :-) Let's discuss, but I first 
> need some sleep.

Ok, I'll add my view...

I don't see how a refcount is going to resolve anything. Let's take some
device that allocs a bridge that is later attached to some encoder. In doing
so it adds hooks to some of the drm_bridge_funcs. If you add a refcount to
the bridge itself then yes, the bridge object might remain but the code
backing the hook functions will go away the moment the owner device goes
away. So, you'd have to refcount the owner device itself to prevent it
from going away. But, you can't stop a device from going away IIUC, you can
only bring other stuff down with it in an orderly fashion.

Components, that some bridges use, takes care of bringing the whole cluster
down *before* any device goes away, so that is obviously a solution. But
that solution is not in place everywhere.

Now, my device-link is pretty light-weight. And it should only matter if
the owner goes away before the consuming drm device has brought down the
encoder properly. If that ever happens, we're in trouble. So, the link can
at worst only substitute one problem with another, and at best it prevents
the fireworks.

Sure, there's the reprobe problem if the bridge's owner device shows up
again, but that's pretty minor compared to a hard crash. And there was a
patch for that, so in the end that may be a non-issue.

If some other solution is found, removing the device-link is trivial. It is
localized to bridge attach/detach and nothing else is affected (in terms of
code).

Cheers,
Peter

>> But how do you feel about dropping .of_node in favour of .owner? That gets
>> rid of ugly #ifdefs...
> 
> I'll review that part and reply, I have nothing against it on principle at the 
> moment. The more generic the code is, the better in my opinion. We just need 
> to make sure that the OF node we're interested in will always be .owner-
>> of_node in all cases.
> 
>> I also have the nagging feeling that .driver_private serves very little real
>> purpose if there is a .owner so that you can do
>>
>> 	dev_get_drvdata(bridge->owner)
>>
>> for the cases where the container_of macro is not appropriate.
> 
> I'll review that too, it's a good point.
> 
