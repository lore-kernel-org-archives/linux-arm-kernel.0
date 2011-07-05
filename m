From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Tue, 5 Jul 2011 19:09:19 +0200
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <2C577202CB5719438D4E9608C565CB2C01B69D7F@NL-EXC-07.intra.local>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>	<20110613122601.GC12325@n2100.arm.linux.org.uk>	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
	<4E13059A.4060606@parrot.com>
	<2C577202CB5719438D4E9608C565CB2C01B69D7F@NL-EXC-07.intra.local>
Message-ID: <4E13453F.1000009@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank Hofmann a ?crit :
> -----Original Message-----
> From: Matthieu CASTET [mailto:matthieu.castet at parrot.com]
> Frank Hofmann a ?crit :
>> [ ... ]
>> > +static void notrace __swsusp_arch_restore_image(void)
>> > +{
>> > +   extern struct pbe *restore_pblist;
>> > +   struct pbe *pbe;
>> > +
>> > +   cpu_switch_mm(swapper_pg_dir, &init_mm);
>> > +
>> > +   for (pbe = restore_pblist; pbe; pbe = pbe->next)
>> > +           copy_page(pbe->orig_address, pbe->address);
>> > +
>>
>> One question : isn't dangerous to modify the code where we are running ?
>>
>> I believe the code shouldn't change too much between the kernel that
> do the
>> resume and the resumed kernel and the copy routine should fit in the
> instruction
>> cache, but I want to be sure it doesn't cause any problem on recent
> arm cores
>> (instruction prefetching , ...)
>>
>>
>> Matthieu
> 
> Hi Matthieu,
> 
> this isn't new behaviour to _this_ rev of the patch ...
yes

> 
> and yes, it is dangerous to modify code where you're running. Except
> that this isn't happening in the current environment;
You are modifying it by putting the same code (modulo dynamic patching on the
code (ftrace, kprobe, ...)).


> If you're resuming via some other
> mechanism but the kernel's snapshot image loading code (and only jump
> into swsusp_arch_resume to kickstart resume) then it's up to you how you
> get the kernel text into place.
Yes.

> I've not experimented with resuming "foreign" images; how would one
> create such, and bypass the checks on load ?
I wasn't suggesting that.

> 
> It's less of a problem for the copy loop itself, really, as that's
> definitely cache-hot. But it's an issue for what happens _after_ the
> copy loop. If the code for cpu_resume / cpu_reset is not at the places
> where the resum-ing code expects it to be (i.e. if there's a mismatch in
> the resuming and to-be-resumed kernels wrt. to that), then things will
> jump to code nirvana.
> 
> Why are you asking about this ?
While reading the code I was surprised of that. And that there weren't any
comment about it.

Looking at other implementations, only x86_64 seems to need to relocate the copy
code.


Matthieu
