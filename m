From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Mon, 5 Dec 2016 11:07:12 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <0293f7d3-b3d3-1a68-5b99-75db195eb796@redhat.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161130135631.GK1574@e103592.cambridge.arm.com>
 <dbcd545f-1358-6a80-5a9f-3e4a3c93189a@redhat.com>
 <20161201103048.GO1574@e103592.cambridge.arm.com>
 <0293f7d3-b3d3-1a68-5b99-75db195eb796@redhat.com>
Message-ID: <58454A60.7000206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/16 10:44, Florian Weimer wrote:
>>> By the way, how is this implemented?  Some of them overlap existing
>>> callee-saved registers.
>>
>> Basically, all the *new* state is caller-save.
>>
>> The Neon/FPSIMD regs V8-V15 are callee-save, so in the SVE view
>> Zn[bits 127:0] is callee-save for all n = 8..15.
> 
> Are the extension parts of registers v8 to v15 used for argument passing?
> 
> If not, we should be able to use the existing dynamic linker trampoline.
> 

if sve arguments are passed to a function then it
has special call abi (which is probably not yet
documented), this call abi requires that such a
call does not go through plt to avoid requiring
sve aware libc.

same for tls access: the top part of sve regs have
to be saved by the caller before accessing tls so
the tlsdesc entry does not have to save them.

so current trampolines should be fine.
