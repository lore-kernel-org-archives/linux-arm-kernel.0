From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 12 May 2017 16:20:31 -0700
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <20170512071549.GP390@ZenIV.linux.org.uk>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com> <20170508124621.GA20705@kroah.com>
 <20170509064522.anusoikaalvlux3w@gmail.com>
 <20170509085659.GA32555@infradead.org>
 <CALCETrUh8NO2scaqEM48K70Fo2+V3=Cpyk4JurCDiCYp4nm_+g@mail.gmail.com>
 <20170512070012.7dysuhbkcas7ibaj@gmail.com>
 <20170512071549.GP390@ZenIV.linux.org.uk>
Message-ID: <CALCETrXMgx+pFsL-5s6jRHxsTCJk8U8f5AFMzchsy_L6DyMAvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 12:15 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Folks, seriously, have you even looked through that zoo?  I have, and it's
> really, really not fun.  Sure, we can say "fuck 'em, no need to allow
> splice() on random crap".  Would be perfectly reasonable, expect that
> it's not the only place doing kernel_write() and its ilk...

Can you clarify this?  I think we really may be able to do exactly
this.  From Christoph's list, there are only two things that need
kernel_read/kernel_write to user-supplied fds that may come from a
variety of sources: splice and exec.  If you're execing a chardev from
a crappy driver, something is seriously wrong.  And returning -EINVAL
from splice() to or from files that use ->read and ->write seems find
(and splice(2) even documents -EINVAL as meaning that the target
doesn't support splicing).

--Andy
