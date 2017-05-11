From: thgarnie@google.com (Thomas Garnier)
Date: Thu, 11 May 2017 16:17:01 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAJcbSZFswDWZoK-1UK+xkRMJ4ttSYbtH2Y5WD5_aPR-8ru6t8A@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508075209.7aluvpwildw325rf@gmail.com>
 <1494256932.1167.1.camel@gmail.com>
 <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
 <20170509065619.wmqa6z6w3n6xpvrw@gmail.com> <20170509111007.GA14702@kroah.com>
 <CAJcbSZFswDWZoK-1UK+xkRMJ4ttSYbtH2Y5WD5_aPR-8ru6t8A@mail.gmail.com>
Message-ID: <CAJcbSZEoRyewUtBHvqmNZL9FtT_q42Vmmd-EuC50x-ZRASiHHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 7:29 AM, Thomas Garnier <thgarnie@google.com> wrote:
>
> On Tue, May 9, 2017 at 4:10 AM, Greg KH <greg@kroah.com> wrote:
> > On Tue, May 09, 2017 at 08:56:19AM +0200, Ingo Molnar wrote:
> >>
> >> * Kees Cook <keescook@chromium.org> wrote:
> >>
> >> > > There's the option of using GCC plugins now that the infrastructure was
> >> > > upstreamed from grsecurity. It can be used as part of the regular build
> >> > > process and as long as the analysis is pretty simple it shouldn't hurt compile
> >> > > time much.
> >> >
> >> > Well, and that the situation may arise due to memory corruption, not from
> >> > poorly-matched set_fs() calls, which static analysis won't help solve. We need
> >> > to catch this bad kernel state because it is a very bad state to run in.
> >>
> >> If memory corruption corrupted the task state into having addr_limit set to
> >> KERNEL_DS then there's already a fair chance that it's game over: it could also
> >> have set *uid to 0, or changed a sensitive PF_ flag, or a number of other
> >> things...
> >>
> >> Furthermore, think about it: there's literally an infinite amount of corrupted
> >> task states that could be a security problem and that could be checked after every
> >> system call. Do we want to check every one of them?
> >
> > Ok, I'm all for not checking lots of stuff all the time, just to protect
> > from crappy drivers that.  Especially as we _can_ audit and run checks
> > on the source code for them in the kernel tree.
> >
> > But, and here's the problem, outside of the desktop/enterprise world,
> > there are a ton of out-of-tree code that is crap.  The number of
> > security/bug fixes and kernel crashes for out-of-tree code in systems
> > like Android phones is just so high it's laughable.
> >
> > When you have a device that is running 3.2 million lines of kernel code,
> > yet the diffstat of the tree compared to mainline adds 3 million lines
> > of code, there is bound to be a ton of issues/problems there.
> >
> > So this is an entirely different thing we need to try to protect
> > ourselves from.  A long time ago I laughed when I saw that Microsoft had
> > to do lots of "hardening" of their kernel to protect themselves from
> > crappy drivers, as I knew we didn't have to do that because we had the
> > source for them and could fix the root issues.  But that has changed and
> > now we don't all have that option.  That code is out-of-tree because the
> > vendor doesn't care, and doesn't want to take any time at all to do
> > anything resembling a real code review[1].
>
> That's a big part of why I thought would be useful. I am less worried
> about edge cases upstream right now than forks with custom codes not
> using set_fs correctly.
>
> >
> > So, how about options like the ones being proposed here, go behind a new
> > config option:
> >         CONFIG_PROTECT_FROM_CRAPPY_DRIVERS
> > that device owners can enable if they do not trust their vendor-provided
> > code (hint, I sure don't.)  That way the "normal" path that all of us
> > are used to running will be fine, but if you want to take the speed hit
> > to try to protect yourself, then you can do that as well.
>
> Maybe another name but why not.

Ingo: Do you want the change as-is? Would you like it to be optional?
What do you think?

>
> >
> > Anyway, just an idea...
> >
> > thanks,
> >
> > greg k-h
> >
> > [1] I am working really hard with lots of vendors to try to fix their
> >     broken development model, but that is going to take years to resolve
> >     as their device pipelines are years long, and changing their
> >     mindsets takes a long time...
>
>
>
> --
> Thomas




-- 
Thomas
