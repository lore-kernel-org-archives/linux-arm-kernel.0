From: wad@chromium.org (Will Drewry)
Date: Sat, 14 May 2011 15:58:00 -0500
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <201105132135.34741.arnd@arndb.de>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<201105132135.34741.arnd@arndb.de>
Message-ID: <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 2:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 12 May 2011, Will Drewry wrote:
>> This change adds a new seccomp mode based on the work by
>> agl at chromium.org in [1]. This new mode, "filter mode", provides a hash
>> table of seccomp_filter objects. ?When in the new mode (2), all system
>> calls are checked against the filters - first by system call number,
>> then by a filter string. ?If an entry exists for a given system call and
>> all filter predicates evaluate to true, then the task may proceed.
>> Otherwise, the task is killed (as per seccomp_mode == 1).
>
> I've got a question about this: Do you expect the typical usage to disallow
> ioctl()? Given that ioctl alone is responsible for a huge number of exploits
> in various drivers, while certain ioctls are immensely useful (FIONREAD,
> FIOASYNC, ...), do you expect to extend the mechanism to filter specific
> ioctl commands in the future?

In many cases, I do expect ioctl's to be dropped, but it's totally up
to whoever is setting the filters.

As is, it can already help out: [even though an LSM, if available,
would be appropriate to define a fine-grained policy]

ioctl() is hooked by the ftrace syscalls infrastructure (via SYSCALL_DEFINE3):

  SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned
long, arg)

This means you can do:
  sprintf(filter, "cmd == %u || cmd == %u", FIOASYNC, FIONREAD);
  prctl(PR_SET_SECCOMP_FILTER, __NR_ioctl, filter);
  ...
  prctl(PR_SET_SECCOMP, 2, 0);
and then you'll be able to call ioctl on any fd with any argument but
limited to only the FIOASYNC and FIONREAD commands.

Depending on integration, it could even be limited to ioctl commands
that are appropriate to a known fd if the fd is opened prior to
entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
with a filter of "1" then narrowed through a later addition of
something like "(fd == %u && (cmd == %u || cmd == %u))" or something
along those lines.

Does that make sense?

In general, this interface won't need specific extensions for most
system call oriented filtering events.  ftrace events may be expanded
(to include more system calls), but that's behind the scenes.  Only
arguments subject to time-of-check-time-of-use attacks (data living in
userspace passed in by pointer) are not safe to use via this
interface.  In theory, that limitation could also be lifted in the
implementation without changing the ABI.

Thanks!
will
