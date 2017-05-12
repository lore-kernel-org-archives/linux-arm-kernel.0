From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 12 May 2017 22:41:44 +0100
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAGXu5jJu=VTqp2tzkPB4RAVxdGC+_SSQwrUwdzWpu24AA-zEcg@mail.gmail.com>
References: <CA+55aFwvQfs_X+paQF6Luc0Rq+W3J2fKuHRou7=ANcquDdXdDA@mail.gmail.com>
 <20170512072802.5a686f23@mschwideX1>
 <CAGXu5j+EatK=DYONRkgovwLgytAnbG8jnAZaMSLckZFNVj3gig@mail.gmail.com>
 <20170512075458.09a3a1ce@mschwideX1>
 <CAGXu5jL9vUrn4kpjO+qa4cHmWBypeqP17OGbrMs=5Nz0YpQMZw@mail.gmail.com>
 <CA+55aFzbiBqsYb7vwO=+L4Vp_GOgPu+DBOrq4fBnyzq5DbBehg@mail.gmail.com>
 <CAGXu5j+xmyJ6RhtPw9rUgs7k3sZ1KKWffvyGGG--oPfu9W42ng@mail.gmail.com>
 <20170512202106.GO22219@n2100.armlinux.org.uk>
 <20170512210645.GS390@ZenIV.linux.org.uk>
 <CAGXu5jJu=VTqp2tzkPB4RAVxdGC+_SSQwrUwdzWpu24AA-zEcg@mail.gmail.com>
Message-ID: <20170512214144.GT390@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 02:17:19PM -0700, Kees Cook wrote:

> Two things are at risk from stack exhaustion: thread_info (mainly
> addr_limit) when on the stack (fixed by THREAD_INFO_IN_TASK), and

Really?  Let's take a look at arm, for example:

struct thread_info {
        unsigned long           flags;          /* low level flags */
        int                     preempt_count;  /* 0 => preemptable, <0 => bug */
        mm_segment_t            addr_limit;     /* address limit */
        struct task_struct      *task;          /* main task structure */

and current() is defined as current_thread_info()->task.

Seriously, look at these beasts.  Overwriting ->addr_limit is nowhere near
the top threat.  If attacker can overwrite thread_info, you have lost.
