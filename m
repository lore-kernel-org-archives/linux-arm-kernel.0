From: james.hogan@imgtec.com (James Hogan)
Date: Sun, 30 Oct 2016 00:06:07 +0100
Subject: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
In-Reply-To: <20161029214541.GA20037@yury-N73SV>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
 <2502005.4risrb1P1I@wuerfel> <20161029214541.GA20037@yury-N73SV>
Message-ID: <0B167874-4C33-4FEC-80AA-DC936AA56E4D@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2016 22:45:41 BST, Yury Norov <ynorov@caviumnetworks.com> wrote:
>On Sat, Oct 29, 2016 at 11:02:40PM +0200, Arnd Bergmann wrote:
>> On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
>> > The newer prlimit64 syscall provides all the functionality provided
>by
>> > the getrlimit and setrlimit syscalls and adds the pid of target
>process,
>> > so future architectures won't need to include getrlimit and
>setrlimit.
>> > 
>> > Therefore drop getrlimit and setrlimit syscalls from the generic
>syscall
>> > list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the
>architecture's
>> > unistd.h prior to including asm-generic/unistd.h, and adjust all
>> > architectures using the generic syscall list to define it so that
>no
>> > in-tree architectures are affected.
>> 
>> The patch looks good, but shouldn't we also hide the actual syscall
>> implementation if the symbol is not set? It's just dead code
>otherwise
>> for new architectures.
>
>I was thinking on it. The patch of James Hogan, b0da6d4415
>(asm-generic:
>Drop renameat syscall from default list) doesn't do it for renameat(),
>so
>I decided not to do it too. It's not so easy to disable syscalls
>because arch
>may support few ABIs, and some of them may require the syscall. For
>example,
>arm64 supports lp64, aarch32 and ilp32, and first two ABIs need
>renameat()
>and getrlimit/setrlimit.
>
>At now there's no arches that doesn't need renameat() and
>getrlimit/setrlimit,
>and there will be no such arch in nearest future. So there will be no
>dead code.
>
>But I agree with you that we need make that implementations 
>conditional. If I understand it correctly, we need something like
>__ARCH_WANT_SET_GET_RLIMIT in all existing Kconfigs, correct?
>
>I think this patch may be applied as is, and if needed I can send
>another patch that disables renameat() and getrlimit/setrlimit soon.
>
>James, what do you think?

For renameat my main concern was the ABI, and I didn't think it was worth the effort or slightly increased complexity to ifdef the implementation since it was such a trivial wrapper around renameat2. Getrlimit and setrlimit aren't much more complex, just a user copy in addition to the standard doprlimit, so i probably wouldn't have bothered for them either.

cheers
James Hogan
