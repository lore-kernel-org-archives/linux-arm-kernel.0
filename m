From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 22 Mar 2017 13:54:10 -0700
Subject: [PATCH v4 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
References: <20170322203834.67556-1-thgarnie@google.com>
 <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
Message-ID: <5c59808f-6518-f51b-ee71-891b71404fc8@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/17 13:44, Andy Lutomirski wrote:
> 
> While it's possible that silently papering over the bug is slightly
> faster than BUGging, it will allow bugs to continue to exist
> undetected.
> 

It would also allow the test to be inlined (at least on architectures
which have a one-site implementation) and have only the failure case out
of line, with a __noreturn annotation (which allows it to be jumped to
rather than called, which is usually available as a conditional
operation whereas call often isn't.)

That is...

extern void __noreturn __pre_usermode_state_invalid(void);

static void verify_pre_usermode_state(void)
{
	if (unlikely(!segment_eq(get_fs(), USER_DS))
		__pre_usermode_state_invalid();
}

	-hpa
