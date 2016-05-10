From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 10 May 2016 15:05:15 +0100
Subject: [PATCH] arm64: kgdb: Match pstate size with gdbserver protocol
In-Reply-To: <20160510102838.GF22813@arm.com>
References: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
 <20160510102838.GF22813@arm.com>
Message-ID: <d1ef4da0-da9b-37f8-27e8-e28f2b94d611@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/16 11:28, Will Deacon wrote:
> Hi Daniel,
>
> So does kgdb do something useful after this patch?

On this occasion I was debugging it on behalf of another developer 
rather than trying to use it myself to debug something so I didn't do 
much additional testing beyond sanity tested the contents of the 
register set.

Naturally it will be *totally* awesome if I get the pseudo-NMI stuff 
working perfectly. ;-)


> On Mon, May 09, 2016 at 06:39:26PM +0100, Daniel Thompson wrote:
>> Current versions of gdb do not interoperate cleanly with kgdb on arm64
>> systems because gdb and kgdb do not use the same register description.
>> This patch modifies kgdb to work with recent releases of gdb (>= 7.8.1).
>>
>> Compatibility with gdb (after the patch is applied) is as follows:
>>
>>   gdb-7.6 and earlier  Ok
>>   gdb-7.7 series       Works if user provides custom target description
>>   gdb-7.8(.0)          Works if user provides custom target description
>>   gdb-7.8.1 and later  Ok
>>
>> When commit 44679a4f142b ("arm64: KGDB: Add step debugging support") was
>> introduced it was paired with a gdb patch that made an incompatible
>> change to the gdbserver protocol. This patch was eventually merged into
>> the gdb sources:
>> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=a4d9ba85ec5597a6a556afe26b712e878374b9dd
>>
>> The change to the protocol was mostly made to simplify big-endian support
>> inside the kernel gdb stub. Unfortunately the gdb project released
>> gdb-7.7.x and gdb-7.8.0 before the protocol incompatibility was identified
>> and reversed:
>> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=bdc144174bcb11e808b4e73089b850cf9620a7ee
>>
>> This leaves us in a position where kgdb still uses the no-longer-used
>> protocol; gdb-7.8.1, which restored the original behaviour,If was
>> released on 2014-10-29.
>>
>> I don't believe it is possible to detect/correct the protocol
>> incompatiblity which means the kernel must take a view about which
>> version of the gdb remote protocol is "correct". This patch takes the
>> view that the original/current version of the protocol is correct
>> and that version found in gdb-7.7.x and gdb-7.8.0 is anomalous.
>
> Urgh, this is filthy! Still, without a time machine, I guess there's
> little we can do about it. Can I ask you to respin the patch but with
> the rationale as a comment in the header file, and a pointer to the
> comment from the C code too, please?
>
> The code looks incorrect after this change, so we should justify how
> we've ended up in this state and not everybody looks at the git log
> for that rationale.

Will do.


Daniel.
