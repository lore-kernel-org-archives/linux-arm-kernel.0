From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Tue, 14 Apr 2015 11:33:13 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <2507322.zX46IY7aRK@wuerfel>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
Message-ID: <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

After getting a good night?s sleep, the ?reuse the existing system call table? comment
makes a little more sense as I construe it as having just one merged system call table
for both LP64 and ILP32 and handling the differences through a different system call
numbering in unistd.h towards LP64 and ILP32 processes.

If this is the intended implementation, I am not fully sold on the benefit: having a private
copy of unistd.h for ARM64 seems to be a less readable and less maintenance-friendly
solution to having separate tables.

We?re open to input on this and?if merging the system call tables is the consensus?
would like to get the change underway as soon as possible.

Cheers,
Phil.

> On 14 Apr 2015, at 00:58, Dr. Philipp Tomsich <philipp.tomsich@theobroma-systems.com> wrote:
> 
>> 2. The ABI follows what x86 has their "x32" ABI. This never saw a lot of
>> adoption and in retrospect the decision to have separate system calls seems
>> to not have helped them. My feeling now is that if we add support for the
>> ARM64 ILP32 ELF ABI, we should better stick to the existing system call ABI
>> as close as possible and reuse the existing system call table. I realize
>> that this is a bit controversial, but please let's talk about this now.
> 
> I see benefits and drawback to merging the system tables.  Our philosophy is
> already somewhat different from x32 and from the original patch-series, as you
> can see from the changes dealing with stack_t in the ?sys_rt_sigreturn' and 
> ?setup_rt_frame? functions.  While these could have been duplicated and 
> specialized for each ABI (as on x32), the attempt was made to keep these 
> changes localized.
> 
> However, this approach can not always work: if you consider cases like 
> ?sys_msgsnd? and ?compat_sys_msgsnd?, there?s little to no benefit in having
> just a ?aarch64_sys_msgsnd?, which then calls either the LP64 or the compat
> version of the underlying system call.  Having a second system call table 
> helps to reduce the overheads in this case and keeps things readable.
> 
> This comes down to the fact, that a few calls will always be different due to
> historical baggage in data structures shared between userspace and kernel:
> 'struct msgbuf? immediatly comes to mind.
> 
> I would liken the situation with ARM64 more of MIPS64 with its 64bit ABI and 
> its n32 ABI than to x32? but even there it?s two separate system call tables
> (although sequentially concatenated).
> 
> In other words: I fail to see the benefit from keeping the existing table.
> I you elaborate on how such a solution should look, I might be better able
> to follow. 
