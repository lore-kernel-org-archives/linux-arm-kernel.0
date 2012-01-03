From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 3 Jan 2012 10:31:23 +0100
Subject: [PATCH] arm: Fix linux-next compile error in arch/arm/common/gic.c
In-Reply-To: <CAO_0yfOzVCK8OGL5G9Aej+V4AZ12EMFKi3HafAX0JzeW9C3FtQ@mail.gmail.com>
References: <1325521990-4445-1-git-send-email-joerg.roedel@amd.com>
 <CAO_0yfOzVCK8OGL5G9Aej+V4AZ12EMFKi3HafAX0JzeW9C3FtQ@mail.gmail.com>
Message-ID: <20120103093123.GA7620@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 08:44:01AM +0800, Yang Bai wrote:
> On Tue, Jan 3, 2012 at 12:33 AM, Joerg Roedel <joerg.roedel@amd.com> wrote:

> > ? ? ? ? ? ? ? ?for_each_possible_cpu(cpu) {
> > - ? ? ? ? ? ? ? ? ? ? ? unsigned long offset = percpu_offset * cpu_logical_map(cpu);
> > + ? ? ? ? ? ? ? ? ? ? ? unsigned long offset = percpu_offset;
> > +#ifdef CONFIG_SMP
> > + ? ? ? ? ? ? ? ? ? ? ? offset *= cpu_logical_map(cpu);
> > +#endif
> > ? ? ? ? ? ? ? ? ? ? ? ?*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
> > ? ? ? ? ? ? ? ? ? ? ? ?*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
> > ? ? ? ? ? ? ? ?}
> > --
> > 1.7.5.4
> >
> >
> 
> Is this the right way to fix it? Or shall we do like this:
> 
> #ifdef CONFIG_SMP
> ...
> #else
> #define cpu_logical_map() 1
> #endif
> 
> and leave the gic.c code unchanged.

Well, I don't care ;) But everywhere else in this file the use of
cpu_logical_map() is #ifdef'ed with CONFIG_SMP. So for consistency my
proposed variant is better, no?


	Joerg
