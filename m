From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 23 May 2016 14:04:24 +0200
Subject: [PATCH] misc: atmel-secumod: Driver for Atmel "security module".
In-Reply-To: <20160131113409.GI20165@piout.net>
References: <1453348655-31182-1-git-send-email-davidm@egauge.net>
 <20160125110921.GA4027@piout.net>
 <CALnQHM13cGnoma_3erb0oCnRD0sYGGNF1E1cgzCJHrEXbvJpRQ@mail.gmail.com>
 <alpine.LNX.2.00.1601291055520.23683@nippy.intranet>
 <20160131113409.GI20165@piout.net>
Message-ID: <20160523140424.7ded3893@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Sorry for the late review (I know you've posted new versions but I want
to comment on this one).

On Sun, 31 Jan 2016 12:34:09 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 29/01/2016 at 11:13:05 +1100, Finn Thain wrote :
> > 
> > On Mon, 25 Jan 2016, David Mosberger wrote:
> >   
> > > On Mon, Jan 25, 2016 at 4:09 AM, Alexandre Belloni 
> > > <alexandre.belloni@free-electrons.com> wrote:
> > >   
> > > > I know this does more than that but I think those thre sections should 
> > > > be registered using the nvmem framework. The sysfs file creation and 
> > > > accesses then comes for free.  
> > > 
> > > I think Finn's patches would have to go in for that first, since the 
> > > existing nvram code is a mess. Even with Finn's patches in, I think it 
> > > could go either way.  
> > 
> > I think Alexandre is speaking of the nvmem subsystem (not nvram).
> > Documentation/devicetree/bindings/nvmem
> > Documentation/nvmem
> > drivers/nvmem
> >   
> 
> absolutely.
> 
> > > I'm not exactly sure how some of the features of the security module 
> > > would be used: key management, auto erasing, there is a strange "backup 
> > > mode" vs "normal mode" which is not well documented, etc.  So I think it 
> > > may well end up being sufficiently different to warrant a separate 
> > > driver.  
> > 
> > nvmem is not a subsystem I am familiar with, so it's not immediately clear 
> > to me what your driver would look like if re-written that way.
> > 
> > Maybe it would become simpler. But if you did end up needing a separate 
> > misc driver as well, maybe use of the nvmem framework would actually 
> > increase complexity.
> > 
> > It would depend on your requirements. But I would focus on the actual 
> > requirement rather than uncertain future possibilities.
> >   
> > >   
> > > > Another idea is also to expose it using a genpool so it can be 
> > > > accessed as sram from inside the kernel.  
> > > 
> > > That may be a fine idea, but as far as our application is concerned, we 
> > > need user-level access to the battery-backed RAM.  
> > 
> > Right. I don't see how adding a memory allocator would help either.
> >   
> 
> While the immediate need is to use that sram from userspace, I think
> this is valuable to already think that at some point we will need to be
> able to partition and access that sram from the kernel.
> 
> 
> 

Well, I think we're reaching this point right now: I have to implement
"freeze" mode (entering a deep sleep mode by cutting all power domains
except VDDBU), and in order to do that I need to access BUREGs which
are part of the secu-sram you're trying to expose here.

Two comments on the nvmem approach:
1/ first of all it's not really a non-volative memory: if you loose
VDDBU you also loose the whole SRAM content.
2/ I need to be able to reserve the BUREG region (at least part of it)
for in kernel usage (need to store the SDRAM address I should jump to
when exiting freeze mode).

For those reason I think using the SRAM driver (drivers/misc/sram.c) is
a better approach. This driver both provides a sysfs interface (just
add the "export" property on the SRAM region you want to export to
user-space through sysfs), and a genpool provider (which I need to
reserve part of the SRAM for my "freeze" mode implementation).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
