From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 12:27:01 -0700
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119185212.GO16735@n2100.arm.linux.org.uk>
References: <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <528BB109.2060201@wwwdotorg.org>
 <20131119185212.GO16735@n2100.arm.linux.org.uk>
Message-ID: <528BBB85.8050507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 11:52 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 19, 2013 at 11:42:17AM -0700, Stephen Warren wrote:
>> On 11/19/2013 05:28 AM, Russell King - ARM Linux wrote:
>>> On Mon, Nov 18, 2013 at 03:46:32PM -0700, Stephen Warren wrote:
>>>> Again, the point is not that it's hard to write the script. As you
>>>> demonstrated, it's easy. The problem is that then, everybody has to do
>>>> something different for Tegra, forever. No matter how small the actual
>>>> cost of doing it is, it's still non-scalable to require that everyone
>>>> know about this special case. I'm not convinced the issue would be
>>>> isolated to Tegra either.
>>>
>>> That's why there's the facility to allow an override to the script,
>>> just like there's the facility to override the default script when
>>> running "make install".
>>
>> Again, you are completely missing the point about that not scaling at all.
> 
> No I'm not.  What you're looking for is perfection.  Perfection is something
> we can't have here - we can have "good enough".

For the issue I care about, it's not hard to have perfection. Why
wouldn't I want that.

Reading your comments below, I think we're talking about slightly
different aspects of the problem though.

> Look, the problem is very simple: we have a bunch of DT descriptions in
> the kernel, which we build to a blob.  We don't want distributions poking
> around in the kernel source tree to retrieve these blobs, so we provide
> a way to install them somewhere.

Sure. I have no problem at all if the kernel implemnts a "make
dtbs_install" target. It certainly should.

> The installation should just copy the blobs to a path in the filesystem
> _or_ allow a distro to hook into the installation process, just like we
> provide for the installation of the zImage.  That is our job done.  We
> should do *nothing* more.

OK, if you're arguing that there should be absolutely zero renaming at
all under any circumstances, I'm fine with that.

My argument was that the proposed renaming step (renaming the DTBs based
on the top-level compatible) is not appropriate for Tegra, even if it is
what some other platforms might want. My issue could be addressed by any of:

a) Never renaming anything. I believe this is what you're arguing for.

b) Having some kind of in-kernel list of DTs that do get renamed, and
those that don't. Tegra DTs would be in the latter don't-rename list.

c) Simply renaming any DT source files in the kernel that are perceived
to have the wrong name currently, rather than renaming during each "make
dtbs_install". Tegra DTs currently have the correct name, so wouldn't be
renamed.

I'm fine with any of those solutions. (a) or (c) seem simplest to me.

> If we start doing more than that, we're getting into the realms of
> distribution policy, and that's something we should not be involved in.
> 
> This is precisely the reason why we don't get involved with working out
> what steps are needed to install a kernel zImage onto a target: that
> is _not_ the kernel's job to work out that you may need to package it
> up and maybe copy it over to a TFTP server, or maybe copy it onto a SD
> card, or maybe place it in /boot and do a certain number of other
> steps.
> 
> All that the kernel build's job here is to provide the results of the
> kernel build.  It is not about working out which DT blob is right for
> any particular platform.

For the record, I was never talking about the kernel selecting a
particular DTB to install, or a particular DTB for a target. I assume
that "make dtbs_install" always installs all DTBs that the kernel built.
The discussion in this thread has been about (re-)naming not selecting
DTBs. It's up to some out-of-kernel process to pick which (or all) of
those to actually use.
