From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Fri, 12 May 2017 07:28:02 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CA+55aFwvQfs_X+paQF6Luc0Rq+W3J2fKuHRou7=ANcquDdXdDA@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508075209.7aluvpwildw325rf@gmail.com>
 <1494256932.1167.1.camel@gmail.com>
 <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
 <20170509065619.wmqa6z6w3n6xpvrw@gmail.com>
 <20170509111007.GA14702@kroah.com>
 <CAJcbSZFswDWZoK-1UK+xkRMJ4ttSYbtH2Y5WD5_aPR-8ru6t8A@mail.gmail.com>
 <CAJcbSZEoRyewUtBHvqmNZL9FtT_q42Vmmd-EuC50x-ZRASiHHg@mail.gmail.com>
 <CA+55aFwvQfs_X+paQF6Luc0Rq+W3J2fKuHRou7=ANcquDdXdDA@mail.gmail.com>
Message-ID: <20170512072802.5a686f23@mschwideX1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 May 2017 16:44:07 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, May 11, 2017 at 4:17 PM, Thomas Garnier <thgarnie@google.com> wrote:
> >
> > Ingo: Do you want the change as-is? Would you like it to be optional?
> > What do you think?  
> 
> I'm not ingo, but I don't like that patch. It's in the wrong place -
> that system call return code is too timing-critical to add address
> limit checks.
> 
> Now what I think you *could* do is:
> 
>  - make "set_fs()" actually set a work flag in the current thread flags
> 
>  - do the test in the slow-path (syscall_return_slowpath).
> 
> Yes, yes, that ends up being architecture-specific, but it's fairly simple.
> 
> And it only slows down the system calls that actually use "set_fs()".
> Sure, it will slow those down a fair amount, but they are hopefully a
> small subset of all cases.
> 
> How does that sound to people?  Thats' where we currently do that
> 
>         if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
>             WARN(irqs_disabled(), "syscall %ld left IRQs disabled",
> regs->orig_ax))
>                 local_irq_enable();
> 
> check too, which is a fairly similar issue.

This is exactly what Heiko did for the s390 backend as a result of this
discussion. See the _CIF_ASCE_SECONDARY bit in arch/s390/kernel/entry.S,
for the hot patch the check for the bit is included in the general
_CIF_WORK test. Only the slow patch gets a bit slower.

git commit b5a882fcf146c87cb6b67c6df353e1c042b8773d
"s390: restore address space when returning to user space".

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
