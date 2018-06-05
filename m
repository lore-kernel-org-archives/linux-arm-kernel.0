From: james.morse@arm.com (James Morse)
Date: Tue, 5 Jun 2018 18:40:43 +0100
Subject: How to print stack uses of IRQ in ARM64
In-Reply-To: <CAHp75VcTvMKy8h_2gztav2FOUvE1QG01FByTNmc=x0bdyRx5Dg@mail.gmail.com>
References: <CADSz7_cqdKnmOm07Ykv5L9d2qscfKNmf7Vz=yW2Nf8PWsnsJaA@mail.gmail.com>
 <CAHp75VcTvMKy8h_2gztav2FOUvE1QG01FByTNmc=x0bdyRx5Dg@mail.gmail.com>
Message-ID: <9686668a-2739-309d-fb02-55c8fd2b802d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishun,

(CC: +linux-arm-kernel list)

On 05/06/18 14:12, Andy Shevchenko wrote:
> On Thu, May 31, 2018 at 1:01 PM, Vishnu Motghare
> <vishnumotghare@gmail.com> wrote:
>> My understanding is each CPU  getting its own IRQ stack. So is it
>> possible to print the stack uses of each IRQ handler?

The stacks are per-cpu not per-handler, so you would get a jumble of different
interrupt-handlers, mixed up with softirq that runs on the same stack.


>> like, How much stack is used & how much left free ?

What would you do with the information?


>> like in process context we have API like stack_not_used(struct
>> task_struct *p) to get the unused stack  of processes.

Isn't this only printed when the process exits?
When would you print it for an irqstack?

To get this information you would need to mask interrupts, then search backwards
on the irq-stack to find the 'last' value. I think it would always be more
useful to take interrupts in that time...


>> So, is it possible to get the similar result for IRQ?

Probably, but I don't think its useful.
If you're debugging a stack-overflow, its much better to use vmap stacks, which
will give you the function and stack trace that triggered the overflow.


Thanks,

James
