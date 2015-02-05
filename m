From: rshitrit@annapurnalabs.com (Ronen Shitrit)
Date: Thu, 5 Feb 2015 14:33:03 +0200
Subject: [PATCH v4 0/6] Introducing the Alpine platform.
In-Reply-To: <2737362.aK8nBa7Wi3@wuerfel>
References: <54d0cd21.WWf8LEKnly7HnqEK%tsahee@annapurnalabs.com>
 <4902057.1c5MpYALGg@wuerfel>
 <CAC9K06yaA30e+HnRH50QJeF0=a_oCeWaaT_sYuS+OVcq1ZnVzg@mail.gmail.com>
 <2737362.aK8nBa7Wi3@wuerfel>
Message-ID: <CAC9K06wPzHw1XGMq6tCK1aCiYz7NX3GrV+BaYmi6w5YJjzaHSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2015 at 14:21, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thursday 05 February 2015 10:28:02 Ronen Shitrit wrote:
> > On 4 February 2015 at 14:33, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wednesday 04 February 2015 13:19:04 Tsahee Zidenberg wrote:
>
> > > I understand where you are coming from, as this is something that
> > > everyone gets wrong at first.
> >
> > In order to bring up a completely new silicon with lots of
> > technologies challenges in such short time and take it to production,
> > with multi discipline environments, few OSs support and small software
> > group, we had to share code as much as possible == hal.
>
> I think the most important part for you to understand is not to call
> something a hal (or os abstraction, which would be worse), as that
> is universally hated. ;-)
Tnx for the tip :)

>
> > We were aware from first day of the obstacles of merging hal code to
> > the mainline, that why we implemented it using linux coding style,
> > trying to minimize the "resistance", and we hoped (and still are :) to
> > find a path to keep part of our low level code into the mainline.
> > If it wont work out, we will rewrite it...
>
> It's not as bad if something is contained within one driver:
We tried to keep this concept across our low level drivers...

> if you have
> e.g. a network driver that consists of a low-level part that talks to
> the hardware and a high-level part that talks to linux, that can
> be ok. What you should avoid is having interfaces that span across
> multiple driver components and use a global header file for the
> interface but are specific to one SoC family.
>
> > >However, you will not be able to merge
> > > the drivers with a HAL like this. The kernel abstracts all the
> > > components of typical SoCs already and I suspect you just did not
> > > use the right abstraction because you either didn't find it, or it
> > > was not there at the time you started the work.
> > >
> > > For example, a DMA subsystem that is used by multiple slave drivers
> > > should use a driver in drivers/dma that registers to the slave-dma API,
> >
> > If you are referring to the dma-engine api, than this is a good
> > example where we don't want to use the generic framework as its
> > overhead on performance is unacceptable.
>
> It also illustrates my point: When we introduce a second interface
> in parallel to the existing one, this puts a burden on us upstream
> maintainers which now have to understand and maintain both. We used
> to have all sorts of interfaces per SoC and are almost done consolidating
> them to all use dmaengine for this reason.
> I do realize that the dmaengine API is not perfect though, so if you
> have specific problems with it, we expect you to help figure out what
> they are and what we can do about them so that everybody benefits.
Understand, not sure if it can work out but we will give it a try...

>
> To a certain extent, this is how we make progress in the kernel with
> generic interfaces: someone has a particular need and it's up to them
> to implement the groundwork. In return they get all the features of
> the kernel that someone else needed and implemented already.
>
>         Arnd




-- 
Ronen Shitrit
