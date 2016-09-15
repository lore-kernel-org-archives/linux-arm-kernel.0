From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 15 Sep 2016 11:37:47 -0700
Subject: [RFC PATCH 2/8] thread_info: allow custom in-task thread_info
In-Reply-To: <1473947349-14521-3-git-send-email-mark.rutland@arm.com>
References: <1473947349-14521-1-git-send-email-mark.rutland@arm.com>
 <1473947349-14521-3-git-send-email-mark.rutland@arm.com>
Message-ID: <CALCETrWni0aZ71r-R6oYG98kZvZA8a184UR0YURk_=tXu8HXMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 6:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently, task_struct is defined in <linux/sched.h>, which (indirectly)
> pulls in a number of low-level arch headers such as <asm/preempt.h>
> through a number of other headers. Thus, code and structures in these
> headers can't rely on the definition of task_struct. Some of these
> headers are necessary for the definition of task_struct, so moving
> task_struct into its own header is insufficient tio avoid circular
> includes.

The flippant answer is to fix the headers, but I tried that myself and
gave up :(

But how about this slightly less duplicative alternative:

struct thread_info {
#ifdef arch_thread_info
  struct arch_thread_info arch_ti;
#endif
};
