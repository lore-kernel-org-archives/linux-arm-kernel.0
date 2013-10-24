From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 24 Oct 2013 15:26:59 -0500
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131024083459.48FE3C4039D@trevor.secretlab.ca>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131024083459.48FE3C4039D@trevor.secretlab.ca>
Message-ID: <CAHCPf3uzOyL1aDpTkW45GnAJ1KJkiyDUgp56-7sAQ7aXnbbPuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 3:34 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, 23 Oct 2013 18:20:02 +0100, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>> I'd say yes. Going from unstable to stable is quite a step for a binding
>> and that should be visible and worth a patch IMO.

A patch to remove the ! in front of !marvell,dma-controller is still
going to be as visible as a patch to remove
"unstable-!-version2-!-!-!!-omg!marvel,dma-controller" isn't it?

My worry is some bindings will never go stable, and the kernel will
keep printing warnings. At this point, marking it unstable is like
marking a driver as depends on EXPERIMENTAL in Kconfig - everyone
enables EXPERIMENTAL so there was no reason for it to exist. So, a few
warnings pop out on a console with a ! in front, people ignore those
and carry on. Who are you really trying to affect by implementing an
unstable binding warning?

>> a DTS file or some driver code, it will avoid
>> confusion/misinterpretation if one can see immediately the status of a
>> binding.
>
> No, it shouldn't. Going from unstable to stable is not a large step, rather it is coming to the point of looking around and realizing that the binding is working quite well.

Who decides that?

> I don't think the solution is to put this into the kernel to be checked
> at runtime.

I think the warning needs to be selectable at runtime; distributions
should mandate it turned on (therefore they can tell if weird crap
happens in their bug trackers same as the staging taint flag) but
normal people can turn it off. In the meantime, everything keeps
working as it was; except that new device trees will no longer work on
older systems since they will not be ignoring the bang and devices
will disappear.

It also implies that every current binding has been implicitly made
stable, and again the worry that new bindings will stay unstable
forever (and forever knock out that warning until it gets someone
patching away the bang upstream whether it is really 'stable' or not.)

> The better solution is to put it into DTC and make it
> complain (either warn or error; depending on build config?) about usage
> of compatible strings that are marked in the binding documentation as
> unstable.

I would agree with this, except less people care about the kernel
build output than console output. People using precompiled distros
won't even notice..

Again, DTC would have to strip the bang before handing it to the
kernel, or every current (as of today) binding is stable. But it is
less intrusive.

The state of the binding - being experimental or not - should probably
just be denoted by the binding being in an "experimental" directory in
the source, or marked with a X-DT-Binding-Status: TOTALLY_WHACKED_OUT
tag at the top of the binding itself. If you build a kernel and stuff
acts weird, check the binding for the device that acts weird. If it's
marked as such, go harangue the developers...

-- 
Matt Sealey <neko@bakuhatsu.net>
