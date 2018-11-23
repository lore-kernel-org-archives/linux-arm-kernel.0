From: amonakov@ispras.ru (Alexander Monakov)
Date: Fri, 23 Nov 2018 17:06:38 +0300 (MSK)
Subject: Investigating a stack state mismatch in Linux kernel
In-Reply-To: <57225f38-3f6d-4029-8f89-4b6eba97c3c1@linux.com>
References: <b7aad232-76e1-241f-00e2-77783ce30f87@linux.com>
 <875zwyabac.fsf@oldenburg.str.redhat.com>
 <2a2b1181-2175-7e4e-189c-12630f43d10d@linux.com>
 <57225f38-3f6d-4029-8f89-4b6eba97c3c1@linux.com>
Message-ID: <alpine.LNX.2.20.13.1811231634330.6732@monopod.intra.ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 21 Nov 2018, Alexander Popov wrote:

> Hello everyone!
> 
> At irc.freenode.org/#gcc people told me that I should CC gcc at gcc.gnu.org to get
> some attention of gcc developers.
> 
> Link to previous discussion:
>  https://www.openwall.com/lists/kernel-hardening/2018/11/14/1

So just for information, it isn't a plugin bug. I'll elaborate below, but in
short, objtool was complaining about unreachable code.  To be fair though,
gcc could have made the problem easier to spot.

Now for the details.

The repro uses an unusual (randomized) kernel config, in particular gcov is
enabled and NR_CPUS is 1. Thus we have

static int duplicate_processor_ids[] = {
        [0 ... 1 - 1] = -1,
};

and the compiler deduces that the loop in acpi_duplicate_processor_id does not
iterate:

bool acpi_duplicate_processor_id(int proc_id)
{
        int i;

        for (i = 0; i < nr_duplicate_ids; i++) {
                if (duplicate_processor_ids[i] == proc_id)
                        return true;
        }
        return false;
}

However as gcov is enabled, loop backedge remains, followed by gcov counter
increment and __builtin_unreachable() (on GIMPLE). On RTL, however, the basic
block with the increment ends with a barrier rtx, which is not visible in
assembly and looks just as if control flow falls through to a function exit.
Since the exit in question corresponds to a shrink-wrapped early exit that
does not push/pop registers, objtool complains.

Ultimately this is poor luck, if gcc optimized the code better or terminated
the block that-should-not-be-reached with ud2, it would not arise.

Alexander
