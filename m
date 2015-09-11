From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 10:54:38 +0100
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <8737ymuhbc.fsf@belgarion.home>
References: <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
 <20150906235414.GQ21084@n2100.arm.linux.org.uk>
 <877fo0x2ur.fsf@belgarion.home>
 <20150908200809.GC21084@n2100.arm.linux.org.uk>
 <87mvwvurae.fsf@belgarion.home> <87egi6umi2.fsf@belgarion.home>
 <20150910191652.GJ21084@n2100.arm.linux.org.uk>
 <8737ymuhbc.fsf@belgarion.home>
Message-ID: <20150911095438.GL21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 10:53:43PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > I've been wondering whether we can teach GCC that set_domain modifies
> > the value that get_domain returns, rather than throwing a volatile
> > onto the asm in get_domain.  The issue with a volatile there is that
> > even if the result is unused, but the code is reachable, gcc still has
> > to output the code to read the register.
> >
> > We might be able to get away with a memory clobber on the set_domain,
> > and fake a memory read in get_domain, eg, by passing
> > 	"m" (current_thread_info()->cpu_domain))
> > to the get_domain asm.
> Ok, let's say we do it that way.
> 
> I have some concerns about it:
>   (a) I see an inbalance, as set_domain() doesn't actually modify
>       current_thread_info()->cpu_domain. I don't see how it will protect use
>       from this scenario :
>         - get_domain()
>         - set_domain()
>         - set_domain()

That should be fine, because if you've only got one get_domain(), then
you only get the value of the DACR once.

>   (b) domain.h is included from thread_info.h, not the other way around
>       => current_thread_info() is not accessible from domain.h
>       => that would require a bit of moving things around, as thread_info
>          structure description should be available for example.
>       This is currently my biggest problem with this approach.

It's not a problem since 1eef5d2f1b46 removed the need for domain.h to be
included by thread_info.h - the existing include can be dropped.

>   (c) I was also wondering if a case like this could happen :
>      - a function foo() does a get_domain()
>        => an exception/irq whatever happens and modifies the DACR

We always preserve the value of DACR across an exception.

>      - foo() continues a makes a modify_domain()
>        => and here the modify_domain() uses the old DACR value
>       Or said differently, I wonder if there is a case of 2 get_domain() calls
>       in a row with a DACR modification in between. I
> 
> What about something such as [1], without a memory clobber, but a "fake" memory
> variable link ?

The problem is the compiler will need to issue instructions to arrange
for the address of this variable to end up in registers even though the
assembly doesn't use it.

That's true of my suggestion as well, but looking at the callsites, we
generally already have, or very shortly there-after have the current
thread_info address in a register.

Patches to follow - I've not been able to confirm the instruction ordering
you've observed with my compiler, so I can't prove whether this solves
the problem locally.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
