From: Andrew.Pinski@caviumnetworks.com (Pinski, Andrew)
Date: Tue, 14 Apr 2015 11:51:54 +0000
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <3234795.e0Uq9k2nUp@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <6C99D1ED-37A9-4E68-A137-BF8F78720BFE@caviumnetworks.com>,
 <3234795.e0Uq9k2nUp@wuerfel>
Message-ID: <8EFB0EC5-969B-40B1-BF72-359D9CB76B3F@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> On Apr 14, 2015, at 4:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Tuesday 14 April 2015 10:45:43 Pinski, Andrew wrote:
>>> On Apr 14, 2015, at 3:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> 
>>>> On Tuesday 14 April 2015 11:33:13 Dr.  Philipp Tomsich wrote:
>>>> Arnd,
>>>> 
>>>> After getting a good night?s sleep, the ?reuse the existing system call table? comment
>>>> makes a little more sense as I construe it as having just one merged system call table
>>>> for both LP64 and ILP32 and handling the differences through a different system call
>>>> numbering in unistd.h towards LP64 and ILP32 processes.
>>>> 
>>>> If this is the intended implementation, I am not fully sold on the benefit: having a private
>>>> copy of unistd.h for ARM64 seems to be a less readable and less maintenance-friendly
>>>> solution to having separate tables.
>>>> 
>>>> We?re open to input on this and?if merging the system call tables is the consensus?
>>>> would like to get the change underway as soon as possible.
>>> 
>>> There are multiple ways of doing this:
>>> 
>>> a) separate syscall table for arm64: as you say, this is the current approach,
>>>  and I'd like to avoid that too
>>> b) add syscalls for ilp32 as additional numbers in the normal lp64 version of
>>>  asm-generic/unistd.h, and share the binary tables between ilp32 and lp64
>>>  on aarch64
>>> c) change asm-generic/unistd.h to generate three possible tables: instead of
>>>  just native (lp64 or ilp32 depending on the arch), compat (support for
>>>  existing ilp32 binaries on some architectures, there would also be a
>>>  "modern" ilp32 variant that is a mix of the two, as your table today
>>> d) don't use the asm-generic/unistd.h table for aarch64-ilp32 at all, but instead
>>>  reuse the table from arch/arm64/include/asm/unistd32.h
>>> 
>>> I think you are referring to approach b) or c) above, but my preferred one
>>> would actually be d).
>> 
>> D is the worst of all 4 options in my mind. The reason is when a new syscall is
>> added, then you have to update that file too.
> 
> I don't know what the miscommunication is here, but the advantage of d is
> specifically that it is /less/ work to maintain: With the current approach,
> each new syscall that gets added needs to be checked to see if the normal
> aarch64 version works or if it needs another wrapper, while with d) we
> get the update for free, because we follow exactly what aarch32 is doing.

More than that d won't work due to ucontext being different between aarch32 and aarch64. I still say the current way is the best approach and is better option than the rest and it was what was agreed upon when I wrote the patch. I don't see why you are agreeing a different way. The split 64bit long was decided not to be split too, there was a previous discussion about that too. 

Also this abi is about to be used in a product so any changes need to happen fast and need to thought out why making changes to it make senses. Changing to use the aarch32 syscall #'s make less sense since this is not a legacy syscalls. 

> 
>> Also d is worse than the rest as
>> you no longer default to 64bit off_t which is not a good thing.
> 
> That decision is up to the libc implementation, just as it is for the existing
> aarch32 libc. The kernel just offers both versions and the libc can pick
> one, or use the _LARGEFILE64_SOURCE hack that glibc has to also implement
> both. It would probably be reasonable to use 64-bit off_t only for a libc
> and ignore the old calls.
> 
>> B is just as bad and goes against using the generic syscall numbers.
> 
> How so? The newly introduce syscalls then would be the generic ones.
> 
>> I was trying to model ilp32 so there was less maintain hassle if a new syscall was added. 
>> 
>> Also about time_t, my original patch had used 32bit but was asked to change
>> it to the 64bit one. So now I am upset this being asked again to change it back.
>> The review process for the linux kernel is much harder than the review process
>> of gcc or even glibc now.
> 
> For now, I'm just opening that discussion again, but the reason this
> comes up again now is that a lot has happened in the meantime on this
> front, and we have already decided to merge new architecture ports with
> 32-bit time_t since.
> 
>    Arnd
