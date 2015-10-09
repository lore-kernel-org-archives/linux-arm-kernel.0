From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 10 Oct 2015 00:48:22 +0100
Subject: [PATCH] sched_clock: add data pointer argument to read callback
In-Reply-To: <20151009232015.GC32536@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 10 Oct 2015 00:20:15 +0100")
References: <1444427858-576-1-git-send-email-mans@mansr.com>
 <20151009232015.GC32536@n2100.arm.linux.org.uk>
Message-ID: <yw1x4mhzioxl.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
>> This passes a data pointer specified in the sched_clock_register()
>> call to the read callback allowing simpler implementations thereof.
>> 
>> In this patch, existing uses of this interface are simply updated
>> with a null pointer.
>
> This is a bad description.  It tells us what the patch is doing,
> (which we can see by reading the patch) but not _why_.  Please include
> information on why the change is necessary - describe what you are
> trying to achieve.

Currently most of the callbacks use a global variable to store the
address of a counter register.  This has several downsides:

- Loading the address of a global variable can be more expensive than
  keeping a pointer next to the function pointer.

- It makes it impossible to have multiple instances of a driver call
  sched_clock_register() since the caller can't know which clock will
  win in the end.

- Many of the existing callbacks are practically identical and could be
  replaced with a common generic function if it had a pointer argument.

If I've missed something that makes this a stupid idea, please tell.

-- 
M?ns Rullg?rd
mans at mansr.com
